const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const app = express();
const PORT = 5000;

// Middleware
app.use(cors());
app.use(express.json());

// Connect to MongoDB
mongoose.connect("mongodb://localhost:27017/cropixdb", { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log("✅ MongoDB connected successfully"))
  .catch(err => console.error("❌ MongoDB connection error:", err));

// Define Schema and Model
const cropSchema = new mongoose.Schema({
  name: String,
  market: String,
  price: Number // Ensure your DB actually has these fields
});

const Crop = mongoose.model("Crop", cropSchema, "cropix"); // Collection name: cropix

// Search API
app.get('/search', async (req, res) => {
    try {
        let query = req.query.query;
        if (!query) {
            return res.status(400).json({ error: "Missing search query" });
        }

        // Find matching crops
        let results = await Crop.find(
            { name: { $regex: query, $options: "i" } }, // Case-insensitive search
            { _id: 0, name: 1, market: 1, price: 1 } // Select only these fields
        );

        res.json(results.length > 0 ? results : { message: "No results found" });
    } catch (err) {
        console.error("❌ Error fetching results:", err);
        res.status(500).json({ error: "Internal Server Error" });
    }
});

app.listen(PORT, () => {
    console.log(`🚀 Server running on http://localhost:${PORT}`);
});
