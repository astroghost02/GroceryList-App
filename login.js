const loginForm = document.getElementById('login-form');
const loginMessage = document.getElementById('login-message');

// Handle login or registration
loginForm.addEventListener('submit', async (e) => {
  e.preventDefault();

  const username = document.getElementById('username').value.trim();
  const password = document.getElementById('password').value.trim();

  if (!username || !password) {
    loginMessage.textContent = 'Please provide both username and password.';
    loginMessage.style.color = 'red';
    return;
  }

  try {
    // Check if the user exists by attempting login first
    const loginResponse = await fetch('http://localhost:3000/login', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ username, password }),
    });

    if (loginResponse.ok) {
      const data = await loginResponse.json();
      localStorage.setItem('currentUser', JSON.stringify(data.user));
      loginMessage.textContent = `Welcome back, ${data.user.username}!`;
      loginMessage.style.color = 'green';
      setTimeout(() => {
        window.location.href = 'index.html'; // Redirect to homepage
      }, 2000);
    } else if (loginResponse.status === 401) {
      // If login fails, try registering the user
      const registerResponse = await fetch('http://localhost:3000/register', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ username, password }),
      });

      if (registerResponse.ok) {
        loginMessage.textContent = `Account created successfully. Welcome, ${username}!`;
        loginMessage.style.color = 'green';
        setTimeout(() => {
          window.location.href = 'index.html'; // Redirect to homepage
        }, 2000);
      } else if (registerResponse.status === 400) {
        loginMessage.textContent = 'Username already exists. Please try again.';
        loginMessage.style.color = 'red';
      } else {
        throw new Error('Error registering user');
      }
    }
  } catch (error) {
    console.error(error);
    loginMessage.textContent = 'An error occurred. Please try again later.';
    loginMessage.style.color = 'red';
  }
});