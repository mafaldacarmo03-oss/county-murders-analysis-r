# Homicides in US Counties - Statistical Analysis with R

## About the Project

This project was developed as part of the Computational Statistics course at the Faculty of Sciences, University of Porto.

The goal of this study is to analyse homicide rates across different counties in the United States and investigate whether demographic and population characteristics are associated with higher homicide levels.

The analysis was conducted using the `countymurders` dataset from the `wooldridge` package in R.

---

## Objectives

The main objective of this project is to explore possible relationships between homicide rates and demographic variables, including:

* Population density
* Percentage of population aged 10–19
* Percentage of population aged 20–29
* Percentage of Black population
* Percentage of male population
* Number of arrests

---

## Dataset

Source: `countymurders` dataset from the `wooldridge` R package.

Data preprocessing steps:

* Selection of observations from 1980
* Removal of missing values
* Restriction of population density values
* Creation of density categories based on quartiles
* Creation of a binary variable identifying counties with high homicide rates

---

## Statistical Methods

The following statistical techniques were applied:

### Exploratory Data Analysis (EDA)

* Histograms
* Boxplots
* Violin plots
* Scatter plots

### Statistical Tests

* Wilcoxon Rank Sum Test
* Student's t-Test
* Pearson Chi-Square Test

---

## Key Findings

The analysis suggests that:

* Counties with higher homicide rates tend to have significantly higher numbers of arrests.
* Population density appears to be positively associated with homicide levels.
* Some demographic variables show statistical significance but limited practical relevance.
* The strongest relationship observed was between homicides and arrests.

---

## Technologies Used

* R
* ggplot2
* dplyr
* wooldridge

---

## Project Structure

```bash
.
├── data/
├── scripts/
├── plots/
├── report/
└── README.md
```

---

## Authors

* Mafalda Carmo
* Marta Monteiro
* Rafaela Pinto

---

## Academic Context

Computational Statistics Project

Faculty of Sciences – University of Porto

Academic Year 2024/2025
