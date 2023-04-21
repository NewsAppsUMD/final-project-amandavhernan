[![Open in Codespaces](https://classroom.github.com/assets/launch-codespace-7f7980b617ed060a017424585567c406b6ee15c891e84e1186181d67ecf80aa0.svg)](https://classroom.github.com/open-in-codespaces?assignment_repo_id=10863207)

## Update | 4/21/23

This week, I loaded in the known PFAS sites dataset. The dataset is currently stored as a CSV and SQLite database. I also did some geocoding to get the counties for each site since that was missing from the original dataset. I plan to extract some Census variables and merge that dataset with the original by state, county, and ZIP code. This will allow me to draw more meaningful conclusions about nationwide PFAS contamination.

The ACS variables I'm interested in are: 
* Total population
* Race/ethnicity
* Median age
* Median household income
* Number of housing units
* Number of homeowner occupied units
* Number of renter occupied units
* Total foreign-born population
* Total US-born population

### Goals

- [ ] Grab Census ACS variables and merge with original dataset
- [ ] Set up app.py and index.html scripts (mapbox choropleth maps with search/filter feature, searchable table)
- [ ] Set up analysis.py script to summarize counts by ZIP code, county, and state
- [ ] Experiment with CSS styling

## Update | 4/14/23
For my final project, I plan to develop a news app that allows users to explore/discover PFAS contamination in their community by using a ZIP code, county, or state as search terms. The app's main element will be a map of PFAS-contaminated sites nationwide. Searching for a ZIP code, county, or state name would filter the data while also zooming the map to the appropriate level. The news app will also include additional filters for industry (landfill, military, etc.) and contamination type (soil, drinking water, surface water, groundwater). I would also like to color code or size the dots on the map by the total amount of PFAS detected. The app will also provide demographic information about the affected communities using Census data, including race/ethnicity, median income, and the number of households. Users will also be able to hover over the dots to read site-specific infomration in a popup. The data I'm using for this project was compiled by the [PFAS Project Lab](https://docs.google.com/spreadsheets/d/10y4u1KG6gegnw3zoTUTbXxQiEqitU1ufPlGvGiETtcg/edit#gid=682068550) at Northeastern University. 

1. How are you defining a unique record?

A unique record is defined by the site name. Each record, which equates to one PFAS-contaminated site, contains information about the industry responsible, the type of contamination, and the amount of PFAS detected in parts per trillion.

2. What is the schedule of data updates?

The schedule of data updates would depend on the frequency of new data being released by the PFAS Project Lab at Northeastern University. The data was last updated in October 2022. It's possible that the lab will update their dataset around the same time this year, which is when I would schedule an update.

3. How will those updates be done –– incrementally or wholesale?

Ideally, updates will be done incrementally to ensure that the app remains functional and user-friendly at all times. However, if there are significant changes to the data format or structure, wholesale updates may be necessary to ensure that the app is compatible with the new data.

4. Are there parts of the data that you would not display or make searchable? Why?

I do not plan to make the "sample year" attribute searchable/filterable because I would like to instead use that information to animate the map. I'm envisioning adding a button or another page that would show the progression of contamination over time.

#### Examples of published PFAS maps
* [PFAS Sites and Community Resources](https://experience.arcgis.com/experience/12412ab41b3141598e0bb48523a7c940/page/Page-1/?data_id=dataSource_21-18203d2ab1c-layer-8%3A23&views=Known-Contamination%2CAbout-Key-Abbreviations)
  * Developed by Northeastern University’s PFAS Project Lab, Silent Spring Institute, and the PFAS-REACH team
* [PFAS Contamination in the U.S.](https://www.ewg.org/interactive-maps/pfas_contamination/map/)
  * Developed by the Environmental Working Group

#### News apps with similar features
* [World Water Map](https://worldwatermap.nationalgeographic.org/)
  * National Geographic
* [The Most Detailed Map of Cancer-Causing Industrial Air Pollution in the U.S.](https://projects.propublica.org/toxmap/)
  * ProPublica
