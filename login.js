// DOM Elements
const loginForm = document.getElementById('login-form');
const loginMessage = document.getElementById('login-message');

// Function to get saved carts from localStorage
function getSavedCart(username) {
    const cartData = localStorage.getItem(`cart_${username}`);
    return cartData ? JSON.parse(cartData) : [];
}

// Function to save cart for a user
function saveCart(username, cart) {
    localStorage.setItem(`cart_${username}`, JSON.stringify(cart));
}

// Handle login or registration
loginForm.addEventListener('submit', (e) => {
    e.preventDefault();

    const username = document.getElementById('username').value.trim();
    const password = document.getElementById('password').value.trim();

    if (!username || !password) {
        loginMessage.textContent = 'Please provide both username and password.';
        loginMessage.style.color = 'red';
        return;
    }

    // Get existing users or initialize an empty object
    const users = JSON.parse(localStorage.getItem('users')) || {};

    if (users[username]) {
        // Validate password
        if (users[username] !== password) {
            loginMessage.textContent = 'Incorrect password. Please try again.';
            loginMessage.style.color = 'red';
            return;
        }
        loginMessage.textContent = `Welcome back, ${username}!`;
    } else {
        // Register a new user
        users[username] = password;
        localStorage.setItem('users', JSON.stringify(users));
        loginMessage.textContent = `Account created successfully. Welcome, ${username}!`;
    }

    loginMessage.style.color = 'green';

    // Save the current user and load their saved cart
    localStorage.setItem('currentUser', username);
    const savedCart = getSavedCart(username);
    localStorage.setItem('cart', JSON.stringify(savedCart)); // Set the user's cart

    // Redirect to the homepage after a delay
    setTimeout(() => {
        window.location.href = 'index.html';
    }, 2000);
});
