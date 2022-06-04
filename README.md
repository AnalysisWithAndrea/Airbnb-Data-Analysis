# 2021 Austin Airbnb Data Analysis with Tableau visualizations
## Data Collection
Downloaded the Austin 2021 detailed listings dataset from [Inside Airbnb](http://insideairbnb.com/get-the-data/).

## Data Cleaning
Used SQL to format columns, drop outliers, remove the hotel room type, change column types, and to join neighborhood names with their corresponding zip codes.

## Data Exploration
Used SQL to learn more about the dataset. Described listings by room type and zip code, compared price vs. price per bedroom. Determined that prices are higher during special events such as SXSW and ACL, being a superhost doesn’t have any effect on price, and found which amenities have the most effect on pricing.

## Tableau
Created a dashboard with 5 visualizations and 4 KPIs. You can view the full dashboard [here]( https://public.tableau.com/app/profile/andrea.bernal/viz/airbnb_16505703431140/Dashboard1?publish=yes).

## Findings 
* Price increases during events such as SXSW and ACL
* Being a superhost has no effect on price but on average superhosts are better rated and have less properties listed on Airbnb
* Found that pools, hot tub, fireplace, gym, pets, and waterfront amenities have the most effect on pricing
* South central Austin has the most listings but Westlake hills is the most expensive neighborhood
* Average price for entire homes/apartments, private rooms, and shared rooms are $291.9, $126.0, and $65.7 respectively
*  A reasonable price for a one bedroom stay in Austin is around $142
* Most listings are short-term stays with a median min. nights of 2 nights
* The most popular zip codes are 78702 (East Austin) and 78704 (South Central)
* The cheapest neighborhood is Southeast Austin
* There's a negative correlation between Number of Reviews and Price Per Bedroom
