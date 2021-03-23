---
title: "Introduction to (Bio)Statistics"
author: "Jo Hardin"
date: "2021-03-23"
knit: bookdown::render_book
site: bookdown::bookdown_site
header-includes:  \usepackage{blkarray}
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
github-repo: hardin47/website/Math58/
description: "Class notes for both Math 58 and Math 58B at Pomona College: Introduction to Statistics and Introduction to Biostatistics.  The notes are based extensively on Introduction to Modern Statistics by Çetinkaya-Rundel and Hardin Investigating Statistical Concepts, Applications, and Methods by Chance and Rossman."
---

# Class Information {.unnumbered}

Class notes for Math 58(B) at Pomona College: Introduction to (Bio)Statistics. The notes are based extensively on "Introduction to Modern Statistics" by Çetinkaya-Rundel and Hardin [@ims]. We will also be using many examples (and applets) from "Investigating Statistics, Concepts, Applications, and Methods" by Chance and Rossman [@iscam].

You are responsible for reading the relevant chapters in the text. The text is very good & readable, so you should use it. Also, you will have a much deeper understanding of the material if you spend time working through the applets at <http://www.rossmanchance.com/iscam3/files.html>. You should make sure you are coming to class and also reading the materials associated with the activities.









| Day     | Topic                           | Book Chap                 | Notes Section                                   |
|:--------|:--------------------------------|:--------------------------|:------------------------------------------------|
| 1/25/21 | Intro                           | ISCAM 1.1                 | \@ref(intro): Introduction                      |
| 1/27/21 | variables & studies             | IMS 1.2, 1.4              | \@ref(experim): Types of Studies                |
| 2/1/21  | Correlation (r)                 | IMS 3.1 & ISCAM 5.6 - 5.7 | \@ref(cor): correlation                         |
| 2/3/21  | Least Squares line              | IMS 3.2 & ISCAM 5.8       | \@ref(ls): Least Squares                        |
| 2/8/21  | Intro to Hypotheis Testing      | IMS 5.1                   | \@ref(randtest): Hypothesis Testing             |
| 2/10/21 | Randomization Test              | IMS 5.1                   | \@ref(randtest): Randomization Test             |
| 2/15/21 | Bootstrapping                   | IMS 5.2                   | \@ref(boot): Bootstrap                          |
| 2/17/21 | Bootstrap Confidence Intervals  | IMS 5.2                   | \@ref(bootCI): Boot CI                          |
| 2/22/21 | Normality                       | IMS 5.3                   | \@ref(CLT): CLT                                 |
| 2/24/21 | Normality                       | IMS 5.3                   | \@ref(norm): Normal Dist                        |
| 3/1/21  | Errors & Power                  | IMS 6.2                   | \@ref(errors): HT errors                        |
| 3/3/21  | Sampling                        | IMS 1.3                   | \@ref(samp): sampling                           |
| 3/8/21  | Spring Break                    |                           |                                                 |
| 3/10/21 | Spring Break                    |                           |                                                 |
| 3/15/21 | two proportions                 | IMS 6.2                   | \@ref(diffprop): difference in proportions      |
| 3/17/21 | relative risk & odds ratios     | ISCAM 3.9 - 3.11          | \@ref(rr): relative risk, \@ref(or): odds ratio |
| 3/22/21 | chi-square test of independence | IMS 6.3                   | \@ref(chisq2): chi-sq test                      |

```{=html}
<!--
| 3/31/21   | Sampling Dist of $\overline{X}$| ISRS 4.1 & Inv 2.4 |   \@ref(mean1dist) [Dist 1 mean] |
| 4/2/21    | Inference on $\mu$| ISRS 4.1 & Inv 2.5| \@ref(mean1inf) [Inf 1 mean] |
| 4/7/21    | Prediction Intervals | Inv 2.6 | \@ref(predint) [Pred Int] |
| 4/9/21    | Distribution of $\overline{X}_1 - \overline{X}_2$| ISRS 4.3 & Inv 4.2|  \@ref(mean2inf) [Inf 2 means] |
| 4/14/21   |  Inference on $\mu_1 - \mu_2$| ISRS 4.3 & Inv 4.5 - 4.6 |  \@ref(mean2inf) [Inf 2 means]  |
| 4/16/21   | Correlation (r) | ISRS 5.1 & Inv 5.6 - 5.7 | \@ref(cor) [Cor] |
| 4/21/21   | Least Squares line | ISRS 5.2 & Inv 5.10 - 5.11 | \@ref(ls) [LS line] |
| 4/23/21   | Inference on $\beta_1$ | ISRS 5.3 - 5.4 & Inv 5.13 - 5.14 | \@ref(infbeta1) [Inf $\beta_1$] |
| 4/28/21   | Multiple Linear Regression | ISRS 6.1 - 6.2 |  \@ref(MLR) [MLR] |
| 4/30/21   | Model Selection | ISRS 6.3 - 6.4 | \@ref(MLRmod) [MLR model] |
| 5/5/21    |review |  |  \@ref(ex:1819flu) [1918-19 Flu]  |
-->
```
