# Inference for numerical data




## 3/31/20 {#Mar31}
1. New statistics: mean, standard deviation, standard error of the mean
2. Sampling distribution of the sample mean

## Important measures related to quantitative (numeric) variables

### Quantitative Descriptives 

What measures can we look at to get a first sense of whether  two groups are different (let alone substantially different enough for us to conclude a difference in a related population).  We might look at what is called the **Five Number Summary**.  

* **Five Number Summary**: Min, Q1, Median, Q3, Max
  - Q1 = median of the values *below* the median
  - Q3 = median of the values *above* the median
  - IQR = Interquartile range (measure of spread/variability) = Q3 - Q1
  - 1.5 x IQR rule for possible outliers: If an observation falls more than 1.5IQR outside of Q1 or Q3, flag the observation as a possible outlier.

* Boxplot 
  - Box spans Q1 to Q3
  - Line in box marks median (M)
  - Perpendicular line extends from box to smallest and largest observations *within* 1.5IQR of Q1 and Q3.
  - Dots for observations outside of 1.5IQR

* Summaries often used when variable has a bell-shaped distribution

\begin{eqnarray*}
\mbox{sample mean} &=& \overline{X} = \frac{1}{n} \sum_{i=1}^n X_i\\
\mbox{sample standard deviation} &=& s = \sqrt{\frac{1}{n-1} \sum_{i=1}^n (X_i - \overline{X})^2}\\
\mbox{sample variance} &=& s^2 = \frac{1}{n-1} \sum_{i=1}^n (X_i - \overline{X})^2
\end{eqnarray*}

Loosely, the standard deviation is the size of the typical deviation from the mean of the data set.  Note that we divide by $n-1$ instead of by $n$ because the true deviation is defined as the average of the observations from the true mean $\mu$, and, in fact, they will always be closer to $\overline{X}$ than to $\mu$.


### Sampling distribution of a sample mean {#mean1dist}


As before, the **Central Limit Theorem** tells us that averages are normally distributed if the sample size is large enough.  Here, that means:
$$\overline{X} \sim N(\mu, \sigma/\sqrt{n})$$
where $SD(\overline{X}) = \sigma/\sqrt{n}$ and $SE(\overline{X}) = s/\sqrt{n}$.  $\mu$ is the center of the *population* of observations from which the sample data were taken.  $\sigma$ is the variability of the *population* of observations from which the sample data were taken.

As before, we won't spend much time worried about the difference between $SD(\overline{X})$ and $SE(\overline{X})$.  Generally, we'll only know / use $SE(\overline{X}) = s/\sqrt{n}$.  Typically, with quantitative variables, "large enough" is at least 30 or so observations.



Spend some time clicking through different datasets in the ICAM applet: http://www.rossmanchance.com/applets/OneSample.html?showBoth=1

You should notice:

* If the population (or sample of data) is skewed, the sampling distribution of the sample mean is normal (bell-shaped) when the sample size is large.
* The larger the sample size, the less variable the sampling distribution.
* The sample size does *not* change the distribution of the dataset (the middle graph).  The middle graph will always be a representation of the population graph (left side); although with small sample sizes, the middle graph is somewhat sparse.
* In an actual data analysis, we **only** see the middle graph.  We do not see the population graph (left side) or the sampling distribution (right side).


## 4/2/20 {#Apr2}
1. The t-distribution
2. Standardized t-score 
3. Hypothesis Testing & Confidence Intervals for one mean


## Inference for a single mean, $\mu$ {#mean1inf}

###  Mathematical model for distribution of the sample mean

Before coming up with the mathematical model appropriate for this section, it is important to notice that we almost never know the true variability of the data (i.e., $\sigma$).  Instead, we almost always have to estimate $\sigma$ using $s$, the sample standard deviation.  It turns out that when the estimate of the variability is used in the denominator, the sampling distribution becomes more variability (longer tails).  Recall that it is the tails of the distribution in which we are the most interested, so we don't want to get those wrong!!

If $\sigma$ is somehow known:  $$\frac{\overline{X} - \mu}{\sigma/\sqrt{n}} \sim N(0,1)$$

But in the more typical situation where $\sigma$ is estimated using $s$: $$\frac{\overline{X} - \mu}{s/\sqrt{n}} \sim t_{df = n-1}$$

#### Hypothesis testing

If $H_0: \mu = \mu_0$ is true, then we know that: $$\frac{\overline{X} - \mu}{s/\sqrt{n}} \sim t_{df = n-1}$$

That is, we can use the $t_{df = n-1}$ distribution to find the p-value for the test.  Note, in R we we use the function `xpt` in the `mosaic` package.

####  Confidence intervals

In the setting where there is no null hypothesis and an interval estimate is needed, the interval is created in the exact same way as was done with proporitons using:  $$\overline{X} \pm t_{n-1}^* \cdot SE(\overline{X})$$

Which is the same thing as: $$\overline{X} \pm t_{n-1}^* \cdot s/ \sqrt{n}$$




### Example: healthy body temperature^[Inv 2.5, Chance & Rossman, ISCAM] 

The study at hand is meant to determine whether the average healthy body temperature is actually 98.6 F.^[Conventional wisdom says that the reason 98.6 has hung around is because it translates to 35 C. Indeed, it it agreed that, to the nearest integer, the average healthy human body temperature is 37 C.  But there is also some consensus that it is slightly lower than 37 C (if we are willing to use more significant digits).  The idea is that we have hung on to 98.6 because the decimal *feels* like a precise measurement.  In reality, it is just the conversion from 37 C to F.]

> Body temperatures (oral temperatures using a digital thermometer) were recorded for healthy men and women, aged 18-40 years, who were volunteers in Shigella vaccine trials at the University of Maryland Center for Vaccine Development, Baltimore. For these adults, the mean body temperature was found to be 98.249 F with a standard deviation of 0.733 F.^[Mackowiak, Wasserman, & Levine, *Journal of the American Medical Association*, 1992]

In order to work through the analysis it is imperative that we understand the data that was collected as part of the research.  


|          center                                  |             variability of data                                      |                                variability of sample means                   |  sample size    |
|:--------------------------------------------|:---------------------------------------------------|:---------------------------------------------------|:------|
| $\overline{X} = 98.249$ F                    | $s = 0.733$ F                                       | $SE(\overline{X}) = \frac{s}{\sqrt{n}} = \frac{0.733}{\sqrt{130}} = 0.0643$ | $n=130$ |
| $\mu$ = true ave healthy body temp (unknown!) | $\sigma$ = true sd of healthy body temps (unknown!) | $SD(\overline{X}) = \frac{\sigma}{\sqrt{n}}$ = unknown!     |      |


####  Hypothesis Test

The first research question we want to ask is:  how surprising would it be to select a group of 13 participants who have an average healthy body temperature of 98.249 F ?

The questions is set up perfectly for a hypothesis test!

$H_0: \mu = 98.6$

$H_A: \mu \ne 98.6$

We use the t-distribution to investigate the claim.

$$t-score = \frac{98.249 - 98.6}{0.733/\sqrt{130}} = -5.46$$

How likely is the standardized version of our test statistic to happen if the null hypothesis is true?  Well, if $H_0$ is true, then the t-statistics should have a t-distribution.  So we can use the t-distribution to find the p-value (recall that the p-value is the probability of the data or more extreme if $H_0$ is true.)

The test statistic is -5.46, and even a two-sided p-value (the area doubled) is way less than 0.001.


```r
2 * mosaic::xpt(-5.46, df = 129, ncp = 0)
```

<img src="04-InfNum_files/figure-html/unnamed-chunk-1-1.png" width="480" style="display: block; margin: auto;" />

```
## [1] 2.354246e-07
```


####  Confidence Interval

Possibly more interesting is the confidence interval which would tell us a range of plausible values for healthy body temperatures.

The confidence interval is given by the following formula:  $$\overline{X} \pm t_{n-1}^* \cdot s/ \sqrt{n}$$

and is calculated to be (98.121, 98.376).  That is, we are 95% confident that the true average healthy body temperature is somewhere between 98.121 F and 98.376 F.  Note that 98.6 F is not in the interval!!!  Wow.


```r
mosaic::xqt(.975, df = 129)
```

<img src="04-InfNum_files/figure-html/unnamed-chunk-2-1.png" width="480" style="display: block; margin: auto;" />

```
## [1] 1.978524
```

```r
98.249 - 1.9785 * 0.733 / sqrt(130)
```

```
## [1] 98.12181
```

```r
98.249 + 1.9785 * 0.733 / sqrt(130)
```

```
## [1] 98.37619
```

## Reflection Questions


