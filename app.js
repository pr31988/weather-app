const express = require('express');
const axios = require('axios');
require('dotenv').config();

const app = express();
const port = 3000;

app.get("/", (req, res) => {
  res.redirect("/weather");
});

app.get('/weather', async (req, res) => {
    const city = req.query.city || 'London';
    
    try {
        const response = await axios.get(`https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${process.env.OPENWEATHER_API_KEY}&units=metric`);
        res.json({
            city: response.data.name,
            temperature: response.data.main.temp,
            description: response.data.weather[0].description
        });
    } catch (error) {
        res.status(500).json({ error: 'Failed to fetch weather data' });
    }
});

app.listen(port, () => {
    console.log(`Weather app listening at http://localhost:${port}`);
});