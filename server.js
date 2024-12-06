const express = require('express');
const bodyParser = require('body-parser');
const { Pool } = require('pg');
const cors = require('cors');

const app = express();
app.use(bodyParser.json());
app.use(cors());

// PostgreSQL connection setup
const pool = new Pool({
  user: 'postgres', // Replace with your PostgreSQL username
  host: 'localhost',
  database: 'grocery',
  password: 'astro10125', // Replace with your PostgreSQL password
  port: 5432,
});

// API to register a new user
app.post('/register', async (req, res) => {
  const { username, password } = req.body;
  try {
    // Check if the username already exists
    const userCheck = await pool.query('SELECT * FROM public.user_name WHERE username = $1', [username]);
    if (userCheck.rows.length > 0) {
      return res.status(400).send('Username already exists');
    }

    // Insert new user into the database
    await pool.query(
      'INSERT INTO public.user_name (username, password, email) VALUES ($1, $2, $3)',
      [username, password, `${username}@example.com`] // Dummy email for simplicity
    );
    res.status(201).send('User registered successfully');
  } catch (err) {
    console.error(err);
    res.status(500).send('Error registering user');
  }
});

// API to handle user login
app.post('/login', async (req, res) => {
  const { username, password } = req.body;
  try {
    const result = await pool.query(
      'SELECT * FROM public.user_name WHERE username = $1 AND password = $2',
      [username, password]
    );
    if (result.rows.length > 0) {
      res.status(200).json({ message: 'Login successful', user: result.rows[0] });
    } else {
      res.status(401).send('Invalid credentials');
    }
  } catch (err) {
    console.error(err);
    res.status(500).send('Error logging in');
  }
});

app.get('/item', async (req, res) => {
    try {
      const result = await pool.query('SELECT * FROM public.item'); // Ensure 'item' table exists
      res.json(result.rows); // Send all rows as JSON response
    } catch (err) {
      console.error('Error fetching items:', err);
      res.status(500).send('Error fetching items');
    }
  });

app.post('/cart', async (req, res) => {
    const { userId, itemId, quantity } = req.body;
    try {
      await pool.query(
        'INSERT INTO public.cart (user_id, item_id, quantity) VALUES ($1, $2, $3) ON CONFLICT (user_id, item_id) DO UPDATE SET quantity = cart.quantity + $3',
        [userId, itemId, quantity]
      );
      res.status(201).send('Item added to cart successfully');
    } catch (err) {
      console.error('Error adding item to cart:', err);
      res.status(500).send('Error adding item to cart');
    }
});

app.delete('/cart', async (req, res) => {
    const { userId, itemId } = req.body;
    try {
      await pool.query(
        'DELETE FROM public.cart WHERE user_id = $1 AND item_id = $2',
        [userId, itemId]
      );
      res.status(200).send('Item removed from cart successfully');
    } catch (err) {
      console.error('Error removing item from cart:', err);
      res.status(500).send('Error removing item from cart');
    }
});

app.get('/cart/:userId', async (req, res) => {
    const { userId } = req.params;
    try {
      const result = await pool.query(
        `SELECT c.item_id, i.item_name, c.quantity, i.price 
         FROM public.cart c 
         JOIN public.item i ON c.item_id = i.item_id 
         WHERE c.user_id = $1`,
        [userId]
      );
      res.json(result.rows);
    } catch (err) {
      console.error('Error fetching cart:', err);
      res.status(500).send('Error fetching cart');
    }
});

app.get('/compare/:itemId', async (req, res) => {
    const { itemId } = req.params;
  
    try {
      const result = await pool.query(
        `SELECT s.store_name, p.price 
         FROM public.prices p 
         JOIN public.stores s ON p.store_id = s.store_id 
         WHERE p.item_id = $1`,
        [itemId]
      );
  
      if (result.rows.length === 0) {
        return res.status(404).json({ message: 'No prices found for this item.' });
      }
  
      res.json(result.rows);
    } catch (err) {
      console.error('Error fetching comparison data:', err);
      res.status(500).json({ message: 'Internal server error' });
    }
});

// Start the server
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});