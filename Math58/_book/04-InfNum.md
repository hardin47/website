# Inference for numerical data




## 3/31/20 {#Mar31}
1. New statistics: mean, standard deviation, standard error of the mean
2. Sampling distribution of the sample mean

## Important measures related to quantitative (numeric) variables

### Quantitative Descriptives {#1meandist}

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


### Sampling distribution of a sample mean 


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
1. Standardized distribution of the sample mean
2. Inference example for one sample mean

## Inference for a single mean {#1meaninf}

###  Mathematical model for distribution of the sample mean

Before coming up with the mathematical model appropriate for this section, it is important to notice that we almost never know the true variability of the data (i.e., $\sigma$).  Instead, we almost always have to estimatate $\sigma$ using $s$, the sample standard deviation.  It turns out that when the estimate of the variability is used in the denominator, the sampling distribution becomes more variability (longer tails).  Recall that it is the tails of the distribution in which we are the most interested, so we don't want to get those wrong!!

If $\sigma$ is somehow known:  $$\frac{\overline{X} - \mu}{\sigma/\sqrt{n}} \sim N(0,1)$$

But in the more standard situation where $\sigma$ is estimated using $s$: $$\frac{\overline{X} - \mu}{s/\sqrt{n}} \sim t_{df = n-1}$$


### Example: healthy body temperature
