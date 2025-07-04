// script.js

let isRegister = false;

function toggleForm() {
    isRegister = !isRegister;
    document.getElementById('form-title').textContent = isRegister ? 'Register' : 'Sign In';
    document.getElementById('name').style.display = isRegister ? 'block' : 'none';
    document.querySelector('.toggle-link').textContent = isRegister
        ? 'Already have an account? Sign in here'
        : 'Don’t have an account? Register here';
}

document.addEventListener("DOMContentLoaded", () => {
    const authForm = document.getElementById('auth-form');
    if (authForm) {
        authForm.addEventListener('submit', (e) => {
            e.preventDefault();
            const name = document.getElementById('name').value.trim();
            const email = document.getElementById('email').value.trim();
            const password = document.getElementById('password').value;

            if (isRegister) {
                const users = JSON.parse(localStorage.getItem('users') || '{}');
                if (users[email]) {
                    alert("User already exists");
                    return;
                }
                users[email] = { name, password };
                localStorage.setItem('users', JSON.stringify(users));
                alert("Registered successfully!");
                toggleForm();
            } else {
                const users = JSON.parse(localStorage.getItem('users') || '{}');
                if (users[email] && users[email].password === password) {
                    localStorage.setItem('loggedInUser', JSON.stringify({ email, name: users[email].name }));
                    window.location.href = "index.html";
                } else {
                    alert("Invalid credentials");
                }
            }
        });
    }

    const authBtn = document.getElementById("auth-btn-label");
    const welcomeUser = document.getElementById("welcome-user");
    const loggedInUser = JSON.parse(localStorage.getItem("loggedInUser"));

    if (authBtn && welcomeUser) {
        if (loggedInUser) {
            authBtn.textContent = "Sign Out";
            welcomeUser.textContent = "Welcome, " + loggedInUser.name + "!";
        } else {
            authBtn.textContent = "Sign In";
            welcomeUser.textContent = "";
        }
    }
});

function handleAuth() {
    const loggedInUser = JSON.parse(localStorage.getItem("loggedInUser"));
    if (loggedInUser) {
        localStorage.removeItem("loggedInUser");
        location.reload();
    } else {
        window.location.href = "auth.html";
    }
}
