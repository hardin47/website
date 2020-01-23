# Foundationa for Inference

## 1/23/20 Agenda {#Jan23}
1. Example: gender discrimination
2. `infer` again
3. Hypothesis testing structure



### Vocabulary {-}
* A  **statistic** is a numerical measurement we get from the sample, a function of the data.
* A  **parameter** is a numerical measurement of the population.  We never know the true value of the parameter.
* An  **estimator** is a function of the unobserved data that tries to approximate the unknown parameter value.
* An  **estimate** is the value of the estimator for a given set of data.  [Estimate and statistic can be used interchangeably.]

## Examples

### Examp: Gender Discrimination (@isrs, pg 61)

> We consider a study investigating gender discrimination in the 1970s, which is set in the context of personnel decisions within a bank.^[Rosen B and Jerdee T. 1974. Influence of sex role stereotypes on personnel decisions. Journal ofApplied Psychology 59(1):9-14.] The research question we hope to answer is, "Are females discriminated against in promotion decisions made by male managers?"

> The participants in this study were 48 male bank supervisors attending a management institute at the University of North Carolina in 1972. They were asked to assume the role of the personnel director of a bank and were given a personnel file to judge whether the person should be promoted to a branch manager position. The files given to the participants were identical, except that half of them indicated the candidate was male and the other half indicated the candidate was female. These files were randomly assigned to the subjects.

> For each supervisor we recorded the gender associated with the assigned file and the promotion decision. Using the results of the study summarized in Table 2.1, we would like to evaluate if females are unfairly discriminated against in promotion decisions. In this study, a smaller proportion of females are promoted than males (0.583 versus 0.875), but it is unclear whether the difference provides convincing evidence that females are unfairly discriminated against.

|   |        |          | decision     |       |
|---|--------|----------|--------------|-------|
|   |        | promoted | not promoted | total |
|   | male   | 21       | 3            | 24    |
|   | female | 14       | 10           | 24    |
|   | total  | 35       | 13           | 48    |


#### Always Ask {-}

* What are the observational units?
    - supervisor
* What are the variables?  What type of variables?
    - (1) whether the resume was male or female, (2) decision to promote or not promote
* What is the statistic?
    - $\hat{p}_m - \hat{p}_f$ = 21/24 - 14/24 = 0.292  (the difference between the proportion of men who were promoted and the proportion of women who were promoted)
* What is the parameter?
    - $p_m - p_f$ = the true difference in the probability of a man being promoted minus the probability of a woman being promoted.
    
H0: Null hypothesis. The variables gender and decision are independent. They have
no relationship, and the observed difference between the proportion of males and
females who were promoted, 29.2%, was due to chance.

HA: Alternative hypothesis. The variables gender and decision are not indepen-
dent. The difference in promotion rates of 29.2% was not due    


```r
library(infer)

# to control the randomness
set.seed(47)

# first create a data frame with the Infant data
discrim <- data.frame(gender = c(rep("male", 24), rep("female", 24)),
                      decision = c(rep("promote", 21), rep("not", 3), 
                                   rep("promote", 14), rep("not", 10)))

discrim %>% head()
```

```
##   gender decision
## 1   male  promote
## 2   male  promote
## 3   male  promote
## 4   male  promote
## 5   male  promote
## 6   male  promote
```

```r
# then find the proportion who help
(diff_obs <- discrim %>%
    specify(decision ~ gender, success = "promote") %>%
    calculate(stat = "diff in props", order = c("male", "female")) )
```

```
## # A tibble: 1 x 1
##    stat
##   <dbl>
## 1 0.292
```

```r
# now apply the infer framework to get the null differences in proportions
null_discrim <- discrim %>%
  specify(decision ~ gender, success = "promote") %>%
  hypothesize(null = "independence") %>%
  generate(reps = 1000, type = "permute") %>%
  calculate(stat = "diff in props", order = c("male", "female"))

# then visualize the null sampling distribution & p-value
visualize(null_discrim) +
  shade_p_value(obs_stat = diff_obs, direction = "two_sided")
```

<img src="02-FoundInf_files/figure-html/unnamed-chunk-1-1.png" width="672" />

```r
# calculate the actual p-value
null_discrim %>%
  get_p_value(obs_stat = diff_obs, direction = "two_sided")
```

```
## # A tibble: 1 x 1
##   p_value
##     <dbl>
## 1    0.06
```


### Examp: Opportunity Cost

## Structure of Hypothesis testing

### Hypotheses

* **Hypothesis Testing** compares data to the expectation of a specific null hypothesis.  If the data are unusual, assuming that the null hypothesis is true, then the null hypothesis is rejected.  

* The **Null Hypothesis**, $H_0$, is a specific statement about a population made for the purposes of argument.  A good null hypothesis is a statement that would be interesting to reject. 

* The **Alternative Hypothesis**, $H_A$, is a specific statement about a population that is in the researcher's interest to demonstrate.  Typically, the alternative hypothesis contains all the values of the population that are not included in the null hypothesis. 

* In a **two-sided** (or two-tailed) test, the alternative hypothesis includes values on both sides of the value specified by the null hypothesis.

* In a **one-sided** (or one-tailed) test, the alternative hypothesis includes parameter values on only one side of the value specified by the null hypothesis. $H_0$ is rejected only if the data depart from it in the direction stated by $H_A$.

* The **test statistic** is a quantity calculated from the data that is used to evaluate how compatible the data are with the result expected under the null hypothesis.

* The **null distribution** is the sampling distribution of outcomes for a test statistic under the assumption that the null hypothesis is true. 

* The **p-value** is the probability of obtaining the data (or data showing as great or greater difference from the null hypothesis) if the null hypothesis is true.  *The p-value is a number calculated from the dataset.*


#### Examples of Hypotheses {-}
Identify whether each of the following statements is more appropriate as the null hypothesis or as the alternative hypothesis in a test:

* The number of hours preschool children spend watching TV affects how they behave with other children when at day care.  *Alternative*

* Most genetic mutations are deleterious.  *Alternative*

* A diet of fast foods has no effect on liver function.  *Null*

* Cigarette smoking influences risk of suicide.  *Alternative*

* Growth rates of forest trees are unaffected by increases in carbon dioxide levels in the atmosphere.  *Null*

* The number of hours that grade-school children spend doing homework predicts their future success on standardized tests.  *Alternative*

* King cheetahs on average run the same speed as standard spotted cheetahs. *Null*

* The risk of facial clefts is equal for babies born to mothers who take folic acid supplements compared with those from mothers who do not.  *Null*

* The mean length of African elephant tusks has changed over the last 100 years.  *Alternative*

* Caffeine intake during pregnancy affects mean birth weight.  *Alternative*

#### What is an Alternative Hypothesis? {-}

Consider the brief video from the movie Slacker, an early movie by Richard Linklater (director of Boyhood, School of Rock, Before Sunrise, etc.). You can view the video here from starting at 2:22 and ending at 4:30:  https://www.youtube.com/watch?v=b-U_I1DCGEY

In the video, a rider in the back of a taxi (played by Linklater himself) muses about alternate realities that could have happened as he arrived in Austin on the bus. What if instead of taking a taxi, he had found a ride with a woman at the bus station? He could have take a different road into a different alternate reality, and in that reality his current reality would be an alternate reality. And so on.

What is the point?  Why did we see the video?  How does it relate the to the material from class?  What is the relationship to sampling distributions?



## Central Limit Theorem / Normal Distribution

## Confidence Intervals
