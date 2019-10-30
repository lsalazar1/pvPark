const express = require('express');

// Initialize express module within app variable
const app = express();

app.get('/', (req, res) => res.send('API Test'));

// PORT varibale is initialized with the default of 5000 or some value passed in from .env file
const PORT = process.env.PORT || 5000;

// Listen into a port number provided by the variable PORT
app.listen(PORT, () => console.log(`Server active on Port ${PORT}`));