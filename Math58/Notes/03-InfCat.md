# Inference for categorical data



## Inference for a single proportion

Previously, we used the normal approximation to describe the distribution of different values for $\hat{p}$ when random samples are taken.  We learned that the central limit theorem describes the distribution such that if (see box in section 3.1.1 on page 124):

1. we take random, independent samples
2. $np \geq 10$ and $n(1-p) \geq 10$

then $$\hat{p} \sim N(p, \sqrt{p(1-p)/n}).$$

If the $$\mbox{Z score} = \frac{\hat{p} - p}{\sqrt{p(1-p)/n}}$$ is bigger than the Z* value at a particular value of $\alpha$, then we know we can reject $p$ (the Null Hypothesis value) as the true population parameter.

If an interval estimate is desired, and no $p$ is hypothesized, then a confidence interval is created using:

$$\hat{p} \pm z* \sqrt{\hat{p}(1-\hat{p})}/n.$$

IMPORTANT: recall, the above interval is a method for capturing the **parameter**.


## 2/18/20 Math 58 Agenda {#Feb18M58}
0. Math 58 Only
1. Binomial distribution


## 2/20/20 Math 58 Agenda {#Feb20M58}
0. Math 58 Only
1. Binomial hypothesis testing
2. Power
3. Confidence Intervals

## Binomial distribution (Math 58 only)

Math 58 (not Math 58B) will cover the binomial distribution which describes the exact probabilities associated with binary outcomes.

@isrs do not discuss the binomial distribution.  @iscam, however, provide quite a bit of detail about the binomial concepts in chapter 1.


### Example: pop quiz 
There are 5 problems on this quiz; everyone number their papers 1. to 5.  Each of the problems is multiple choice with answers A, B, C, or D.   Go ahead.  We'll grade the papers when everyone is done. 

Solution:  1.B, 2.C, 3.B, 4.C, 5.A


* The **binomial distribution** provides the probability distribution for the number of "successes" in a fixed number of independent trials, when the probability of success is the same in each trial.

  - Outcome of each trial can be stated as a success / failure.
  - The number of trials ($n$) is fixed.
  - Separate trials are independent.
  - The probability of success ($p$) is the same in every trial.


\begin{eqnarray*}
P(X=k) &=& {n \choose k} p^k (1-p)^{n-k}\\
{n \choose k} &=& \frac{ n!}{(n-k)! k!}
\end{eqnarray*}

In our example... $n=5$.  How many ways are there to get 2 successes?
\begin{eqnarray*}
{5 \choose 2} &=& \frac{ 5!}{2! 3!} = \frac{ 5 \cdot 4 \cdot 3 \cdot 2 \cdot 1}{(3 \cdot 2 \cdot 1)(2 \cdot 1)}
\end{eqnarray*}

The numerator represents the number of possibilities for each of the 5 questions.  But we don't distinguish between successes, so we don't want to double count those.  Similarly for failures.


|  |  |  |  |  |
|:-----:|:-----:|:-----:|:-----:|:-----:|
| SSSFF | SSFFS | SSFSF | SFFSS | SFSFS |
| SFSSF | FFSSS | FSFSS | FSSFS | FSSSF |

In class: different groups work out the probability of 0, 1, 2, ... 5 correct answers.

\begin{eqnarray*}
P(X=0) = {5 \choose 0} (0.25)^0(0.75)^5  = 0.2373 && P(X=3) = {5 \choose 3} (0.25)^3(0.75)^2  = 0.0879\\
P(X=1) = {5 \choose 1} (0.25)^1(0.75)^4  = 0.3955 && P(X=4) = {5 \choose 4} (0.25)^4(0.75)^1  = 0.0146\\
P(X=2) = {5 \choose 2} (0.25)^2(0.75)^3  = 0.2637 && P(X=5) = {5 \choose 5} (0.25)^5(0.75)^0  = 0.0010\\
\end{eqnarray*}



```r
library(mosaic)
xpbinom(2, size = 5, prob = 0.25)  # P(X <= 2) vs. P(X > 2)
```

<img src="03-InfCat_files/figure-html/unnamed-chunk-1-1.png" width="480" style="display: block; margin: auto;" />

```
## [1] 0.8964844
```

```r
xpbinom(3, size = 5, prob = 0.25)  # P(X <= 3) vs. P(X > 3)
```

<img src="03-InfCat_files/figure-html/unnamed-chunk-1-2.png" width="480" style="display: block; margin: auto;" />

```
## [1] 0.984375
```

### Binomial Hypothesis Testing

Consider the example from the beginning of the semester on babies choosing the helper toy (instead of the hinderer), section \@ref(ex:helper).  Recall that 14 of the 16 babies chose the helper toy.

Does the binomial distribution apply to this setting?  Let's check:

* two choices?  Yes, helper or hinderer.
* fixed $n$?  Yes, there were 16 babies.
* $p$ same?  Presumably.  There is some inherent $p$ which represents the probability that a baby would choose a helper toy.  And we are choosing babies from a population with that $p$.
* independent?  I hope so!  These babies don't know each other or tell each other about the experiment.

If there really had been no inclination of the babies to choose the helper toy, how many babies would the researchers have needed to choose the helper in order to get published?

Let's choose $\alpha = 0.01$.  That means that if $p=0.5$, then we should make a Type I error less than 1% of the time.  From the calculations below, we see that the rejection region is $\{ X \geq 14 \}$.  That is, for the researchers to reject the null hypothesis at the $\alpha = 0.01$ significance level, they would have needed to see 14, 15, or 16 babies choose the helper (out of 16).

P(X \geq 12) = {16 \choose 12} (0.5)^{12}(0.5)^{4} + 0.0106 = 0.0384
P(X \geq 13) = {16 \choose 13} (0.5)^{13}(0.5)^{3} + 2.09e-03 = 0.0106
P(X \geq 14) = {16 \choose 14} (0.5)^{14}(0.5)^{2} + 2.59e-04 = 2.09e-03
P(X \geq 15) = {16 \choose 15} (0.5)^{15}(0.5)^{1} + 1.53e-05 = 2.59e-04
P(X = 16) = {16 \choose 16} (0.5)^{16}(0.5)^{0} = 1.53e-05


```r
xpbinom(12, 16, 0.5)
```

<img src="03-InfCat_files/figure-html/unnamed-chunk-2-1.png" width="480" style="display: block; margin: auto;" />

```
## [1] 0.9893646
```

```r
xpbinom(13, 16, 0.5)
```

<img src="03-InfCat_files/figure-html/unnamed-chunk-2-2.png" width="480" style="display: block; margin: auto;" />

```
## [1] 0.9979095
```

### Binomial Power

Let's say that the researchers had an inkling that babies liked helpers.  But they thought that probably only about 70% of babies preferred helpers.  The researchers then needed to decide if 16 babies was enough for them to do their research.  That is, if they only measure 16 babies, will they have convincing evidence that babies actually prefer the helper?  Said differently, with 16 babies, what is the power of the test?

\begin{eqnarray*}
\mbox{power} &=& P(X \geq 14 | p = 0.7)\\
&=& P(X=14 | p=0.7) + P(X = 15 | p=0.7)  + P(X = 16 | p=0.7)\\
&=& {16 \choose 14} (0.7)^{14}(0.3)^{2} + {16 \choose 15} (0.7)^{15}(0.3)^{1} + {16 \choose 16} (0.7)^{16}(0.3)^{0}\\
&=& 0.099
\end{eqnarray*}

Yikes!  What if babies actually prefer the helper 90% of the time?

$$\mbox{power} = P(X \geq 14 | p = 0.9) = 0.789$$


```r
1 - xpbinom(13, 16, 0.7)
```

<img src="03-InfCat_files/figure-html/unnamed-chunk-3-1.png" width="480" style="display: block; margin: auto;" />

```
## [1] 0.09935968
```

```r
1 - xpbinom(13, 16, 0.9)
```

<img src="03-InfCat_files/figure-html/unnamed-chunk-3-2.png" width="480" style="display: block; margin: auto;" />

```
## [1] 0.7892493
```


### Binomial Confidence Intervals for $p$

The binomial distribution does not allow for the "plus or minus" creation of a range of plausible values for the confidence interval.  Instead, hypothesis testing is used directly to come up with plausible values for the parameter $p$.  The method outlines below is much more tedious than the z - CI , but it does produce an exact interval for $p$ with the appropriate coverage level.


Consider a confidence interval created in the following way:

* Step 1: Collect data, calculate $\hat{p}$ for that particular dataset.
* Step 2: Test a series of values for $p'$ using the observed $\hat{p}$ from the dataset at hand.
* Step 3: List all the values for $p'$ that were not rejected.  Sort them and find the smallest and biggest value:  ($p_{small}, p_{big}$).

Ask yourself whether the **true** parameter (let's call it $p$) is in the interval.  

* If a type I error was made when $p$ was tested, then $p$ is not in the interval.
* If $p$ was not rejected, then it is in the interval.

How often will a type I error be made?  5% of the time.  Therefore ($p_{small}, p_{big}$) is a 95% CI for the true population parameter $p$.

## 2/18/20 Math 58B Agenda {#Feb18M58B}
0. Math 58B Only
1. Relative Risk
2. Odds Ratios
3. Case-control studies


## 2/20/20 Math 58B Agenda {#Feb20M58B}
0. Math 58B Only
1. CI for relative risk
2. CI for odds ratios

## Relative Risk (Math 58B only)


Math 58B (not Math 58) will cover relative risk, the ratio of two success proportions.

Previously (e.g., Gender discrimination example, \@ref(ex:gend)) when working with the proportion of success in two separate groups, the proportion of success was subtracted (see also lab 4).  Next week, differences in proportions will be revisited, see section \@ref(diffprop).  First up, the new statistic of interest will be relative risk, followed by odds ratios.


In particular, interest is in the ratio of probabilities.  [Note: the decision to measure a ratio instead of a difference comes with trying to model the particular research question at hand.  There is nothing inherently better about ratios versus differences.  It is, however, often easier to think about how a small probability changes if it is done as a ratio instead of a difference.]

$$\mbox{Relative Risk (RR)} = \frac{\mbox{proportion of successes in group 1}}{\mbox{proportion of successes in group 2}}$$

\BeginKnitrBlock{definition}<div class="definition"><span class="definition" id="def:unnamed-chunk-4"><strong>(\#def:unnamed-chunk-4) </strong></span>**Relative Risk**  The relative risk (RR) is the ratio of risks for each group.  We say, "The risk of success is **RR** times higher for those in group 1 compared to those in group 2."</div>\EndKnitrBlock{definition}

### Inference on Relative Risk 

|            | explanatory 1 | explanatory 2 |
|------------|:-------------:|:-------------:|
| response 1 |       A       |       B       |
| response 2 |       C       |       D       |

* **Statistic:** $$\hat{p}_1 / \hat{p}_2 = \frac{A/(A+C) }{B/ (B+D)}$$
* **Null Hypothesis:** $$H_0: p_1/p_2 = 1$$
* **CI:** The CI is for the true relative risk in the population, $p_1/p_2$

$$\mbox{exponentiate} \Bigg[ \ln(\hat{p}_1/\hat{p}_2) \pm z^*\sqrt{ \frac{1}{A} - \frac{1}{A+C} + \frac{1}{B} - \frac{1}{B+D}}\Bigg]$$

To remember with relative risk:

* The percent change is defined as:
\begin{eqnarray*}
(RR - 1)*100\% = \frac{\hat{p}_1 - \hat{p}_2}{\hat{p}_2}*100\% = \mbox{percent change from 2 to 1}
\end{eqnarray*}

* The CI for $p_1/p_2$ is typically considered significant if 1 is not in the interval.  That is because usually the null hypothesis is $H_0: p_1 = p_2$ or equivalently, $H_0: p_1/p_2 = 1$.


## Odds Ratios (Math 58B only)

Experience shows that very few introductory statistics students have seen odds or odds ratios in their prior mathematical or scientific study.  That makes odds ratios a **new** idea, but not a fundamentally hard idea.  Which is to say, it is perfectly acceptable to find relative risk a very intuitive idea that you can easily discuss and odds ratios a very strange idea which is hard to interpret.  Do not be discouraged!  Odds ratios are *not* fundamentally harder to understand than relative risk, they are simply a new idea.

Math 58B (not Math 58) will cover odds ratios, the ratio of two success odds.


@isrs do not discuss relative risk and odds ratios.  @iscam, however, provide quite a bit of detail about the concepts in Investigations 3.9, 3.10, 3.11.

$$\mbox{risk} = \frac{\mbox{number of successes}}{\mbox{total number}}$$

$$\mbox{odds} = \frac{\mbox{number of successes}}{\mbox{number of failures}}$$

$$\mbox{Odds Ratio (OR)} = \frac{\mbox{odds of success in group 1}}{\mbox{odds of success in group 2}}$$


\BeginKnitrBlock{definition}<div class="definition"><span class="definition" id="def:unnamed-chunk-5"><strong>(\#def:unnamed-chunk-5) </strong></span>**Odds Ratio** A related concept to risk is odds.  It is often used in horse racing, where "success" is typically defined as losing.  So, if the odds are 3 to 1 we would expect to lose 3/4 of the time.  The odds ratio (OR) is the ratio of odds for each group.  We say, "The odds of success is **OR** times higher for those in group 1 compared to those group 2."</div>\EndKnitrBlock{definition}


### Example: Smoking and Lung Cancer^[Inv 3.10, Chance & Rossman, ISCAM] 

> After World War II, evidence began mounting that there was a link between cigarette smoking and pulmonary carcinoma (lung cancer). In the 1950s, three now classic articles were published on the topic. One of these studies was conducted in the United States by Wynder and Graham.^["Tobacco Smoking as a Possible Etiologic Factor in Bronchiogenic Cancer," 1950, Journal of the American Medical Association] They found records from a large number of patients with a specific type of lung cancer in hospitals in California, Colorado, Missouri, New Jersey, New York, Ohio, Pennsylvania, and Utah. Of those in the study, the researchers focused on 605 male patients with this form of lung cancer. Another 780 male hospital patients with similar age and economic distributions without this type of lung cancer were interviewed in St. Louis, Boston, Cleveland, and Hines, IL. Subjects (or family members) were interviewed to assess their smoking habits, occupation, education, etc. The table below classifies them as non-smoker or light smoker, or at least a moderate smoker.

The following two-way table replicates the counts for the 605 male patients with the same form of cancer and for the "control-group" of 780 males.

|          |    none   |  light  | mod heavy |   heavy   | excessive |   chain   |
|----------|:---------:|:-------:|:---------:|:---------:|:---------:|:---------:|
|          | $<$ 1/day | 1-9/day | 10-15/day | 16-20/day | 21-34/day | 35$+$/day |
| patients |     8     |    14   |     61    |    213    |    187    |    122    |
| controls |    114    |    90   |    148    |    278    |     90    |     60    |



Given the results of the study, do you think we can generalize from the sample to the population?  Explain and make it clear that you know the difference between a sample and a population.


In order to focus the research question, combine the data into two groups:  light smoking is less than 10 cigarettes per day, heavy smoking is 10 or more cigarettes per day.  The 2x2 observed data is now:


|   |  light smoking |  heavy smoking |   |
|---------|:---:|:----:|:----:|
| cancer  |  22 |  583 |  605 |
| healthy | 204 |  576 |  780 |
|         | 226 | 1159 | 1385 |

* Causation?  (Is it an experiment or are there possible confounding variables?)
* Case-control study  (605 with lung cancer, 780 without... baseline rate?)
* What is the response variable and what is the explanatory variable?  What happens if the role of the two variables is switched?

| Group A               | Group B               |
|-----------------------|-----------------------|
| expl = smoking status | expl = lung cancer    |
| resp = lung cancer    | resp = smoking status |

* If lung cancer is considered a success and light smoking is baseline:
\begin{eqnarray*}
RR &=& \frac{583/1159}{22/226} = 5.17\\
OR &=& \frac{583/576}{22/204} = 9.39\\
\end{eqnarray*}

<strike>The risk of lung cancer is 5.17 times higher for those who heavy smoke than for those who don't smoke.</strike>

The odds of lung cancer is 9.39 times higher for those who heavy smoke than for those who don't smoke.


* If heavy smoking is considered a success and healthy is baseline:
\begin{eqnarray*}
RR &=& \frac{583/605}{576/780} = 1.31\\
OR &=& \frac{583/22}{576/204} = 9.39\\
\end{eqnarray*}

The risk of heavy smoking is 1.31 times higher for those who have lung cancer than for those who don't have lung cancer.

The odds of heavy smoking is 9.39 times higher for those who have lung cancer than for those who don't have lung cancer.


* Observational study (who worked in each place?)  
* Cross sectional (only one point in time)  
* Healthy worker effect (who stayed home sick?)    
* **Explanatory variable** is one that is a potential explanation for any changes (here smoking level).  
* **Response variable** is the measured outcome of interest (here lung cancer).  


* **Case-control study:** identify observational units by the response variable
* **Cohort study:** identify observational units by the explanatory variable 

The risk of being a light smoker if the person has lung cancer can be estimated, but there is no possible way to estimate the risk of lung cancer if you are a light smoker.  Consider a *population* of 1,000,000 people:


|   |  no smoking  |  light smoking |     |
|---------|:-------:|:-------:|:---------:|
| cancer  |  1,000  |  49,000 |   50,000  |
| healthy | 899,000 |  51,000 |  950,000  |
|         | 900,000 | 100,000 | 1,000,000 |

\begin{eqnarray*}
P(\mbox{light} | \mbox{lung cancer}) &=& \frac{49,000}{50,000} = 0.98\\
P(\mbox{lung cancer} | \mbox{light}) &=& \frac{49,000}{100,000} = 0.49\\
\end{eqnarray*}


* What is the explanatory variable?
* What is the response variable?
* relative risk?
* odds ratio?
*
| Group A               | Group B               |
|-----------------------|-----------------------|
| expl = smoking status | expl = lung cancer    |
| resp = lung cancer    | resp = smoking status |



* If lung cancer is considered a success and no smoking is baseline:
\begin{eqnarray*}
RR &=& \frac{49/100}{1/900} = 441\\
OR &=& \frac{49/51}{1/899} = 863.75\\
\end{eqnarray*}

* If light smoking is considered a success and healthy is baseline:
\begin{eqnarray*}
RR &=& \frac{49/50}{51/950} = 18.25\\
OR &=& \frac{49/1}{51/899} = 863.75\\
\end{eqnarray*}

OR is the same no matter which variable you choose as explanatory versus response!  Though, in general, baseline odds or baseline risk (which we can't know with a case-control study) is still a number that can provide a lot of information about the study.


IMPORTANT:  Relative risk cannot be used with case-control studies but odds ratios can be used!

### Inference on Odds Ratios 


|            | explanatory 1 | explanatory 2 |
|------------|:-------------:|:-------------:|
| response 1 |       A       |       B       |
| response 2 |       C       |       D       |

* **Statistic:** $$\hat{OR} = \frac{A D}{B C}$$
* **Null Hypothesis:** $$H_0: OR = 1$$
* **CI:** The CI is for the true odds ratio in the population, $OR$

$$\mbox{exponentiate} \Bigg[ \ln{\hat{OR}} \pm z^* \sqrt{ \frac{1}{A} + \frac{1}{B} + \frac{1}{C} + \frac{1}{D}}\Bigg]$$

#### OR is more extreme than RR

Without loss of generality, assume the true $RR > 1$, implying $p_1 / p_2 > 1$ and $p_1 > p_2$.

Note the following sequence of consequences:

\begin{eqnarray*}
RR = \frac{p_1}{p_2} &>& 1\\
\frac{1 - p_1}{1 - p_2} &<& 1\\
\frac{ 1 / (1 - p_1)}{1 / (1 - p_2)} &>& 1\\
\frac{p_1}{p_2} \cdot \frac{ 1 / (1 - p_1)}{1 / (1 - p_2)} &>& \frac{p_1}{p_2}\\
OR &>& RR
\end{eqnarray*}

### Confidence Interval for OR (same idea for RR)

Due to some theory that we won't cover:

\begin{eqnarray*}
SE(\ln (\hat{OR})) &\approx& \sqrt{ \frac{1}{A} + \frac{1}{B} + \frac{1}{C} + \frac{1}{D}}
\end{eqnarray*}


So, a $(1-\alpha)100\%$ CI for the $\ln(OR)$ is:
\begin{eqnarray*}
\ln(\hat{OR}) \pm z_{1-\alpha/2} SE(\ln(\hat{OR}))
\end{eqnarray*}

Which gives a $(1-\alpha)100\%$ CI for the $OR$:
\begin{eqnarray*}
(e^{\ln(OR) - z_{1-\alpha/2} SE(\ln(OR))}, e^{\ln(OR) + z_{1-\alpha/2} SE(\ln(OR))})
\end{eqnarray*}


$\frac{583/576}{22/204} = 9.39$
Back to the example... OR = 9.39.
\begin{eqnarray*}
SE(\ln(\hat{OR})) &=& \sqrt{\frac{1}{583} + \frac{1}{576} + \frac{1}{22} + \frac{1}{204}}\\
&=& 0.232\\
90\% \mbox{ CI for } \ln(OR) && \ln(9.39) \pm 1.645 \cdot 0.232\\
&& 2.24 \pm 1.645 \cdot 0.232\\
&& (1.858, 2.62)\\
90\% \mbox{ CI for } OR && (e^{1.858}, e^{2.62})\\
&& (6.41, 13.75)\\
\end{eqnarray*}


```r
(SE_lnOR = sqrt( 1/583 + 1/576 + 1/22 + 1/204))
```

```
## [1] 0.2319653
```

```r
xqnorm(0.95, 0, 1, plot=FALSE)
```

```
## [1] 1.644854
```

```r
log(9.39) - 1.645*0.232
```

```
## [1] 1.858005
```

```r
log(9.39) + 1.645*0.232
```

```
## [1] 2.621285
```

```r
exp(log(9.39) - 1.645*0.232)
```

```
## [1] 6.410936
```

```r
exp(log(9.39) + 1.645*0.232)
```

```
## [1] 13.75339
```

We are 90% confident that the true $\ln(OR)$ is between 1.858 and 2.62.  We are 90% confident that the true $OR$ is between 6.41 and 13.75.  That is, the true odds of getting lung cancer if you smoke heavily are somewhere between 6.41 and 13.75 times higher than if you don't, with 90% confidence.



Note 1: we use the theory which allows us to understand the sampling distribution for the $\ln(\hat{OR}).$  We use the *process* for creating CIs to transform back to $OR$.

<!--
Note 2: We do not use the t-distribution here because we are not estimating the population standard deviation.
-->

Note 2: There are not good general guidelines for checking whether the sample sizes are large enough for the normal approximation.  Most authorities agree that one can get away with smaller sample sizes here than for the differences of two proportions.  If the sample sizes pass the rough check discussed for $\chi^2$, they should be large enough to support inferences based on the approximate normality of the log of the estimated odds ratio, too.  [@sleuth, page 541]

From one author, for the normal approximation to hold, we need the expected counts in each cell to be at least 5. [@pagano, page 355]


Note 3: If any of the cells are zero, many people will add 0.5 to that cell's observed value.


Note 4: The OR will always be more extreme than the RR (one more reason to be careful...)

<!--
\begin{eqnarray*}
\mbox{assume } && \frac{X_1 / n_1}{X_2 / n_2} = RR > 1\\
& & \\
\frac{X_1}{n_1} &=& RR \ \ \frac{X_2}{n_2}\\
\frac{X_1}{n_1 - X_1} &=& RR \ \ \bigg( \frac{n_1}{n_2}  \frac{n_2 - X_2}{n_1 - X_1} \bigg) \frac{X_2}{n_2-X_2}\\
OR &=& RR \ \ \bigg(\frac{n_1}{n_2} \bigg) \frac{n_2 - X_2}{n_1 - X_1}\\
 &=& RR \ \ \bigg(\frac{1/n_2}{1/n_1} \bigg) \frac{n_2 - X_2}{n_1 - X_1}\\
 &=& RR  \ \ \frac{1 - X_2/n_2}{1 - X_1/n_1}\\
 & > & RR
\end{eqnarray*}
[$1 - \frac{X_2}{n_2} > 1 - \frac{X_1}{n_1} \rightarrow \frac{1 - \frac{X_2}{n_2}}{1 - \frac{X_1}{n_1}} > 1$]
-->

Note 5: $RR \approx OR$ if RR is very small (the denominator of the OR will be very similar to the denominator of the RR).




### Example: MERS-CoV {#ex:cov}

The following study is a case-control study, so it is impossible to estimate the proportion of cases in the population.  However, you will notice that the authors don't try to do that.  They flip the explanatory and response variables so that the case status is predicting all of the other clinical variables.  In such a setting, the authors would have been able to present relative risk estimates, but they still chose to provide odds ratios (possibly because odds ratios are somewhat standard in the medical literature).

Middle East Respiratory Syndrome Coronavirus: A Case-Control Study of Hospitalized Patients^[ 
Jaffar A. Al-Tawfiq, Kareem Hinedi, Jihad Ghandour, Hanan Khairalla, Samir Musleh, Alaa Ujayli, Ziad A. Memish, Clinical Infectious Diseases, Volume 59, Issue 2, 15 July 2014, Pages 160–165, https://doi.org/10.1093/cid/ciu226]

> Background. There is a paucity of data regarding the differentiating characteristics of patients with laboratory-confirmed and those negative for Middle East respiratory syndrome coronavirus (MERS-CoV).

> Methods. This is a hospital-based case-control study comparing MERS-CoV–positive patients (cases) with MERS-CoV–negative controls.

> Results. A total of 17 case patients and 82 controls with a mean age of 60.7 years and 57 years, respectively (P = .553), were included. No statistical differences were observed in relation to sex, the presence of a fever or cough, and the presence of a single or multilobar infiltrate on chest radiography. The case patients were more likely to be overweight than the control group (mean body mass index, 32 vs 27.8; P = .035), to have diabetes mellitus (87% vs 47%; odds ratio [OR], 7.24; P = .015), and to have end-stage renal disease (33% vs 7%; OR, 7; P = .012). At the time of admission, tachypnea (27% vs 60%; OR, 0.24; P = .031) and respiratory distress (15% vs 51%; OR, 0.15; P = .012) were less frequent among case patients. MERS-CoV patients were more likely to have a normal white blood cell count than the control group (82% vs 52%; OR, 4.33; P = .029). Admission chest radiography with interstitial infiltrates was more frequent in case patients than in controls (67% vs 20%; OR, 8.13; P = .001). Case patients were more likely to be admitted to the intensive care unit (53% vs 20%; OR, 4.65; P = .025) and to have a high mortality rate (76% vs 15%; OR, 18.96; P < .001).

> Conclusions. Few clinical predictors could enhance the ability to predict which patients with pneumonia would have MERS-CoV. However, further prospective analysis and matched case-control studies may shed light on other predictors of infection.


## 2/25/20 Agenda {#Feb25}
1. Difference in Proportion HT
2. Difference in Proportion CI

## Difference of two proportions {#diffprop}

## 2/27/20 Agenda {#Feb27}
1. Observational Studies
2. Experiments

## Experiments

## 3/3/20 Agenda {#Mar3}
1. More than two proportions
2. Chi-square analysis


