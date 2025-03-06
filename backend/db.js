const mysql = require('mysql2');

// Create MySQL connection
const db = mysql.createConnection({
    host: "localhost",      // Change if using remote DB
    user: "ani",           // Your MySQL username
    password: "Satya1983@@",           // Your MySQL password
    database: "cropix_db"   // Your database name
});

// Connect to MySQL
db.connect((err) => {
    if (err) {
        console.error("Database Connection Failed: ", err);
    } else {
        console.log("Connected to MySQL Database ✅");
    }
});

module.exports = db;
