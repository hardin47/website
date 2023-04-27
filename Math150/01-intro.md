# Introduction {#intro}

<div class="figure" style="text-align: center">
<img src="figs/covidvaccine.png" alt="We reject the null hypothesis based on the 'hot damn, check out this chart' test. https://xkcd.com/2400/" width="60%" />
<p class="caption">(\#fig:unnamed-chunk-1)We reject the null hypothesis based on the 'hot damn, check out this chart' test. https://xkcd.com/2400/</p>
</div>


## Course Goals

Our goals in this course are: 

* to better evaluate quantitative information with regards to clinical and biological data. We'll be sure to keep in mind:
    * Careful presentation of data  
    * Consideration of variability  
    * Meaningful comparisons  

* to be able to critically evaluate the medical literature with respect to design, analysis, and interpretation of results.  
* to understand the role of inherent variability and keep it in perspective when inferring results to a population.  
* to critically evaluate medical results given in the mainstream media.  
* to read published studies with skepticism.  Some people (in all fields!) wrongly believe that all studies published in a peer review publication must be 100% accurate and/or well designed studies.  In this course, you will learn the tools to recognize, interpret, and critique statistical results in medical literature.  





<div class="figure" style="text-align: center">
<img src="figs/probstat.jpg" alt="Probability vs. Statistics" width="95%" />
<p class="caption">(\#fig:unnamed-chunk-2)Probability vs. Statistics</p>
</div>



## Using R

Much work will be done in R using RStudio as a front end.  You will need to either download R and RStudio (both are free) onto your own computer or use them on Pomona's server.  


* You may use R on the Pomona server:  https://rstudio.pomona.edu/  (All Pomona students will be able to log in immediately.  Non-Pomona students need to go to ITS at Pomona to get Pomona login information.)

* If you want to use R on your own machine, you may.  Please make sure all components are updated:
R is freely available at http://www.r-project.org/ and is already installed on college computers. Additionally, installing R Studio is required http://rstudio.org/.


* http://swirlstats.com/ is a great way to walk through learning the basics of R.

* All computing assignments should be turned in using R Markdown compiled to pdf.


<div class="figure" style="text-align: center">
<img src="figs/RRstudio.jpg" alt="Taken from [Modern Drive: An introduction to statistical and data sciences via R](https://ismayc.github.io/moderndiver-book/), by Ismay and Kim" width="95%" />
<p class="caption">(\#fig:unnamed-chunk-3)Taken from [Modern Drive: An introduction to statistical and data sciences via R](https://ismayc.github.io/moderndiver-book/), by Ismay and Kim</p>
</div>


<div class="figure" style="text-align: center">
<img src="figs/cookingRstudio.jpg" alt="[Jessica Ward](https://jkrward.github.io/), PhD student at Newcastle University" width="95%" />
<p class="caption">(\#fig:unnamed-chunk-4)[Jessica Ward](https://jkrward.github.io/), PhD student at Newcastle University</p>
</div>



### Experimental Design {-}
In this class we'll talk about techniques used to analyze data from medical studies.  Along with the computational methods, however, we'll continue to think about issues of experimental design and interpretation.

**Descriptive statistics** describe the sample at hand with no intent on making generalizations.  
**Inferential statistics** use a sample to make claims about a population  
**Simple Random Sample** is an unbiased sample.  Sample is selected in such a way that every possible sample of size $n$ is equally likely.  
**Blind / double blind** when the patient and/or doctor do not know which patient is receiving which treatment.  
**Placebo** mock treatment  
**Sample size** reduces variability (large samples make small effects easier to discern)  
**Experiment vs. Observational Study** whether the treatment was assigned by the researchers; randomized experiments make concluding causation possible  
**Funding of study** goals, bias  


