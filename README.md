# GroceryList-App

The Grocery WebApp streamlines grocery list management with features like creating, organizing, and printing lists, sorting items by category, searching for products, and managing quantities. Administrators can update product details, manage categories, and oversee user accounts through a control panel. The app integrates with databases like PostgressSQL using PgAdmin for data storage and uses real-time updates. Designed for responsiveness, it ensures a seamless experience across devices while prioritizing security, reliability, and efficient performance to make grocery shopping more convenient.


# Features
1. User registration and login.
2. Browse available grocery items.
3. Add items to the cart and manage quantities.
4. Compare item prices across multiple stores.
5. Responsive and user-friendly interface.

# Tech Stack
1. Frontend: HTML, CSS, JavaScript
2. Backend: Node.js with Express.js
3. Database: PostgreSQL

# Setup Instructions

# Prerequisites
1. Install Node.js (v14 or higher).
2. Install PostgreSQL (v12 or higher).

# Backend Setup

# Install dependencies:
1. npm install

2. Update server.js with your PostgreSQL credentials:
const pool = new Pool({
    user: 'grocery_user',
    host: 'localhost',
    database: 'grocery',
    password: 'yourpassword',
    port: 5432,
});

3. Start the server:
node server.js

# Frontend Setup
1. Open index.html in your browser to access the main page.
Navigate to:
1. cart.html: View and manage your cart.
2. comparison.html: Compare prices across stores.

# Usage

# User Registration
1. Open login.html.
2. Register with a username and password.
3. Log in to access the app.

# Browse Items
View available items on the main page (index.html).

# Add Items to Cart
Click "Add to Cart" for any item on the main page.

# View Cart
Navigate to cart.html to view and manage items in your cart.

# Compare Prices
1. Navigate to comparison.html.
2. Select an item from the dropdown menu to see store-specific prices.

# API Endpoints

# User Authentication:
1. POST /register: Register a new user.
2. POST /login: Log in an existing user.

# Item Management:
GET /item: Fetch all available items.

# Cart Management:
1. POST /cart: Add an item to the cart.
2. DELETE /cart: Remove an item from the cart.
3. GET /cart/:userId: Fetch cart items for a specific user.
# Price Comparison:
GET /compare/:itemId: Fetch store-specific prices for a given item.
