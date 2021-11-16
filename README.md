# Cyclistic-Case-Study

Google Data Analytics Capstone Project

# Case Study: How Does a Bike-Share Navigate Speedy Success?

## Introduction

Welcome to the Cyclistic bike-share analysis case study! In this case study, you will perform many real-world tasks of a junior data analyst. You will work for a fictional company, Cyclistic, and meet different characters and team members. In order to answer the key business questions, you will follow the steps of the data analysis process: ask, prepare, process, analyze, share, and act. Along the way, the Case Study Roadmap tables — including guiding questions and key tasks — will help you stay on the right path.

By the end of this lesson, you will have a portfolio-ready case study. Download the packet and reference the details of this case study anytime. Then, when you begin your job hunt, your case study will be a tangible way to demonstrate your knowledge and skills to potential employers.

## Scenario

You are a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company's future success depends on maximizing the number of annual memberships. Therefore, your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, your team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve your recommendations, so they must be backed up with compelling data insights and professional data visualizations.

------------------------------------------------------------------------

## Step 1 - Ask

**Key tasks**

1.  Identify the business task

2.  Consider key stakeholders

**The business task**

How do annual members and casual riders use Cyclistic bikes differently?

**Key stakeholders**

1. Lily Moreno - director of marketing and my manager. 

2. Cyclistic executive team.

------------------------------------------------------------------------

## Step 2 - Prepare

**Key tasks**

1.  Download data and store it appropriately.

-   All data was collected from [here](https://divvy-tripdata.s3.amazonaws.com/index.html).

1.  Identify how it's organized.

2.  Sort and filter the data.

3.  Determine the credibility of the data.

------------------------------------------------------------------------

## Step 3 - Process

**Key tasks**

1.  Check the data for errors.

2.  Choose your tools.

3.  Transform the data so you can work with it effectively.

4.  Document the cleaning process.

------------------------------------------------------------------------

## Step 4 - Analysis

**Key tasks**

1.  Aggregate your data so it's useful and accessible.

2.  Organize and format your data.

3.  Perform calculations.

4.  Identify trends and relationships

------------------------------------------------------------------------

## Step 5 - Share

**Key tasks**

1.  Determine the best way to share your findings.

2.  Create effective data visualizations.

3.  Present your findings.

4.  Ensure your work is accessible.

I used RStudio with R language for this case study from step 2 to 5.

Link to R Notebook file is [here](https://github.com/Roljed/Cyclistic-Case-Study/blob/main/capstone-notebook.md).

------------------------------------------------------------------------

## Step 6 - Act

### Summary

Based on the business task - **How do annual members and casual riders use Cyclistic bikes differently?**, and my *key observations*:

    Observation 1: Casual users ride much longer.

    Observation 2: Members tend to ride more continuously around the week, but casual users peak at weekends and ride much less on working days.

    Observation 3: Casual users tend to make longer trips.

    Observation 4: Both members and casual users use this transit more on summer months, with a significant drop during winter. Most preferable months of casual riders are July and August.

    Observation 5: Casual users peak at evenings, after work hours, just like members, who additionaly ride to work and and back.

    Observation 6: Casual trips are mush shorter in the mornings (5am-8am), with two peaks right before dawn and in the afternoon, while members ride regularly over all the 24-hour period.

    Observation 7: Classic bikes are the most preferable by all users.

    Observation 8: Again, members use any available bike at the station, while casual users prefer the docked bikes.

    Observation 9: The top 3 preferred stations of the casual users, and the top 3 stations with the most users, are:

    1. Streeter Dr & Grand Ave

    2. Millennium Park

    3. Michigan Ave & Oak St

    While the members' top 3 stations are:

    1. Clark St & Elm St

    2. Wells St & Concord Ln

    3. Kingsbury St & Kinzie St

### My top 3 recommendations:

1.  Marketing campaign on discount membership for longer rides during the weekends (Observations 1, 2 and 3).

2.  Add more bikes and promotions at the casual users top stations (Observation 9).

3.  Afternoon and summer months special offers for member users, to draw the casual users to join in (Observations 4, 5, 6).

### Things to explore more:

1.  Stations which have the least casual users, or even none at all - are they visited by member users only?

2.  Preferred bike - are different type of bikes available equaly at each station? Or is the dominant type the classic bike, therefore the observations 7 and 8 are bias?
