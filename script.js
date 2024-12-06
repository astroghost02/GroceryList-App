let allItems = [];
let cart = [];

// Fetch and render items
async function fetchItems() {
    try {
      const response = await fetch('http://localhost:3000/item'); // Ensure this matches your backend URL
      if (!response.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }
      const items = await response.json(); // Parse JSON response
      console.log(items); // Debugging: Log items to ensure data is received
      renderItems(items); // Pass items to render function
    } catch (error) {
      console.error('Error fetching items:', error);
    }
  }

function renderItems(items) {
    const container = document.getElementById('items-container');

    if (!items.length) {
        container.innerHTML = '<p>No items found</p>';
        return;
    }

    container.innerHTML = items.map(item => `
        <div class="item">
        <h3>${item.item_name}</h3>
        <p>Price: $${parseFloat(item.price).toFixed(2)} per ${item.unit}</p>
        <p>Category ID: ${item.category_id}</p>
        <button class="add-to-cart" data-id="${item.item_id}">Add to Cart</button>
        </div>
    `).join('');

    document.querySelectorAll('.add-to-cart').forEach(button =>
        button.addEventListener('click', addToCart)
    );
}

async function addToCart(event) {
    const itemId = parseInt(event.target.dataset.id);
    const currentUser = JSON.parse(localStorage.getItem('currentUser'));
    
    if (!currentUser) return alert('Please log in first');
  
    try {
      await fetch('http://localhost:3000/cart', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ userId: currentUser.user_id, itemId: itemId, quantity: 1 }),
      });
      alert('Item added to cart');
    } catch (error) {
      console.error('Error adding to cart:', error);
    }
}

async function fetchCart() {
    const currentUser = JSON.parse(localStorage.getItem('currentUser'));
  
    if (!currentUser) return alert('Please log in first');
  
    try {
      const response = await fetch(`http://localhost:3000/cart/${currentUser.user_id}`);
      const cartItems = await response.json();
      
      const container = document.getElementById('cart-container');
      
      if (!cartItems.length) {
        container.innerHTML = '<p>Your cart is empty!</p>';
        return;
      }
  
      container.innerHTML = cartItems.map(item => `
        <div class="cart-item">
          <h4>${item.item_name}</h4>
          <p>Quantity: ${item.quantity}</p>
          <p>Price per unit: $${item.price}</p>
          Total Price: $${(item.quantity * item.price).toFixed(2)}
          <button onclick="removeFromCart(${item.item_id})">Remove</button>
        </div>`).join('');
      
    } catch (error) {
      console.error('Error fetching cart:', error);
    }
}

async function removeFromCart(itemId) {
    const currentUser = JSON.parse(localStorage.getItem('currentUser'));
  
    if (!currentUser) return alert('Please log in first');
  
    try {
      await fetch('http://localhost:3000/cart', {
        method: 'DELETE',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ userId: currentUser.user_id, itemId }),
      });
      alert('Item removed from cart');
      fetchCart(); // Refresh the cart after removal
    } catch (error) {
      console.error('Error removing from cart:', error);
    }
}

async function populateItemSelect() {
    try {
      const response = await fetch('http://localhost:3000/item');
      const items = await response.json();
  
      const select = document.getElementById('item-select');
      select.innerHTML = '<option value="">Select an Item</option>';
  
      items.forEach(item => {
        const option = document.createElement('option');
        option.value = item.item_id;
        option.textContent = item.item_name;
        select.appendChild(option);
      });
      
    } catch (error) {
      console.error('Error populating item select:', error);
    }
}

async function fetchComparison(itemId) {
  console.log(`Fetching comparison data for item ID: ${itemId}`); // Debugging log

  const spinner = document.getElementById('loading-spinner');
  const tbody = document.querySelector('#comparison-table tbody');

  if (!itemId) {
    tbody.innerHTML = '<tr><td colspan="2">Please select an item to compare prices.</td></tr>';
    return;
  }

  try {
    spinner.classList.remove('hidden'); // Show spinner

    const response = await fetch(`http://localhost:3000/compare/${itemId}`);
    if (!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }

    const prices = await response.json();
    console.log('Fetched comparison data:', prices); // Debugging log

    tbody.innerHTML = '';
    spinner.classList.add('hidden');

    if (prices.length > 0) {
      prices.forEach(price => {
        const row = `
          <tr>
            <td>${price.store_name}</td>
            <td>$${parseFloat(price.price).toFixed(2)}</td>
          </tr>`;
        tbody.innerHTML += row;
      });
    } else {
      tbody.innerHTML = '<tr><td colspan="2">No prices available for this item.</td></tr>';
    }
    
  } catch (error) {
    console.error('Error fetching comparison data:', error);
    tbody.innerHTML = '<tr><td colspan="2">Error fetching data.</td></tr>';
    spinner.classList.add('hidden');
  }
}

// Login functionality
async function login(username, password) {
  try {
    const response = await fetch('http://localhost:3000/login', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ username, password }),
    });

    if (response.ok) {
      const data = await response.json();
      alert(`Welcome ${data.user.username}`);
      localStorage.setItem('currentUser', JSON.stringify(data.user));
    } else {
      alert('Invalid username or password');
    }
    
  } catch (error) {
    console.error('Error logging in:', error);
  }
}

document.addEventListener('DOMContentLoaded', () => {
  fetchItems();
});

// Check if a user is logged in and update the header
document.addEventListener('DOMContentLoaded', () => {
    const usernameDisplay = document.getElementById('username-display');
    const logoutButton = document.getElementById('logout-button');
  
    // Retrieve user data from localStorage
    const currentUser = JSON.parse(localStorage.getItem('currentUser'));
  
    if (currentUser && currentUser.username) {
      usernameDisplay.textContent = `Welcome, ${currentUser.username}`;
      logoutButton.classList.remove('hidden'); // Show logout button
    } else {
      usernameDisplay.textContent = 'Welcome, Guest';
      logoutButton.classList.add('hidden'); // Hide logout button
    }
  
    // Logout functionality
    logoutButton.addEventListener('click', () => {
      localStorage.removeItem('currentUser'); // Remove user data from localStorage
      window.location.href = 'login.html'; // Redirect to login page
    });
});