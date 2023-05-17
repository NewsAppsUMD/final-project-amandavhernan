from flask import Flask
from flask import render_template
import pandas as pd

app = Flask(__name__)

@app.route("/")
def test():
    # load data
    data = pd.read_csv('data/known_sites_clean.csv').to_dict(orient='records')

    # return the data for the table
    return render_template("test.html", data=data)

if __name__ == "__main__":
    app.run(debug=True)
