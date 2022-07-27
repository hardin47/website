# t-tests vs SLR


We are going to build on a very basic model of the following form:

```
data = deterministic model + random error
```

**planned variability** your experimental conditions, hopefully represented by an interesting deterministic model  
**random error** natural variability due to individuals.  
**systematic error** error that is not contained within the model.  It can happen because of poor sampling or poor experimental conditions.  

### Surgery Timing {-}
The study, "Operation Timing and 30-Day Mortality After Elective General Surgery", tested the hypotheses that the risk of 30-day mortality associated with elective general surgery: 1) increases from morning to evening throughout the routine workday; 2) increases from Monday to Friday through the workweek; and 3) is more frequent in July and August than during other months of the year. As a presumed negative control, the investigators also evaluated mortality as a function of the phase of the moon. Secondarily, they evaluated these hypotheses as they pertain to a composite in-hospital morbidity endpoint.

The related data set contains 32,001 elective general surgical patients. Age, gender, race, BMI, several comorbidities, several surgical risk indices, the surgical timing predictors (hour, day of week, month,moon phase) and the outcomes (30-day mortality and in-hospital complication) are provided. The dataset is cleaned and complete (no missing data except for BMI). There are no outliers or data problems. The data are from [@Sessler2011]


Note that in the example, mortality rates are compared for patients electing to have surgery in July vs August.  We'd like to compare the average age of the participants from the July group to the August group.  Even if the mortality difference is significant, we can't conclude causation because it was an observational study.  However, the more similar the groups are based on clinical variables, the more likely any differences in mortality are due to timing.  How different are the groups based on clinical variables?


```r
surgeryurl <- url("https://www.causeweb.org/tshs/datasets/surgery_timing.Rdata")
load(surgeryurl)
surgery <- stata_data
head(surgery)  %>%
  select(age, gender, race, hour, dow, month, complication, bmi, everything(), -ahrq_ccs) %>%
  kable(caption = "Varibles associated with the surgery data.") %>%
 kable_styling()
```

<table class="table" style="margin-left: auto; margin-right: auto;">
<caption>(\#tab:unnamed-chunk-2)Varibles associated with the surgery data.</caption>
 <thead>
  <tr>
   <th style="text-align:right;"> age </th>
   <th style="text-align:left;"> gender </th>
   <th style="text-align:left;"> race </th>
   <th style="text-align:right;"> hour </th>
   <th style="text-align:left;"> dow </th>
   <th style="text-align:left;"> month </th>
   <th style="text-align:left;"> complication </th>
   <th style="text-align:right;"> bmi </th>
   <th style="text-align:left;"> asa_status </th>
   <th style="text-align:left;"> baseline_cancer </th>
   <th style="text-align:left;"> baseline_cvd </th>
   <th style="text-align:left;"> baseline_dementia </th>
   <th style="text-align:left;"> baseline_diabetes </th>
   <th style="text-align:left;"> baseline_digestive </th>
   <th style="text-align:left;"> baseline_osteoart </th>
   <th style="text-align:left;"> baseline_psych </th>
   <th style="text-align:left;"> baseline_pulmonary </th>
   <th style="text-align:right;"> baseline_charlson </th>
   <th style="text-align:right;"> mortality_rsi </th>
   <th style="text-align:right;"> complication_rsi </th>
   <th style="text-align:right;"> ccsmort30rate </th>
   <th style="text-align:right;"> ccscomplicationrate </th>
   <th style="text-align:left;"> moonphase </th>
   <th style="text-align:left;"> mort30 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 67.8 </td>
   <td style="text-align:left;"> M </td>
   <td style="text-align:left;"> Caucasian </td>
   <td style="text-align:right;"> 9.03 </td>
   <td style="text-align:left;"> Mon </td>
   <td style="text-align:left;"> Nov </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:right;"> 28.0 </td>
   <td style="text-align:left;"> I-II </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> Yes </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> Yes </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> -0.63 </td>
   <td style="text-align:right;"> -0.26 </td>
   <td style="text-align:right;"> 0.004 </td>
   <td style="text-align:right;"> 0.072 </td>
   <td style="text-align:left;"> Full Moon </td>
   <td style="text-align:left;"> No </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 39.5 </td>
   <td style="text-align:left;"> F </td>
   <td style="text-align:left;"> Caucasian </td>
   <td style="text-align:right;"> 18.48 </td>
   <td style="text-align:left;"> Wed </td>
   <td style="text-align:left;"> Sep </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:right;"> 37.9 </td>
   <td style="text-align:left;"> I-II </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> Yes </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> -0.63 </td>
   <td style="text-align:right;"> -0.26 </td>
   <td style="text-align:right;"> 0.004 </td>
   <td style="text-align:right;"> 0.072 </td>
   <td style="text-align:left;"> New Moon </td>
   <td style="text-align:left;"> No </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 56.5 </td>
   <td style="text-align:left;"> F </td>
   <td style="text-align:left;"> Caucasian </td>
   <td style="text-align:right;"> 7.88 </td>
   <td style="text-align:left;"> Fri </td>
   <td style="text-align:left;"> Aug </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:right;"> 19.6 </td>
   <td style="text-align:left;"> I-II </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> -0.49 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.004 </td>
   <td style="text-align:right;"> 0.072 </td>
   <td style="text-align:left;"> Full Moon </td>
   <td style="text-align:left;"> No </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 71.0 </td>
   <td style="text-align:left;"> M </td>
   <td style="text-align:left;"> Caucasian </td>
   <td style="text-align:right;"> 8.80 </td>
   <td style="text-align:left;"> Wed </td>
   <td style="text-align:left;"> Jun </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:right;"> 32.2 </td>
   <td style="text-align:left;"> III </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> Yes </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> -1.38 </td>
   <td style="text-align:right;"> -1.15 </td>
   <td style="text-align:right;"> 0.004 </td>
   <td style="text-align:right;"> 0.072 </td>
   <td style="text-align:left;"> Last Quarter </td>
   <td style="text-align:left;"> No </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 56.3 </td>
   <td style="text-align:left;"> M </td>
   <td style="text-align:left;"> African American </td>
   <td style="text-align:right;"> 12.20 </td>
   <td style="text-align:left;"> Thu </td>
   <td style="text-align:left;"> Aug </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:right;"> 24.3 </td>
   <td style="text-align:left;"> I-II </td>
   <td style="text-align:left;"> Yes </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.004 </td>
   <td style="text-align:right;"> 0.072 </td>
   <td style="text-align:left;"> Last Quarter </td>
   <td style="text-align:left;"> No </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 57.7 </td>
   <td style="text-align:left;"> F </td>
   <td style="text-align:left;"> Caucasian </td>
   <td style="text-align:right;"> 7.67 </td>
   <td style="text-align:left;"> Thu </td>
   <td style="text-align:left;"> Dec </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:right;"> 40.3 </td>
   <td style="text-align:left;"> I-II </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> Yes </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:left;"> Yes </td>
   <td style="text-align:left;"> No </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> -0.77 </td>
   <td style="text-align:right;"> -0.84 </td>
   <td style="text-align:right;"> 0.004 </td>
   <td style="text-align:right;"> 0.072 </td>
   <td style="text-align:left;"> First Quarter </td>
   <td style="text-align:left;"> No </td>
  </tr>
</tbody>
</table>


```r
surgery %>%
 dplyr::filter(month %in% c("Jul", "Aug")) %>%
 dplyr::group_by(month) %>%
 dplyr::summarize(agemean = mean(age, na.rm=TRUE), agesd = sd(age, na.rm=TRUE), agen = sum(!is.na(age)))
#> # A tibble: 2 × 4
#>   month agemean agesd  agen
#>   <chr>   <dbl> <dbl> <int>
#> 1 Aug      58.1  15.2  3176
#> 2 Jul      57.6  15.5  2325
```


## t-test {#ttest}

(Section 2.1 in @KuiperSklar.)

A t-test is a test of means.  For the surgery timing data, the groups would ideally have similar age distributions.  Why? What are the advantages and disadvantages of running a retrospective cohort study?
  
  
The two-sample t-test starts with the assumption that the population means of the two groups are equal, $H_0: \mu_1 = \mu_2$.  The sample means $\overline{y}_1$ and $\overline{y}_2$ will always be different.  How different must the $\overline{y}$ values be in order to reject the null hypothesis?

##### Model 1: {-}

\begin{align}
y_{1j} &= \mu_{1} + \epsilon_{1j} \ \ \ \ j=1, 2, \ldots, n_1\\
y_{2j} &= \mu_{2} + \epsilon_{2j} \ \ \ \ j=1, 2, \ldots, n_2\\
\epsilon_{ij} &\sim N(0,\sigma^2)\\
E[Y_i] &= \mu_i
\end{align}

That is, we are assuming that for each group the true population *average* is fixed and an individual that is randomly selected will have some amount of *random error* away from the true population mean.  Note that we have assumed that the variances of the two groups are equal.  We have also assumed that there is independence between and within the groups.
  
Note: we will assume the *population variances* are equal if neither *sample variance* is more than twice as big as the other.
  


::: {.example}
Are the mean ages of the July vs August patients statistically different? (why two sided?)
  
\begin{align}
H_0: \mu_1 = \mu_2\\
H_1: \mu_1 \ne \mu_2
\end{align}
  
\begin{align}
t &= \frac{(\overline{y}_1 - \overline{y}_2) - 0}{s_p \sqrt{\frac{1}{n_1} + \frac{1}{n_2}}}\\
s_p &= \sqrt{ \frac{(n_1 - 1)s_1^2 + (n_2-1) s_2^2}{n_1 + n_2 -2}}\\
df &= n_1 + n_2 -2\\
&\\
t &= \frac{(58.05 - 57.57) - 0}{15.34 \sqrt{\frac{1}{3176} + \frac{1}{2325}}}\\
&= 1.15\\  
s_p &= \sqrt{ \frac{(3176-1)15.22^2 + (2325-1) 15.5^2}{3176 + 2325 -2}}\\
&= 15.34\\
df &= n_1 + n_2 -2\\
&= 5499\\
\mbox{p-value} &= 2 \cdot (1-pt(1.15,5499)) = 0.25\\
\end{align}
:::

The same analysis can be done in R (with and without tidying the output):

```r
surgery %>%
  dplyr::filter(month %in% c("Jul", "Aug")) %>%
  t.test(age ~ month, data = .)
#> 
#> 	Welch Two Sample t-test
#> 
#> data:  age by month
#> t = 1, df = 4954, p-value = 0.2
#> alternative hypothesis: true difference in means between group Aug and group Jul is not equal to 0
#> 95 percent confidence interval:
#>  -0.337  1.309
#> sample estimates:
#> mean in group Aug mean in group Jul 
#>              58.1              57.6

surgery %>%
  dplyr::filter(month %in% c("Jul", "Aug")) %>%
  t.test(age ~ month, data = .) %>%
  tidy()
#> # A tibble: 1 × 10
#>   estim…¹ estim…² estim…³ stati…⁴ p.value param…⁵ conf.…⁶ conf.…⁷ method alter…⁸
#>     <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl> <chr>  <chr>  
#> 1   0.486    58.1    57.6    1.16   0.247   4954.  -0.337    1.31 Welch… two.si…
#> # … with abbreviated variable names ¹​estimate, ²​estimate1, ³​estimate2,
#> #   ⁴​statistic, ⁵​parameter, ⁶​conf.low, ⁷​conf.high, ⁸​alternative
```
  
* Look at SD and SEM
* What is the statistic? What is the sampling distribution of the statistic?
* Why do we use the t-distribution?
* Why is the big p-value important?  (It's a good thing!)  How do we interpret the p-value?
* What can we conclude?
* applet from [@iscam]: [http://www.rossmanchance.com/applets/2021/sampling/OneSample.html]
* What are the model assumptions? (basically all the assumptions are given in the original linear model: independence between & within groups, random sample, pop values don't change, additive error, $\epsilon_{i,j} \ \sim \ iid \  N(0, \sigma^2))$

 
Considerations when running a t-test:  

* one-sample vs two-sample t-test  
* one-sided vs. two-sided hypotheses  
* t-test with unequal variance (less powerful, more conservative)  
\begin{align}
  t &= \frac{(\overline{y}_1 - \overline{y}_2) - (\mu_1 - \mu_2)}{ \sqrt{\frac{s_1^2}{n_1} + \frac{s_2^2}{n_2}}}\\
  df &= \min(n_1-1, n_2-1)\\
\end{align}
* two dependent (paired) samples -- one sample t-test!


   
::: {.example}
Assume we have two very small **samples**: $(y_{11}=3, y_{12} = 9, y_{21} = 5, y_{22}=1, y_{23}=9).$  Find $\hat{\mu}_1, \hat{\mu}_2, \hat{\epsilon}_{11}, \hat{\epsilon}_{12}, \hat{\epsilon}_{21}, \hat{\epsilon}_{22}, \hat{\epsilon}_{23}, n_1, n_2$.
:::
  
### What is an Alternative Hypothesis?
  
Consider the brief video from the movie Slacker, an early movie by Richard Linklater (director of Boyhood, School of Rock, Before Sunrise, etc.). You can view the video here from starting at 2:22 and ending at 4:30:  [https://www.youtube.com/watch?v=b-U_I1DCGEY]
  
In the video, a rider in the back of a taxi (played by Linklater himself) muses about alternate realities that could have happened as he arrived in Austin on the bus. What if instead of taking a taxi, he had found a ride with a woman at the bus station? He could have take a different road into a different alternate reality, and in that reality his current reality would be an alternate reality. And so on.
  
What is the point?  Why watch the video?  How does it relate the to the material from class?  What is the relationship to sampling distributions?  [Thanks to Ben Baumer at Smith College for the pointer to the specific video.]
    
    
## ANOVA {-}
Skip ANOVA in your text (2.4 and part of 2.9 in @KuiperSklar).
  
  
## Simple Linear Regression {#tslr}

(Section 2.3 in @KuiperSklar.)
  
Simple Linear Regression is a model (hopefully discussed in introductory statistics) used for describing a {\sc linear} relationship between two variables.  It typically has the form of:

\begin{align}
y_i &= \beta_0 + \beta_1 x_i + \epsilon_i  \ \ \ \ i = 1, 2, \ldots, n\\
\epsilon_i &\sim N(0, \sigma^2)\\
E(Y|x) &= \beta_0 + \beta_1 x
\end{align}

For this model, the deterministic component ($\beta_0 + \beta_1 x$) is a linear function of the two parameters, $\beta_0$ and $\beta_1$, and the explanatory variable $x$.  **The random error terms, $\epsilon_i$, are assumed to be independent and to follow a normal distribution with mean 0 and variance $\sigma^2$.**
    
How can we use this model to describe the two sample means case we discussed on the esophageal data?  Consider $x$ to be a dummy variable that takes on the **value 0 if the observation is a control and 1 if the observation is a case**.  Assume we have $n_1$ controls and $n_2$ cases.  It turns out that, coded in this way, the regression model and the two-sample t-test model are mathematically equivalent!
    
(For the color game in the text, the natural way to code is 1 for the color distracter and 0 for the standard game. Why?  What does $\beta_0$ represent?  What does $\beta_1$ represent?)
  
\begin{align}
\mu_1 &= \beta_0 + \beta_1 (0) = \beta_0 \\
\mu_2 &= \beta_0 +  \beta_1 (1) = \beta_0 + \beta_1\\
\mu_2 - \mu_1 &= \beta_1
\end{align}
  
### Why are they the same? {-}
\begin{align}
b_1= \hat{\beta}_1 &= \frac{n \sum x_i y_i - \sum x_i \sum y_i}{n \sum x_i^2 - (\sum x_i )^2}\\
&= \frac{n \sum_2 y_i - n_2 \sum y_i}{(n n_2-n_2^2)}\\
&= \frac{ n \sum_2 y_i - n_2 (\sum_1 y_i + \sum_2 y_i)}{n_2(n-n_2)}\\
&= \frac{(n_1 + n_2) \sum_2 y_i - n_2 \sum_1 y_i - n_2 \sum_2 y_i}{n_1 n_2}\\
&= \frac{n_1 \sum_2 y_i - n_2 \sum_1 y_i}{n_1 n_2}\\
&= \frac{n_1 n_2 \overline{y}_2 - n_2 n_1 \overline{y}_1}{n_1 n_2}\\
&= \overline{y}_2 - \overline{y}_1\\
b_0 = \hat{\beta}_0 &= \frac{\sum y_i - b_1 \sum x_i}{n}\\
&= \frac{\sum_1 y_i + \sum_2 y_i - b_1 n_2}{n}\\
&= \frac{n_1 \overline{y}_1 + n_2 \overline{y}_2 - n_2 \overline{y}_2 + n_2 \overline{y}_1}{n}\\
&= \frac{n \overline{y}_1 + n_2 \overline{y}_2 - n_2 \overline{y}_2 + n_2 \overline{y}_1}{n}\\
&= \frac{n \overline{y}_1}{n} = \overline{y}_1
\end{align}
  

##### Model 2: {-}

\begin{align}
y_{i} &= \beta_0 + \beta_1 x_i + \epsilon_i \ \ \ \ i=1, 2, \ldots, n\\
\epsilon_{i} &\sim N(0,\sigma^2)\\
E[Y_i] &= \beta_0 + \beta_1 x_i\\
\hat{y}_i &= b_0 + b_1 x_i
\end{align}

That is, we are assuming that for each observation the true population *average* is fixed and an individual that is randomly selected will have some amount of *random error* away from the true population mean at their value for the explanatory variable, $x_i$.  Note that we have assumed that the variance is constant across any level of the explanatory variable.  We have also assumed that there is independence across individuals.  **[Note: there are no assumptions about the distribution of the explanatory variable, $X$]**.
  
Note the similarity in running a `t.test()` and a linear model (`lm()`):


```r
surgery %>%
  dplyr::filter(month %in% c("Jul", "Aug")) %>%
  t.test(age ~ month, data = .) %>%
  tidy()
#> # A tibble: 1 × 10
#>   estim…¹ estim…² estim…³ stati…⁴ p.value param…⁵ conf.…⁶ conf.…⁷ method alter…⁸
#>     <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl> <chr>  <chr>  
#> 1   0.486    58.1    57.6    1.16   0.247   4954.  -0.337    1.31 Welch… two.si…
#> # … with abbreviated variable names ¹​estimate, ²​estimate1, ³​estimate2,
#> #   ⁴​statistic, ⁵​parameter, ⁶​conf.low, ⁷​conf.high, ⁸​alternative

surgery %>%
  dplyr::filter(month %in% c("Jul", "Aug")) %>%
  lm(age ~ month, data = .) %>%
  tidy()
#> # A tibble: 2 × 5
#>   term        estimate std.error statistic p.value
#>   <chr>          <dbl>     <dbl>     <dbl>   <dbl>
#> 1 (Intercept)   58.1       0.272    213.     0    
#> 2 monthJul      -0.486     0.419     -1.16   0.245
```


* What are the similarities in the t-test vs. SLR models?
     * predicting average
     * assuming independent, constant errors
     * errors follow a normal distribution with zero mean and variance $\sigma^2$
* What are the differences in the two models?
     * one subscript versus two (or similarly, two models for the t-test)
     * two samples for the t-test (two variables for the regression... or is that a similarity??)
     * both variables are quantitative in SLR
  
## Confidence Intervals

(Section 2.11 in @KuiperSklar.)

A fantastic applet for visualizing what it means to have 95% confidence:  [http://www.rossmanchance.com/applets/2021/confsim/ConfSim.html]
  
In general, the format of a confidence interval is give below... what is the interpretation?  Remember, the interval is for a given parameter and the "coverage" happens in alternative universes with repeated sampling.  We're 95% confident that the interval captures the parameter.

```
estimate +/- critical value x standard error of the estimate
```

Age data:
\begin{align}
90\% \mbox{ CI for } \mu_1: & \overline{y}_1 \pm t^*_{3176-1} \times \hat{\sigma}_{\overline{y}_1}\\
& 58.05 \pm 1.645 \times 15.22/\sqrt{3176}\\
& (57.61, 58.49)\\
95\% \mbox{ CI for }\mu_1 - \mu_2: & \overline{y}_1 - \overline{y}_2 \pm t^*_{5499} s_p \sqrt{1/n_1 + 1/n_2}\\
& 0.48 \pm 1.96 \times 0.42\\
& (-0.34, 1.30)
\end{align}

Note the CI on pgs 54/55, there is a typo.  The correct interval for $\mu_1 - \mu_2$ for the games data should be:
    
\begin{align}
95\% \mbox{ CI for } \mu_1 - \mu_2: & \overline{y}_1 - \overline{y}_2 \pm t^*_{38} \hat{\sigma}_{\overline{y}_1 - \overline{y}_2}\\
& \overline{y}_1 - \overline{y}_2 \pm t^*_{38} s_p \sqrt{1/n_1 + 1/n_2}\\
& 38.1 - 35.55 \pm 2.02 \times \sqrt{\frac{(19)3.65^2 + (19)3.39^2}{20+20-2}} \sqrt{\frac{1}{20} + \frac{1}{20}}\\
& (0.29 s, 4.81 s)
\end{align}
  
  
## Random Sample vs. Random allocation 
  
Recall what you've learned about how good random samples lead to inference about a population.  On the other hand, in order to make a causal conclusion, you need a randomized experiment with random allocation of the treatments (impossible to happen in many settings).  Random sampling and random allocation are DIFFERENT ideas that should be clear in your mind.
  

<div class="figure" style="text-align: center">
<img src="figs/randsampValloc.jpg" alt="Figure taken from [@iscam]" width="95%" />
<p class="caption">(\#fig:unnamed-chunk-6)Figure taken from [@iscam]</p>
</div>
  
Note: no ANOVA (section 2.4 in @KuiperSklar) or normal probability plots (section 2.8 in @KuiperSklar).
  
