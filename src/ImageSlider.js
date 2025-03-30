import React, { useState, useEffect } from 'react';
import './Styles.css'; // Make sure to import your CSS file

const images = [
    { url: '/images/hobby1.avif' },
    { url: '/images/hobby2.avif' },
    { url: '/images/hobby3.avif' },
];

const ImageSlider = () => {
    const [index, setIndex] = useState(0);

    useEffect(() => {
        const interval = setInterval(() => {
            setIndex((prevIndex) => (prevIndex + 1) % images.length);
        }, 3000); // Change image every 3 seconds

        return () => clearInterval(interval);
    }, []);

    return (
        <div className="slideshow">
            <img 
                src={images[index].url} 
                alt="Hobby" 
                className="slider-image" // Use the CSS class
            />
        </div>
    );
};

export default ImageSlider;
