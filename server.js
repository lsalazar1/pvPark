const express = require('express');
const connectDB = require('./config/db');

// Initialize express module within app variable
const app = express();

// Connect to Database
connectDB();

// Initialize Middleware ...
app.use(express.json({ extended: false }));

// Simple HTTP GET request that returns a string for the response
app.get('/', (req, res) => res.send('API Test'));

// Defines different routes
app.use('/api/users', require('./routes/apis/users'));
app.use('/api/auth', require('./routes/apis/auth'));

// PORT varibale is initialized with the default of 5000 or some value passed in from .env file
const PORT = process.env.PORT || 5000;

// Listen into a port number provided by the variable PORT
app.listen(PORT, () => console.log(`Server active on Port ${PORT}`));