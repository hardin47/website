--- 
title: "Introduction to (Bio)Statistics"
author: "Jo Hardin"
date: "2020-05-05"
site: bookdown::bookdown_site
header-includes:  \usepackage{blkarray}
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
github-repo: hardin47/website/Math58/
description: "Class notes for both Math 58 and Math 58B at Pomona College: Introduction to Statistics and Introduction to Biostatistics.  The notes are based extensively Introductory Statistics with Randomization and Simulation by Diez, Barr, and Cetinkaya-Rundel."
---


# Class Information {-}

Class notes for Math 58(B) at Pomona College: Introduction to (Bio)Statistics.  The notes are based extensively on "Introductory Statistics with Randomization and Simulation" by Diez, Barr, and \c{C}etinkaya-Rundel [@isrs].  We will also be using many examples (and applets) from "Investigating Statistics, Concepts, Applications, and Methods" by Chance and Rossman [@iscam].


You are responsible for reading the relevant chapters in the text.  The text is very good & readable, so you should use it.  Also, you will have a much deeper understanding of the material if you spend time working through the applets at http://www.rossmanchance.com/iscam3/files.html.  You should make sure you are coming to class and also reading the materials associated with the activities. 













| Day    	| Topic     	|  Book Chap   	|   Notes Section |
|:-------	|:------------|:---------	|:--------------------	|
| 1/21/20 	| Intro to Data / R |  | \@ref(intro) [intro],  \@ref(Jan21) [Jan21]|
| 1/23/20	| Foundations for Inference | ISRS 2.1-2.3 |  \@ref(Jan23) [Jan23], \@ref(ex:gend)  [Examp: gender] |
| 1/28/20	| Normality | ISRS 2.4-2.5 |  \@ref(Jan28) [Jan28], \@ref(CLT)  [CLT] |
| 1/30/20	| Normality | ISRS 2.6-2.7 |  \@ref(Jan30) [Jan30], \@ref(norm)  [Normal Dist] |
| 2/4/20	| Confidence Intervals | ISRS 2.8 |  \@ref(Feb4) [Feb4], \@ref(CI)  [CI] |
| 2/6/20	| Confidence Intervals | ISRS 2.8 |  \@ref(Feb6) [Feb6], \@ref(modCI)  [modifying CI] 
| 2/11/20	| Sampling | ISRS 1.3-1.4 |  \@ref(Feb11) [Feb11], \@ref(samp)  [sampling] |
| 2/13/20	| Errors & Power | ISRS 3.1 & 2.3 |  \@ref(Feb13) [Feb13], \@ref(errors) [Errors&Power] |
| 2/18/20	| 58: Binomial distrib, 58B: RR & OR | ISCAM Chp 1 |  \@ref(Feb18M58) [Feb18 M58], \@ref(Feb18M58B) [Feb18 M58B] |
| 2/20/20	| 58: Binomial Power, 58B: CIs for RR & OR| ISCAM 3.9-3.11 |  \@ref(Feb20M58) [Feb20 M58], \@ref(Feb20M58B) [Feb20 M58B] |
| 2/25/20	| Two binary variables | ISRS 3.2 |  \@ref(Feb25) [Feb25] \@ref(diffprop) [Diff 2 Prop] |
| 2/27/20	| Experiments | ISRS 1.4 & 1.5 |  \@ref(Feb27) [Feb27] \@ref(experim) [Experiments|
| 3/3/20	| chi-sq one variable| ISRS 3.3 |  \@ref(Mar3) [Mar3] \@ref(chisq1) [ChiSq 1 Var] |
| 3/5/20	| chi-sq two variables| ISRS 3.4 |  \@ref(Mar5) [Mar5] \@ref(chisq2) [ChiSq 2 Vars] |
| 3/10/20	|review for Exam 1 |  |  |
| 3/12/20	| Exam 1 |   |  |
| 3/17/20	| Spring Break 1|  |   |
| 3/19/20	| Spring Break 1 |  |  |
| 3/24/20	| Spring Break 2 |  Census  | \@ref(census) [Census] |
| 3/26/20	| Spring Break 2 | COVID-19  | \@ref(covid19) [COVID-19] |
| 3/31/20	| Sampling Dist of $\overline{X}$| ISRS 4.1 & Inv 2.4 |  \@ref(Mar31) [Mar31] \@ref(mean1dist) [Dist 1 mean] |
| 4/2/20	| Inference on $\mu$| ISRS 4.1 & Inv 2.5|  \@ref(Apr2) [Apr2] \@ref(mean1inf) [Inf 1 mean] |
| 4/7/20	| Prediction Intervals | Inv 2.6 |  \@ref(Apr7) [Apr7] \@ref(predint) [Pred Int] |
| 4/9/20	| Distribution of $\overline{X}_1 - \overline{X}_2$| ISRS 4.3 & Inv 4.2|  \@ref(Apr9) [Apr9] \@ref(mean2inf) [Inf 2 means] |
| 4/14/20	|  Inference on $\mu_1 - \mu_2$| ISRS 4.3 & Inv 4.5 - 4.6 |  \@ref(Apr14) [Apr14] \@ref(mean2inf) [Inf 2 means]  |
| 4/16/20	| Correlation (r) | ISRS 5.1 & Inv 5.6 - 5.7 |  \@ref(Apr16) [Apr16] \@ref(cor) [Cor] |
| 4/21/20	| Least Squares line | ISRS 5.2 & Inv 5.10 - 5.11 |  \@ref(Apr21) [Apr21] \@ref(ls) [LS line] |
| 4/23/20	| Inference on $\beta_1$ | ISRS 5.3 - 5.4 & Inv 5.13 - 5.14 |  \@ref(Apr23) [Apr23] \@ref(infbeta1) [Inf $\beta_1$] |
| 4/28/20	| Multiple Linear Regression | ISRS 6.1 - 6.2 |  \@ref(Apr28) [Apr28] \@ref(MLR) [MLR] |
| 4/30/20	| Model Selection | ISRS 6.3 - 6.4 |  \@ref(Apr30) [Apr30] \@ref(MLRmod) [MLR model] |
| 5/5/20	|review |  |  \@ref(ex:1819flu) [1918-19 Flu]  |
