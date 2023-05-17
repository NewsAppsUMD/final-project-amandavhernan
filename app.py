from flask import Flask, render_template
import folium
from folium import plugins
import pandas as pd

app = Flask(__name__)

# map
@app.route('/')
def index():
    
    # load data
    pfas = pd.read_csv('data/known_sites_clean.csv')

    # folium map basics
    start_latlon = (39.50, -98.35)
    folium_map = folium.Map(
        location=start_latlon, 
        zoom_start=4,
        tiles="CartoDB Positron"
    )

    # color dictionary
    pfas_desc_colors = {
        pfas_desc: color 
        for pfas_desc, color in zip(pfas["pfas_desc"].unique(), ["#123f5a", "#7bbcb0", "#235d72", "#3a7c89"])
    }

    # markers + popups
    for index, row in pfas.iterrows():
        folium.CircleMarker(
            location=[row["latitude"], row["longitude"]],
            radius=4,
            color=pfas_desc_colors[row["pfas_desc"]],
            fill=True,
            fill_color=pfas_desc_colors[row["pfas_desc"]],
            fill_opacity = 0.5,
            popup = f"<b>Name:</b> {row['site_name']}<br><b>Industry:</b> {row['industry']}<br><b>Total PFAS (ng/L):</b> {row['pfas_desc']}<br><b>Address:</b> {row['number']} {row['street']} {row['city']}, {row['state']} {row['geocoded_zip']}", max_width=300).add_to(folium_map)

    # legend    
    legend_html = """
    <div style="position: fixed; 
                bottom: 50px; left: 50px; width: 150px; height: 165px; 
                border:2px solid white; z-index:9999; font-size:12px;
                background-color: rgba(255, 255, 255, 0.75); font-family: 'Source Sans Pro', sans-serif;
                ">
    <div style='font-weight: bold; padding: 2px;'>Total PFAS (ng/L)</div>
    <p style="margin:10px"><span style='background-color:#7bbcb0'>&nbsp;&nbsp;&nbsp;&nbsp;</span> Less than 10</p>
    <p style="margin:10px"><span style='background-color:#3a7c89'>&nbsp;&nbsp;&nbsp;&nbsp;</span> Between 10 and 1,000</p>
    <p style="margin:10px"><span style='background-color:#235d72'>&nbsp;&nbsp;&nbsp;&nbsp;</span> Between 1,000 and 100,000</p>
    <p style="margin:10px"><span style='background-color:#123f5a'>&nbsp;&nbsp;&nbsp;&nbsp;</span> Greater than 100,000</p>
    </div>
    """
    folium_map.get_root().html.add_child(folium.Element(legend_html))

    # geo search 
    plugins.Geocoder().add_to(folium_map)

    folium_map.save('templates/map.html')
    return render_template('index.html')

@app.route('/map')
def map():
    return render_template('map.html')

# table
@app.route('/table')
def table():
    # load data
    data = pd.read_csv('data/known_sites_clean.csv').to_dict(orient='records')

    # return the data for the table
    return render_template("table.html", data=data)

if __name__ == '__main__':
    app.run(port=8080, debug=True)