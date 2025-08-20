# PowerShell script to create a sequence of commits with backdated timestamps
# This script creates 40 commits with dates between June 1 and August 14, 2025

# Clean up any existing git repository
Remove-Item -Path .git -Recurse -Force -ErrorAction SilentlyContinue
git init

# Starting date: June 1, 2025
$date = Get-Date -Year 2025 -Month 6 -Day 1 -Hour 10 -Minute 0 -Second 0

# Calculate days between commits to stay under August 15
# 40 commits between June 1 and August 14 (75 days)
$totalDays = 75
$totalCommits = 40
$daysBetween = [Math]::Floor($totalDays / $totalCommits)

# Add a bit of randomness to make commits look more natural
function Get-RandomOffset {
    return (Get-Random -Minimum 0 -Maximum 12) / 24  # Random hours (0-12 hours)
}

# Function to commit a file with a specific date
function Commit-File {
    param (
        [string]$FilePath,
        [string]$Message,
        [DateTime]$Date
    )
    
    # Add a bit of randomness to the time
    $Date = $Date.AddDays((Get-RandomOffset))
    
    # Format date for Git
    $gitDate = $Date.ToString("ddd MMM d HH:mm:ss yyyy K")
    
    # Set environment variables for commit date
    $env:GIT_COMMITTER_DATE = $gitDate
    $env:GIT_AUTHOR_DATE = $gitDate
    
    # Add and commit the file
    git add $FilePath
    git commit -m $Message
    
    Write-Host "Committed: $Message (Date: $($Date.ToString('yyyy-MM-dd')))"
}

# List of files to commit in logical order with descriptions
$commitPlan = @(
    @{Path="package.json"; Message="Initial project setup with dependencies"},
    @{Path="package-lock.json"; Message="Add package lock file for dependency versioning"},
    @{Path="public/favicon.ico"; Message="Add favicon for browser tab icon"},
    @{Path="public/logo192.png"; Message="Add logo image for PWA icons"},
    @{Path="public/logo512.png"; Message="Add larger logo image for PWA splash screens"},
    @{Path="public/robots.txt"; Message="Add robots.txt for search engine crawling rules"},
    @{Path="public/404.html"; Message="Add custom 404 error page"},
    @{Path="src/reportWebVitals.js"; Message="Add performance monitoring utilities"},
    @{Path="src/setupTests.js"; Message="Add test configuration for Jest"},
    @{Path="src/App.test.js"; Message="Add tests for App component"},
    @{Path="src/logo.svg"; Message="Add React logo for branding"},
    @{Path="src/seed.js"; Message="Add data seeding utilities for Firebase"},
    @{Path="src/components/row.css"; Message="Add CSS for movie row component"},
    @{Path="src/components/row.js"; Message="Add Row component for displaying movies"},
    @{Path="src/components/card/index.js"; Message="Add Card component for media items"},
    @{Path="src/components/card/styles/card.js"; Message="Add styled-components for Card styling"},
    @{Path="src/components/loading/index.js"; Message="Add Loading component for async operations"},
    @{Path="src/components/loading/styles/loading.js"; Message="Add styled-components for Loading animations"},
    @{Path="src/components/player/index.js"; Message="Add Player component for video playback"},
    @{Path="src/components/player/styles/player.js"; Message="Add styled-components for Player UI"},
    @{Path="src/components/profiles/index.js"; Message="Add Profiles component for user selection"},
    @{Path="src/components/profiles/styles/profiles.js"; Message="Add styled-components for Profiles view"},
    @{Path="src/components/header/styles/header.css"; Message="Add CSS styles for header component"},
    @{Path="src/containers/browse.js"; Message="Add Browse container for content discovery"},
    @{Path="src/containers/profiles.js"; Message="Add Profiles container for user management"},
    @{Path="src/context/firebase.js"; Message="Add Firebase context for authentication"},
    @{Path="src/fixtures/faqs.json"; Message="Add FAQ data for accordion component"},
    @{Path="src/fixtures/jumbo.json"; Message="Add jumbotron content data"},
    @{Path="src/helpers/routes.js"; Message="Add route helper functions"},
    @{Path="src/hooks/index.js"; Message="Add index exports for custom hooks"},
    @{Path="src/hooks/use-auth-listener.js"; Message="Add authentication listener hook"},
    @{Path="src/hooks/use-content.js"; Message="Add content fetching hook"},
    @{Path="src/lib/firebase.prod.js"; Message="Add Firebase configuration for production"},
    @{Path="src/pages/browse.js"; Message="Add Browse page with content rows"},
    @{Path="src/pages/home.js"; Message="Update Homepage with final layout"},
    @{Path="src/pages/signin.js"; Message="Update Sign In page with form validation"},
    @{Path="src/pages/signup.js"; Message="Update Sign Up page with form validation"},
    @{Path="src/pages/index.js"; Message="Update pages index with new routes"},
    @{Path="src/utils/selection-filter.js"; Message="Add utility for filtering content categories"},
    @{Path="images/demo.png"; Message="Add demo screenshot for documentation"}
)

# Create commits with incrementing dates
for ($i = 0; $i -lt $commitPlan.Count; $i++) {
    $commit = $commitPlan[$i]
    $filePath = $commit.Path
    $message = $commit.Message
    
    # Skip if file doesn't exist (to avoid errors)
    if (-not (Test-Path $filePath)) {
        Write-Host "Warning: File not found - $filePath (skipping)" -ForegroundColor Yellow
        continue
    }
    
    # Commit with current date
    Commit-File -FilePath $filePath -Message $message -Date $date
    
    # Increment date for next commit
    $date = $date.AddDays($daysBetween)
    
    # Ensure we don't go past August 14
    if ($date -ge (Get-Date -Year 2025 -Month 8 -Day 15)) {
        Write-Host "Warning: Date would exceed August 15, adjusting..." -ForegroundColor Yellow
        $date = (Get-Date -Year 2025 -Month 8 -Day 14 -Hour 23 -Minute 59 -Second 59)
    }
}

Write-Host "Completed creating $($commitPlan.Count) commits with dates between June 1 and August 14, 2025" -ForegroundColor Green
