--- 
title: "Methods in Biostatistics"
author: "Jo Hardin"
date: "2019-04-28"
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

\newcommand{\logit}{\mathrm{logit}}

# Class Information {-}

Class notes for Math 150 at Pomona College: Methods in Biostatistics.  The notes are based primarily on the text **Practicing Statistics**, [@KuiperSklar].


You are responsible for reading your text.  Your text is very good & readable, so you should use it.  Your text is not, however, overly technical.  You should make sure you are coming to class and also reading the materials associated with the activities. 













| Week    	| Topic                      	|  Book Chp   	|   Notes Section |
|:---------	|:---------------------------	|:----------------:	|:----------------:	|
| 1/23/19 	| t-tests / SLR / Intro to R | 2 | \@ref(intro), \@ref(ttest), \@ref(tslr) [t-test] |
| 1/28/19 	| SLR | 2 |  \@ref(SLR)  [SLR]   |
| 1/30/19 	| | | \@ref(intervals), \@ref(cat) [SLR CI] |
| 2/4/19  	| Contingency Analysis | 6 | \@ref(fisher), \@ref(catest)   [.Fisher's Exact Test] |
| 2/6/19 	| | |  \@ref(studies) [Types of studies]
| 2/11/19 	| Contingency Analysis | 6 | \@ref(catest) [RR and OR] |
| 2/13/19 	| | | \@ref(chisq) [ChiSq test] |
| 2/18/19 	| Logistic Regression | 7 | \@ref(logmodel) [Log Reg] |
| 2/20/19 	| | | \@ref(logMLE), \@ref(loginf) [Log MLE and Inference] |
| 2/25/19 	| Logistic Regression | 7 | \@ref(multlog), \@ref(multicol) [Multiple Log Reg] |
| 2/27/19 	| | | \@ref(logstep) [Model Build] |
| 3/4/19  	| Logistic Regression | 7 | \@ref(roc) [ROC] |
| 3/6/19  	| | | \@ref(cv)   [.Cross Validation] | 
| 3/11/19 	| Catch-up / Review | |
| 3/13/19 	| Midterm (Wednesday) |  (2, 6, 7) 	|
| 3/25/19 	| Survival Analysis | 9 | \@ref(timedata), \@ref(KM) [KM curves] |
| 3/27/19 	| | | \@ref(KMCI) [KM CI]  |
| 4/1/19  	| Survival Analysis | 9 |  \@ref(logrank)  [Log Rank test]|
| 4/3/19  	| | |  \@ref(hazfunc) [haz functions] |
| 4/8/19  	| Survival Analysis | 9 | \@ref(coxph) [Cox PH model] |
| 4/10/19  	| | | \@ref(multcoxph) [Multiple Cox PH]  |
| 4/15/19 	| Survival Analysis | 9 |  \@ref(testingph) [Assessing PH] |
| 4/17/19 	| | |  \@ref(othersurv) [Other surv topics]  |
| 4/22/19 	| Ioannidis & mult. compar. | 1.13 | \@ref(Ioannidis)
| 4/22/19 	| |  | \@ref(multcomp)
| 4/29/19 	| Ioannidis & mult. compar. | 1.13 | \@ref(qvals)
| 5/1/19 	| Poisson Regression | 8 |
| 5/6/19  	| Poisson Regression | 8 |
