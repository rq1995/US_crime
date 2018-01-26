#Crime data for US cities App

Ruoqi (Stephanie) Xu     2018-01-14

## Overview
It is known to all that crime rate is on the rise all over the world. the means of committing a crime is numerous and varied. murder and robbery, not to speak of theft, are often seen. In this situation, It is important for both local and foreigner to discover the lowest crime city or town, before they invest, travel, or select a location for your business. If we could get which regions have more crimes and which type of crimes are the most-frequent in one region, it may be possible to help residents and visitors make the optimal choice and also to reduce crime frequency. To address this challenge, I propose building a data visualization app that enables people explore a dataset of Marshall Violent Crime. My app will show the distribution of crime rate and the number of crime in term of years and regions in US. And my app will also visualize the different type of crime in US to help people find the trend of crimes in US.

## Description of the data
I will be visualizing a dataset of approximately 3,000 crime records, named `city-crime`, collected and curated by [The Marshall Project](https://www.themarshallproject.org). The Marshall Project compiled the most recent Uniform Crime Reporting numbers available on the four major crimes the FBI classifies as violent: homicide, rape, robbery and assault. They collected information on the jurisdictions that are members of the Major Cities Chiefs Association, which collected violent crime numbers for 2015 and the first two quarters of this year. All but one of the members in the Major Cities Chiefs Association have populations of 250,000 or greater. The dataset include ORI (unique identifier), year, department_name (city name), total_pop (population of the city), homs_sum, rape_sum, rob_sum, aggasssum, violent_crime (rollup of all four crime types), violentper100k, homsper100k, rapeper100k, robper100k, and aggassper_100k.


## Description of my app & sketch

The app contains a landing page that shows the trend of dataset factors (violent_crime, violentper100k, homsper100k, rapeper100k, robper100k, and aggassper_100k etc.) based on selected region and year.


From the crime type selection, users can filter out variables from the data, by total crime type, Homicide, rape, robbery and assault.
From slider selection, user can choose the range of year that he want plot in the page. From a dropdown list (Region), users can select which region he want to check. Users can also select preference color to the plot by using colour selection. 

## Where can find

The deployed app can be located [here](https://rq1995.shinyapps.io/US_crime/)


## Folder structure

    |- CITATION.md
    |
    |- README.md
    |
    |- LICENSE.md
    |
    |- doc/           # directory for documentation, one subdirectory for manuscript
    |
    |- data/          # data for storing fixed data sets
    |
    |- src/           # any source code
    |
    |- from_partner/           # any compiled binaries or scripts
    |
    |- results/       # output for tracking computational experiments performed on data

