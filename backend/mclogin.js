document.addEventListener("DOMContentLoaded", function () {
    const loginForm = document.getElementById("mcLoginForm");

    loginForm.addEventListener("submit", function (event) {
        event.preventDefault(); // Prevent the default form submission

        const email = document.getElementById("email").value.trim();
        const password = document.getElementById("password").value.trim();

        if (!email || !password) {
            alert("Please fill in all fields.");
            return;
        }
        if(email=='admin@example.com' && password=='password123')
            {
                // alert("Login Successfull")
                window.location.href='/frontend/Sidebar2.html'
            }
        else
        {
            alert("invalid credentials")
        }

        // // Simulated authentication (replace with actual API call)
        // fetch("/backend/authenticate_market_coordinator", {
        //     method: "POST",
        //     headers: { "Content-Type": "application/json" },
        //     body: JSON.stringify({ email, password })
        // })
        // .then(response => response.json())
        // .then(data => {
        //     if (data.success) {
        //         alert("Login successful!");
        //         window.location.href = "/frontend/Sidebar2.html"; // Redirect to dashboard
        //     } else {
        //         alert("Invalid email or password. Please try again.");
        //     }
        // })
        // .catch(error => {
        //     console.error("Error during login:", error);
        //     alert("An error occurred. Please try again later.");
        // });
    });
});
