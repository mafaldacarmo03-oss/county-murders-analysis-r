# Homicides in US Counties - Statistical Analysis with R

## About the Project

This repository contains a statistical analysis of homicide rates across U.S. counties using the countymurders dataset from the wooldridge package in R.

The project explores the relationship between homicide levels and demographic factors such as age distribution, population density, gender composition, racial demographics, and arrest rates through exploratory data analysis, statistical testing, and data visualisation.

Note: The accompanying report is available in Portuguese.

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

## Authors

* Ana Mafalda Araújo do Carmo
* Marta Monteiro
* Rafaela Afonso Claro Pinto

---

## Academic Context

Computational Statistics 

Faculty of Sciences – University of Porto

Academic Year 2025/2026

