# DataChallenge
Proposition 15 and Ending the Politics of Scarcity​

We were motivated to research Prop 15 because we know that lack of funds hinders our ability to pay for school and community services (e.g., fire protection and forest management), which hurts low-income communities of color the most. Prop 15 could be a vehicle to increase funding for local services by requiring large corporations (est. Before 1976) to pay their fair share in property taxes.
   
 To explore this issue, we ask the following questions:
 1. How did local government spending change after the passage of Prop 13? ​
 2. Has funding for essential services kept pace with California's economic growth?​
 3. Which sectors have been impacted?​

See our visualizations exploring these questions here:  
https://advancementprojectca.github.io/RDA/Prop15_Ending_Politics_of_Scarcity.html

Data Sources:
We used current operations expenditures from the US Census Annual Survey of State and Local Government Finances. To account for the increase in state wealth over time, we calculate expenditures as a percentage of state GDP.​

Expenditure files downloaded from https://www.census.gov/programs-surveys/gov-finances.html.​

Major data limitations include differences from surveys and actual budgets; differences in local applications of broad, standardized spending categories; differences in how localities expense over time; and data ending in 2012.​
    
Process:
We uploaded the data to a postgreSQL database and wrote SQL views to select specific years, geographies, and budget line items to assess.​PostgreSQL views were imported into R (using the sf package), where we calculated funding changes over time, and visualized the data. ​Using highcharter (Highcharts wrapper for R) and ggplot2, we visualized trends in CA GDP, and funding for sectors like education, libraries and corrections.​ We used RMarkdown to bring the visuals together in a Storyboard, using the Flex Dashboard.​

Acknowledgements: 
Data cleaning and analysis by Ryan Natividad, Elycia Mullholland Graves and Chris Ringewald​
Data visualization by Laura Daly, Jennifer Zhang and Elycia Mullholland Graves​
Background research support by Ryan Natividad, Tolu Bamishigbin, Chris Ringewald, and Elycia Mulholland Graves
