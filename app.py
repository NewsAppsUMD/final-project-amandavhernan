from flask import Flask, render_template
import folium
from folium import plugins
import pandas as pd

app = Flask(__name__)

@app.route('/')
def index():
    # data
    pfas = pd.read_csv('data/geocodio_known_sites.csv')

    start_latlon = (39.50, -98.35)
    folium_map = folium.Map(
        location=start_latlon, 
        zoom_start=4,
        tiles="CartoDB Positron"
    )

    for index, row in pfas.iterrows():
        folium.Marker(
            location=[row["latitude"], row["longitude"]],
            popup = f"Name: {row['site_name']}<br>State: {row['state']}").add_to(folium_map)
        
    plugins.Geocoder().add_to(folium_map)

    folium_map.save('templates/map.html')
    return render_template('index.html')

@app.route('/map')
def map():
    return render_template('map.html')

if __name__ == '__main__':
    app.run(debug=True)