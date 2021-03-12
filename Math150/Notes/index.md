--- 
title: "Methods in Biostatistics"
author: "Jo Hardin"
date: "2021-03-12"
knit: bookdown::render_book
site: bookdown::bookdown_site
output:
  bookdown::pdf_book:
    includes:
      in_header: preamble.tex
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
github-repo: hardin47/website/Math150/
description: "Class notes for Math 150 at Pomona College: Methods in Biostatistics.  The notes are based primarily on the text Practicing Statistics, Kuiper and Sklar"
---


# Class Information {-}

Class notes for Math 150 at Pomona College: Methods in Biostatistics.  The notes are based primarily on the text **Practicing Statistics**, [@KuiperSklar].


You are responsible for reading your text.  Your text is very good & readable, so you should use it.  Your text is not, however, overly technical.  You should make sure you are coming to class and asking lots of questions.













| Week    	| Topic                      	|  Book Chp   	|   Notes Section |
|:---------	|:---------------------------	|:----------------:	|:----------------:	|
| 1/25/21 	| t-tests / SLR  | 2 | \@ref(intro), \@ref(ttest), \@ref(tslr): t-test |
| 1/27/21 	| SLR | 2 |  \@ref(tslr): t-test as SLR   |
| 2/1/21 	| SLR | 2 | \@ref(SLR): SLR |
| 2/3/21  	| Contingency Analysis | 6 | \@ref(fisher) & \@ref(catest): Fisher's Exact Test |
| 2/8/21 	| Contingency Analysis | 6 |  \@ref(studies): Types of studies; \@ref(catest): RR and OR
| 2/10/21 	| Contingency Analysis | 6 | \@ref(ciOR): Conf Int|
| 2/15/21 	| Logistic Regression | 7 | \@ref(logmodel): Log Reg |
| 2/17/21 	| | | \@ref(logMLE): MLE |
| 2/22/21 	| Logistic Regression | 7 | \@ref(loginf): Inference |
| 2/24/21 	| | | \@ref(multlog), \@ref(multicol): Multiple Log Reg |
| 3/1/21  	| Logistic Regression | 7 | \@ref(logstep): Model Build |
| 3/3/21  	| | |  \@ref(roc): ROC | 
| 3/8/21 	| Spring Break | |
| 3/10/21 	| Spring Break |  	|
| 3/15/21 	| Cross Validation |    |    \@ref(cv): Cross Validation; |
| 3/17/21 	| Review / Exam 1 (Wednesday) |  (2, 6, 7) 	|
| 3/22/21 	| Survival Analysis | 9 | \@ref(timedata), \@ref(KM): KM curves |
| 3/24/21 	| | | \@ref(KMCI): KM CI  |
| 3/29/21  	| Survival Analysis | 9 |  \@ref(logrank): Log Rank test|
| 3/31/21  	| | |  \@ref(hazfunc): hazard functions |
| 4/5/21  	| Survival Analysis | 9 | \@ref(coxph): Cox PH model |
| 4/7/21  	| | | \@ref(multcoxph): Multiple Cox PH  |
| 4/12/21 	| Survival Analysis | 9 |  \@ref(testingph): Assessing PH |
| 4/14/21 	| Ioannidis & mult. compar. | 1.13 | \@ref(Ioannidis): False Published
| 4/19/21 	| |  | \@ref(multcomp): Mult Comp
| 4/26/21 	| Ioannidis & mult. compar. | 1.13 | \@ref(qvals): qvalues
| 4/28/21 	| Exam 2 (Wednesday) |  (9, multiple comparisons) 	|
| 5/3/21 	| Poisson Regression | 8 | \@ref(regPois): Poisson model |  
| 5/5/21  	| Poisson Regression | 8 | \@ref(inferPois): Poisson inference |
