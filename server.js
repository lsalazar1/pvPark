const express = require('express');
const connectDB = require('./config/db');

// Initialize express module within app variable
const app = express();

// PORT varibale is initialized with the default of 5000 or some value passed in from .env file
const PORT = process.env.PORT || 5000;

// Connect to Database
connectDB();

// Initialize Middleware to recognize JSON
app.use(express.json({ extended: false }));

// Simple HTTP GET request that returns a string for the response
app.get('/', (req, res) => res.send('API Test'));

// Defines different routes
app.use('/api/users', require('./routes/apis/users'));
app.use('/api/auth', require('./routes/apis/auth'));
app.use('/api/srcollins', require('./routes/apis/srcollins'));
app.use('/api/newscience', require('./routes/apis/newscience'));

// Activate express on port decalred... 
app.listen(PORT, () => console.log(`Server active on Port ${PORT}`));