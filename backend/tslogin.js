document.addEventListener("DOMContentLoaded", function () {
    document.getElementById("loginForm").addEventListener("submit", function (event) {
        event.preventDefault(); // Prevent default form submission

        // Get input values
        const email = document.getElementById("email").value;
        const password = document.getElementById("password").value;

        // Dummy login validation (Replace with actual backend API call)
        if (email === "admin@example.com" && password === "password123") {
            window.location.href = "/frontend/tsdash.html"; // Redirect to the dashboard page
        } else {
            alert("Invalid credentials. Please try again.");
        }
    });
});
