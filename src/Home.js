import React from 'react';
import ImageSlider from './ImageSlider';
import { useNavigate, Link } from 'react-router-dom';
import Card from 'react-bootstrap/Card';
import Col from 'react-bootstrap/Col';
import Row from 'react-bootstrap/Row';

const Home = () => {
    const navigate = useNavigate();

    const handleFindHobbiesClick = () => {
        navigate('/hobbies');
    };

    // Static articles with images and links
    const articles = [
        {
            title: "Gardening",
            img: "/images/gardening.jpg", // Ensure these images are in the public folder
            link: "https://en.wikipedia.org/wiki/Gardening",
        },
        {
            title: "Photography",
            img: "/images/photography.jpg",
            link: "https://en.wikipedia.org/wiki/Photography",
        },
        {
            title: "Painting",
            img: "/images/painting.jpg",
            link: "https://en.wikipedia.org/wiki/Painting",
        },
        {
            title: "Cooking",
            img: "/images/cooking.jpg",
            link: "https://en.wikipedia.org/wiki/Cooking",
        },
        {
            title: "Hiking",
            img: "/images/hiking.jpg",
            link: "https://en.wikipedia.org/wiki/Hiking",
        },
        {
            title: "Writing",
            img: "/images/writing.jpg",
            link: "https://en.wikipedia.org/wiki/Writing",
        },
    ];

    return (
        <div className="home">
            <ImageSlider />
            <div className="background-section" style={{ backgroundImage: 'url("https://example.com/background.jpg")', padding: '50px', color: 'white', textAlign: 'center' }}>
                <h2>Discover Your Next Hobby!</h2>
                <button onClick={handleFindHobbiesClick} style={{ padding: '10px 20px', fontSize: '16px' }}>Find Hobbies</button>
            </div>
            <div className="articles">
                <h2>Latest Articles on Hobbies</h2>
                <Row xs={1} md={3} className="g-4">
                    {articles.map((article, index) => (
                        <Col key={index}>
                            <Card>
                                <Link to={article.link} target="_blank" rel="noopener noreferrer">
                                    <Card.Img variant="top" src={process.env.PUBLIC_URL + article.img} alt={article.title} />
                                </Link>
                                <Card.Body>
                                    <Card.Title>{article.title}</Card.Title>
                                </Card.Body>
                            </Card>
                        </Col>
                    ))}
                </Row>
            </div>
        </div>
    );
};

export default Home;
