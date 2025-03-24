from flask import Flask, request, jsonify
import requests
from bs4 import BeautifulSoup

app = Flask(__name__)

def get_crop_recommendations(location, season, previous_crops):
    search_query = f"Best crops for {season} in {location} after {', '.join(previous_crops)}"
    google_url = f"https://www.google.com/search?q={search_query.replace(' ', '+')}"
    
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
    }
    
    response = requests.get(google_url, headers=headers)
    soup = BeautifulSoup(response.text, "html.parser")
    
    results = []
    for g in soup.find_all('div', class_='BNeawe vvjwJb AP7Wnd'):
        results.append(g.text)
    
    return results[:5]  # Return top 5 results

@app.route("/recommend-crops", methods=["POST"])
def recommend_crops():
    data = request.json
    location = data.get("location")
    season = data.get("season")
    previous_crops = data.get("previousCrops", [])
    
    if not location or not season:
        return jsonify({"error": "Location and season are required"}), 400
    
    recommendations = get_crop_recommendations(location, season, previous_crops)
    return jsonify({"recommended_crops": recommendations})

if __name__ == "__main__":
    app.run(debug=True)
