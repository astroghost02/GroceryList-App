const express = require('express');
const { Pool } = require('pg');
const cors = require('cors');

// Initialize the app
const app = express();
app.use(cors());
app.use(express.json()); // Parse JSON bodies

// Configure PostgreSQL connection
const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'final_project',
    password: '10102002pokemon',
    port: 5432, // Default PostgreSQL port
});

// API Endpoint to Fetch Items
app.get('/api/item', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM item');
        res.json(result.rows);
    } catch (error) {
        console.error('Error fetching items:', error);
        res.status(500).send('Server error');
    }
});

// Start the server
const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
