--- 
title: "Methods in Biostatistics"
author: "Jo Hardin"
date: "2019-02-18"
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













| Week    	| Topic                      	|  Book Chapter   	|   Notes Section 	|
|:---------	|:---------------------------	|:----------------:	|:----------------:	|
| 1/23/19 	| t-tests / SLR / Intro to R 	|         2        	| \@ref(intro), \@ref(ttest), \@ref(tslr)  |
| 1/28/19 	| SLR                        	|         2        	|  \@ref(SLR)     |
| 1/30/19 	|                           	|                  	| \@ref(intervals), \@ref(cat) |
| 2/4/19  	| Contingency Analysis       	|         6        	|\@ref(fisher), \@ref(catest) |
| 2/6/19 	|       	|                 	|  \@ref(studies)
| 2/11/19 	| Contingency Analysis       	|         6        	| \@ref(catest)
| 2/13/19 	|        	|                	| \@ref(chisq)
| 2/18/19 	| Logistic Regression        	|         7        	|
| 2/25/19 	| Logistic Regression        	|         7        	|
| 3/4/19  	| Logistic Regression        	|         7        	|
| 3/11/19 	| Logistic Regression        	|         7        	|
| 3/13/19 	| Midterm (Wednesday)        	|  (2, 6, 7 (ish)) 	|
| 3/25/19 	| Survival Analysis          	|         9        	|
| 4/1/19  	| Survival Analysis          	|         9        	|
| 4/8/19  	| Survival Analysis          	|         9        	|
| 4/15/19 	| Survival Analysis          	|         9        	|
| 4/22/19 	| Ioannidis & mult. compar. 	| handouts & 1.13 	|
| 4/29/19 	| Poisson Regression         	|         8        	|
| 5/6/19  	| Poisson Regression         	|         8        	|
