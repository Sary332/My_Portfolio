# Road Accident Dashboard
## Requirement Gathering from Client 
Clients wants to create a Road Accident Dashboard for year 2021 and 2022 so that they can have insight on the below requirements.

==> Primary KPI : Total Casualties taken place after the accident.

==> Primary KPI's : Total Casualties & percentage of total with respect to accident severity and maximum casualties by type of vehicle.

==> Secondary KPI's : Total Casualties with respect to vehicle type

==> Monthly trend showing comparison of casualties for current & previous year

==> Maximum casualties by Road Type

==> Distribution of total casualties by Road Surface

==> Relation between Casualties by Area/Location & by Day/Night

## Identify the Stakeholders of the Project

Traffic Management Agencies

## Metadata
==> File Extention - .xlsx

==> No. of Rows - 3.07 Million

==>No. of Fields - 21

## Process

### Data Cleaning Process
#### **a)  Checking for typos/spelling mistakes in each column & and fixing them using the "find and replace" feature.**
  
**==> Typo in Junction_Detail column**

<img width="377" alt="Cleaning- Junction control typo part 2 (after)" src="https://github.com/Sary332/My_Portfolio/assets/110008177/3802efee-09b5-47c5-9839-5e07c0be3916">

**==> Typo in Accident_Severity column**

<img width="374" alt="Cleaning- Accident saverince typo part 2 (after)" src="https://github.com/Sary332/My_Portfolio/assets/110008177/78165e36-a627-4979-8080-1ae15e35c149">

**==> Typo in Local_Authority_(District) column (There are typos/misspellings in the names of 4 cities. However, here I'm only displaying one to save space.)**

<img width="373" alt="Cleaning- Local Authority typo part 1 (Result)" src="https://github.com/Sary332/My_Portfolio/assets/110008177/64767809-3a95-42ee-a638-b521fe70eabb">

#### b) Checking for blank values in each column.

- 317 null value in Road_surface_Condition column
  
- 1535 null value in Road_Type column
  
- 17 null value in Time column
  
- 6057 null value in Weather_Conditions

**Note :**

In this analysis, I will retain the blank values. One primary reason for doing so is to accommodate missing or unavailable data. This approach maintains the authenticity of the dataset, preventing false assumptions. Additionally, blank values aid in identifying data collection issues and potential patterns.

### Data Transformation
As stated in the requirement, we are tasked with displaying trend lines for current and previous year casualties. Specifically, we aim to present a "Monthly Trend" line. To achieve this, it's necessary to introduce both a month and a year column for the calculation of casualties by month and year. Consequently, I will create new columns for month and year using the Text function, derived from the "Accident_Date" column.

<div style="position:relative;width:fit-content;height:fit-content;">
            <a style="position:absolute;top:20px;right:1rem;opacity:0.8;" href="https://clipchamp.com/watch/wjkbZY7aedw?utm_source=embed&utm_medium=embed&utm_campaign=watch">
                <img loading="lazy" style="height:22px;" src="https://clipchamp.com/e.svg" alt="Made with Clipchamp" />
            </a>
            <iframe allow="autoplay;" allowfullscreen style="border:none" src="https://clipchamp.com/watch/wjkbZY7aedw/embed" width="640" height="360"></iframe>
        </div>
