# Bike-sharing
## A simple guide of R Shiny to analyze, explore, and predict bike-sharing registrations
In the following project, I proceed to develop a simple guide to build an R Shiny Dashboard application. In this application, I performed an Exploratory Data Analysis of the data and additionally deployed a prediction model. This model will calculate the number of bike registration throughout a specific date, day of the week, hour, and weather conditions.

The dataset used to develop the R Shiny application is called Bike Sharing Dataset Data Set (specifically the "hour.csv" file), taken from UCI Machine Learning Repository.

The data collected was from the bike share system called "Capital Bikeshare". The system consists of a group of bikes located throughout six different jurisdictions in Washington, DC. The bikes are lock into a network of the docking station that can be unlocked, using their unique application, for daily transportation, and return to any other station in the system.

The dataset contains the hourly count of bike registrations, between the years 2011 and 2012, taking into consideration the weather conditions and the seasonal information. The data holds 16 attributes and 17,379 observations, where each row of the data represents a specific hour of the day from January 1, 2011; till December 31, 2012.

## Methodology
For this project, I followed the following steps.

### 1. Data understanding:
The first step performed was to get to know and understand the data chosen for the R Shiny.

### 2. Data preparation:
For the following step, I focus on arranging the data into the correct format for further use in the application.

### 3. Modeling:
Further, in this step, I develop three regression model to predict the number of bike registrations. Then, I select the best model between a multilinear regression, decision tree, and random forest; by analyzing the Mean Absolute Error and the Root Mean Square Error.

### 4. EDA in R Shiny:
In a new R document, I developed the first section of the R Shiny Dashboard.  I implemented the EDA containing a univariate analysis and a bivariate analysis.

### 5. Prediction in R Shiny:
Finally, I proceed to add the rest of the text code for the single prediction model.

