let allItems = [];
let cart = [];
// DOM Elements for Login
const loginModal = document.getElementById('login-modal');
const userIcon = document.getElementById('user-icon');
const closeModal = document.getElementById('close-modal');
const usernameDisplay = document.getElementById('username-display');
const loginForm = document.getElementById('login-form');

// Function to save the cart to localStorage
function saveCartToLocalStorage() {
    const currentUser = localStorage.getItem('currentUser');
    if (currentUser) {
        localStorage.setItem(`cart_${currentUser}`, JSON.stringify(cart));
    }
}

// Fetch and render items
// Fetch items from the backend
async function fetchItems() {
    try {
        const response = await fetch('http://localhost:3000/api/items');
        if (!response.ok) {
            throw new Error('Failed to fetch items');
        }
        allItems = await response.json(); // Save items globally
        renderItems(allItems); // Render all items initially
    } catch (error) {
        console.error('Error fetching items:', error);
    }
}

function renderItems(items) {
    const container = document.getElementById('items-container');
    container.innerHTML = items.length
        ? items.map(item => `
            <div class="item-card">
                <img src="${item.image}" alt="${item.name}" class="item-image">
                <h3>${item.name}</h3>
                <p>Category: ${item.category}</p>
                <p>Price: $${item.price.toFixed(2)}</p>
                <button class="add-to-cart" data-id="${item.id}">Add to Cart</button>
            </div>`).join('')
        : '<p>No items found</p>';
    
    document.querySelectorAll('.add-to-cart').forEach(button =>
        button.addEventListener('click', addToCart)
    );
}

function addToCart(event) {
    const itemId = parseInt(event.target.dataset.id);
    const item = allItems.find(item => item.id === itemId);
    const cartItem = cart.find(cartItem => cartItem.id === itemId);

    if (cartItem) {
        cartItem.quantity += 1;
    } else {
        cart.push({ ...item, quantity: 1 });
    }

    saveCartToLocalStorage();
    renderCart();
}

function renderCart() {
    const container = document.getElementById('cart-container');
    container.innerHTML = cart.length
        ? cart.map(cartItem => `
            <div class="cart-item">
                <img src="${cartItem.image}" alt="${cartItem.name}" class="cart-item-image">
                <h3>${cartItem.name}</h3>
                <p>Price: $${cartItem.price.toFixed(2)}</p>
                <p>Quantity: 
                    <button class="decrease-quantity" data-id="${cartItem.id}">-</button>
                    ${cartItem.quantity}
                    <button class="increase-quantity" data-id="${cartItem.id}">+</button>
                </p>
                <button class="remove-from-cart" data-id="${cartItem.id}">Remove</button>
            </div>`).join('')
        : '<p>Your cart is empty!</p>';

    document.querySelectorAll('.increase-quantity').forEach(button =>
        button.addEventListener('click', increaseQuantity)
    );
    document.querySelectorAll('.decrease-quantity').forEach(button =>
        button.addEventListener('click', decreaseQuantity)
    );
    document.querySelectorAll('.remove-from-cart').forEach(button =>
        button.addEventListener('click', removeFromCart)
    );
}

function increaseQuantity(event) {
    const itemId = parseInt(event.target.dataset.id);
    const cartItem = cart.find(cartItem => cartItem.id === itemId);
    if (cartItem) cartItem.quantity += 1;
    saveCartToLocalStorage();
    renderCart();
}

function decreaseQuantity(event) {
    const itemId = parseInt(event.target.dataset.id);
    const cartItem = cart.find(cartItem => cartItem.id === itemId);
    if (cartItem.quantity > 1) {
        cartItem.quantity -= 1;
    } else {
        cart = cart.filter(cartItem => cartItem.id !== itemId);
    }
    saveCartToLocalStorage();
    renderCart();
}

function removeFromCart(event) {
    const itemId = parseInt(event.target.dataset.id);
    cart = cart.filter(cartItem => cartItem.id !== itemId);
    saveCartToLocalStorage();
    renderCart();
}

userIcon.addEventListener('click', () => {
    const currentUser = localStorage.getItem('currentUser');
    if (currentUser) {
        alert(`You are logged in as ${currentUser}`);
    } else {
        loginModal.classList.remove('hidden');
    }
});

closeModal.addEventListener('click', () => {
    loginModal.classList.add('hidden');
});

document.getElementById('login-form').addEventListener('submit', (e) => {
    e.preventDefault();
    const username = document.getElementById('username').value.trim();
    const password = document.getElementById('password').value.trim();

    const users = JSON.parse(localStorage.getItem('users') || '{}');
    if (!users[username]) {
        users[username] = password;
        localStorage.setItem('users', JSON.stringify(users));
    } else if (users[username] !== password) {
        alert('Incorrect password.');
        return;
    }

    localStorage.setItem('currentUser', username);
    usernameDisplay.textContent = username;
    loginModal.classList.add('hidden');
});

document.addEventListener('DOMContentLoaded', () => {
    fetchItems();
    const currentUser = localStorage.getItem('currentUser');
    if (currentUser) {
        usernameDisplay.textContent = currentUser;
        cart = JSON.parse(localStorage.getItem(`cart_${currentUser}`) || '[]');
    }
    renderCart();
});



// Show login modal on user icon click
userIcon.addEventListener('click', () => {
    const currentUser = localStorage.getItem('currentUser');
    if (currentUser) {
        alert(`You are already logged in as ${currentUser}`);
    } else {
        loginModal.classList.remove('hidden');
    }
});

// Close login modal
closeModal.addEventListener('click', () => {
    loginModal.classList.add('hidden');
});

// Handle login/register form submission
loginForm.addEventListener('submit', (e) => {
    e.preventDefault();

    const username = document.getElementById('username').value.trim();
    const password = document.getElementById('password').value.trim();

    if (!username || !password) {
        alert('Please provide both username and password.');
        return;
    }

    const users = JSON.parse(localStorage.getItem('users')) || {};
    if (users[username]) {
        if (users[username] !== password) {
            alert('Incorrect password.');
            return;
        }
        alert(`Welcome back, ${username}!`);
    } else {
        users[username] = password;
        localStorage.setItem('users', JSON.stringify(users));
        alert(`Account created successfully. Welcome, ${username}!`);
    }

    localStorage.setItem('currentUser', username);
    usernameDisplay.textContent = username;
    loginModal.classList.add('hidden');
});

// Show username if already logged in
document.addEventListener('DOMContentLoaded', () => {
    const currentUser = localStorage.getItem('currentUser');
    if (currentUser) {
        usernameDisplay.textContent = currentUser;
    }
});

// DOM Elements
const logoutButton = document.getElementById('logout-button');

// Show logout button if logged in
document.addEventListener('DOMContentLoaded', () => {
    const currentUser = localStorage.getItem('currentUser');
    if (currentUser) {
        usernameDisplay.textContent = currentUser;
        logoutButton.classList.remove('hidden');
    }
});

// Logout functionality
logoutButton.addEventListener('click', () => {
    localStorage.removeItem('currentUser'); // Remove user info
    localStorage.removeItem('cart'); // Clear the current cart
    alert('You have been logged out.');
    location.reload(); // Refresh the page to reset UI
});
