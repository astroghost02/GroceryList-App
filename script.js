// Store fetched items in a global variable for filtering
let allItems = [];

// Function to fetch and render items
async function fetchItems() {
    try {
        const response = await fetch('datasets/items.json');
        const items = await response.json();
        allItems = items; // Save items globally
        renderItems(items); // Render all items initially
    } catch (error) {
        console.error('Error fetching items:', error);
    }
}

// Function to filter items
function filterItems() {
    const category = document.getElementById('category-filter').value;
    const searchQuery = document.getElementById('search-bar').value.toLowerCase();

    // Filter items by category and search query
    const filteredItems = allItems.filter(item => {
        const matchesCategory = category === 'all' || item.category === category;
        const matchesSearch = item.name.toLowerCase().includes(searchQuery);
        return matchesCategory && matchesSearch;
    });

    renderItems(filteredItems);
}

// Attach filter functionality to inputs
document.getElementById('category-filter').addEventListener('change', filterItems);
document.getElementById('search-bar').addEventListener('input', filterItems);

// Render Items (same as before)
function renderItems(items) {
    const container = document.getElementById('items-container');
    container.innerHTML = ''; // Clear the container before rendering

    if (items.length === 0) {
        container.innerHTML = '<p>No items found</p>';
        return;
    }

    items.forEach(item => {
        const itemCard = document.createElement('div');
        itemCard.className = 'item-card';
        itemCard.innerHTML = `
            <img src="${item.image}" alt="${item.name}" class="item-image">
            <h3>${item.name}</h3>
            <p>Category: ${item.category}</p>
            <p>Price: $${item.price.toFixed(2)}</p>
            <button class="add-to-cart" data-id="${item.id}">Add to Cart</button>
        `;
        container.appendChild(itemCard);
    });

    // Add event listeners to "Add to Cart" buttons
    document.querySelectorAll('.add-to-cart').forEach(button => {
        button.addEventListener('click', addToCart);
    });
}

// Add to Cart (same as before)
function addToCart(event) {
    const itemId = event.target.getAttribute('data-id');
    console.log(`Item ${itemId} added to cart.`);
    // Add your cart logic here
}

// Initial fetch to load items
fetchItems();
