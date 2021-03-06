---
title       : Developing Data Products
subtitle    : Course Project
author      : Alexander van der Kuijl
job         : 
framework   : revealjs           # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js      # {highlight.js, prettify, highlight}
hitheme     : default           # 
widgets     : []
mode        : selfcontained     # {standalone, draft}
knit        : slidify::knit2slides
---

<style>
.reveal h1 {
    font-size: 2em;
    text-align: left;
    padding-bottom: 10px;
}

.reveal h2 {
    font-size: 1.5em;
    text-align: left;
    padding-bottom: 10px;
}

.reveal p {
    font-size: 0.75em;
    text-align: left;
    padding-bottom: 10px;
}


</style>

# Developing Data Products
## Coursera Data Science Project
-------------------------------------


Death Causes in the US between 1999 and 2016


Alexander van der Kuijl

---

## Introduction

This presentation is for the Developing Data Products Course at Coursera.

This course is part of the Data Science Specialization at Coursera

In this final Assignment a Shiny App needs to be developed.

This presentation provides information about this Shiny App.

The Shiny App can be found at:
https://vanderq.shinyapps.io/courseradataproductsassignment/

The source code of the Shiny App can be found at:
https://github.com/vanderq/CourseraDevelopingDataProducts

---

## The App

This App is using Death Cause data in the US between 1999 and 2016.

It allows the user to select years, possible causes and states, and view the outcome.

The output is plotted in a graph, which also shows an linear model approximation.

A linear model is calculated, for which the intercept and the slope are displayed.

---

## DataSet

The Dataset is the Death Cause data in the US between 1999 and 2016.

This data is coming from the National Center for Health Statistics, and is obtained from:
https://data.cdc.gov/NCHS/NCHS-Leading-Causes-of-Death-United-States/bi63-dtpu

This dataset presents the age-adjusted death rates for the 10 leading causes of death in the United States beginning in 1999.

Data are based on information from all resident death certificates filed in the 50 states and the District of Columbia using demographic and medical characteristics. Age-adjusted death rates (per 100,000 population) are based on the 2000 U.S. standard population. Populations used for computing death rates after 2010 are postcensal estimates based on the 2010 census, estimated as of July 1, 2010. Rates for census years are based on populations enumerated in the corresponding censuses. Rates for non-census years before 2010 are revised using updated intercensal population estimates and may differ from rates previously published.

Causes of death classified by the International Classification of Diseases, Tenth Revision (ICD–10) are ranked according to the number of deaths assigned to rankable causes. Cause of death statistics are based on the underlying cause of death.

---

## DataSet

The data looks like this:


```r
nchsData <- read.csv("NCHS_-_Leading_Causes_of_Death__United_States.csv")
head(nchsData)
```

```
##   Year                                      X113.Cause.Name
## 1 2016 Accidents (unintentional injuries) (V01-X59,Y85-Y86)
## 2 2016 Accidents (unintentional injuries) (V01-X59,Y85-Y86)
## 3 2016 Accidents (unintentional injuries) (V01-X59,Y85-Y86)
## 4 2016 Accidents (unintentional injuries) (V01-X59,Y85-Y86)
## 5 2016 Accidents (unintentional injuries) (V01-X59,Y85-Y86)
## 6 2016 Accidents (unintentional injuries) (V01-X59,Y85-Y86)
##               Cause.Name      State Deaths Age.adjusted.Death.Rate
## 1 Unintentional injuries    Alabama   2755                    55.5
## 2 Unintentional injuries     Alaska    439                    63.1
## 3 Unintentional injuries    Arizona   4010                    54.2
## 4 Unintentional injuries   Arkansas   1604                    51.8
## 5 Unintentional injuries California  13213                    32.0
## 6 Unintentional injuries   Colorado   2880                    51.2
```

