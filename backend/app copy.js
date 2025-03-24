import React, { useState } from "react";
import axios from "axios";

function App() {
  const [formData, setFormData] = useState({
    location: "",
    season: "",
    previous_crop: "",
  });

  const [recommendations, setRecommendations] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError("");
    try {
      const response = await axios.post("http://127.0.0.1:5000/recommend", formData);
      setRecommendations(response.data.recommendations);
    } catch (err) {
      setError("Failed to fetch recommendations. Please try again.");
    }
    setLoading(false);
  };

  return (
    <div style={{ textAlign: "center", fontFamily: "Arial, sans-serif", padding: "20px" }}>
      <h1>🌱 Crop Recommendation System</h1>
      <form onSubmit={handleSubmit} style={{ maxWidth: "400px", margin: "auto" }}>
        <label>
          Location:
          <input
            type="text"
            name="location"
            value={formData.location}
            onChange={handleChange}
            required
            style={{ width: "100%", padding: "8px", margin: "5px 0" }}
          />
        </label>
        <br />
        <label>
          Season:
          <input
            type="text"
            name="season"
            value={formData.season}
            onChange={handleChange}
            required
            style={{ width: "100%", padding: "8px", margin: "5px 0" }}
          />
        </label>
        <br />
        <label>
          Previous Crop:
          <input
            type="text"
            name="previous_crop"
            value={formData.previous_crop}
            onChange={handleChange}
            required
            style={{ width: "100%", padding: "8px", margin: "5px 0" }}
          />
        </label>
        <br />
        <button type="submit" style={{ padding: "10px 20px", marginTop: "10px", cursor: "pointer" }}>
          Get Recommendations
        </button>
      </form>

      {loading && <p>Fetching recommendations...</p>}
      {error && <p style={{ color: "red" }}>{error}</p>}

      <h2>Recommended Crops:</h2>
      <ul style={{ listStyleType: "none", padding: 0 }}>
        {recommendations.map((crop, index) => (
          <li key={index} style={{ background: "#e0ffe0", padding: "10px", margin: "5px", borderRadius: "5px" }}>
            {crop}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;
