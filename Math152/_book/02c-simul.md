
# Simultaneous Inference {#simult}




(sections 4.1, 4.2, 4.3 in ALSM)

Spring 2022:  We **will** cover joint estimation of $\beta_0$ and $\beta_1$, but we **will not** cover simultaneous estimation of a mean response or simultaneous prediction intervals for new observations.

## Joint Estimation of $\beta_0$ and $\beta_1$

Note that all the inference on $\beta_1$ can be performed on $\beta_0$ with only slight modifications to the formula for the SE.  Although $\beta_1$ is typically more related to the research question at hand, $\beta_0$ can also be informative in its own right.  Indeed, if we were interested in CI for either one, we would calculate the following:

$$b_0 \pm t_{(1-\alpha/2), n-2} \cdot s\{b_0\}$$
$$b_1 \pm t_{(1-\alpha/2), n-2} \cdot s\{b_1\}$$

Clearly if we had many parameters and many intervals, we wouldn't think that they would *all* cover the true parameters with probability $(1-\alpha)$.  To figure out the probability that they all cover their true parameter, let's define
\begin{eqnarray*}
A_1 &=& \mbox{first CI does not cover } \beta_0\\
P(A_1) &=& \alpha\\
A_2 &=& \mbox{second CI does not cover } \beta_1\\
P(A_2) &=& \alpha\\
\end{eqnarray*}

We want to bound the probability that all the intervals cover the true parameter.
\begin{eqnarray*}
P(\mbox{all CIs cover}) &=& 1- P(\mbox{at least one CI does not cover})\\
&=& 1 - P( A_1 \mbox{ or } A_2)\\
&&\\
P( A_1 \mbox{ or } A_2) &=& P(A_1) + P(A_2) - P(A_1 \mbox{ and } A_2)\\
&=& \alpha + \alpha - ???\\
& \leq& 2 \alpha \\
P(\mbox{at least one CI does not cover}) &\leq& 2 \alpha\\
P(\mbox{all CIs cover}) &\geq& 1- 2 \alpha\\
\end{eqnarray*}

Note that if we make two 95% CIs, the Bonferroni inequality tells us that both will cover their respective parameters in 90% of such repeated samples (i.e., with 90% confidence).

With $g$ CIs, letting the multiplier be at a level of significance given by $\alpha/g$ will create familywise confidence intervals with a level of significance of $\alpha$.

For $\beta_0$ and $\beta_1$, let $B = t_{(1-\alpha/4), n-2}$.  Then the intervals with $1-\alpha$ familywise confidence limits are:

$$b_0 \pm B \cdot s\{b_0\}$$
$$b_1 \pm B \cdot s\{b_1\}$$



* Note that interpretations depend heavily on the number of intervals (which is true about most multiple comparison adjustments).  
* Bonferroni is extremely conservative, and therefore it has low power.  
* Bonferroni easily extends to any number of comparisons.  
* Bonferroni can adjust for multiple comparisons even when comparing very different types of analyses (e.g., CI for slope parameter and for a predicted response).  

## Simultaneous Estimation of a Mean Response

As with the intervals for the parameters, creating intervals for multiple mean responses leads to problems of multiple comparisons.  Again, the goal is to adjust the intervals such that the probability of getting a dataset which will lead to intervals covering *all* mean responses is $1-\alpha$.

(Note that the reason for simultaneous inference is because the combination of natural sampling variability in $b_0$ and $b_1$ could lead to the mean responses being correct for $E[Y_h]$ over some range of $x$ values and incorrect for a different range of $x$ values.)

### Working-Hotelling Procedure {-}

The Working-Hotelling procedure gives a confidence band for the entire range of $x$ values.   The family confidence interval for the simultaneous intervals is $1-\alpha$.  Note that the multiplier is determined to bound the entire line over the complete range of $x$ values.

$$\hat{y}_h \pm W s \{ \hat{y}_h \}$$
where $W^2 = 2 F_{(1-\alpha; 2, n-2)}$.

### Bonferroni Procedure {-}

We could have also produced Bonferroni intervals, but those would have been determined using the number $g$ of intervals of interest (as opposed to Working-Hotelling which cover the entire range of $x$ values).

$$\hat{y}_h \pm B \cdot s \{ \hat{y}_h \}$$
where $B = t_{(1-\alpha/2g; n-2)}$.


## Simultaneous Prediction Intervals for New Observations

Just as with estimating the mean response, the interval for predicting new observations can be adjusted so that the total range of observations are contained in the appropriate intervals with probability $1-\alpha$.   For prediction intervals, it is necessary to specify the number $g$ intervals of interest.

### Scheffé Procedure{-}

The Scheffé  procedure gives a confidence band for a set of $x$ values, $g$ of them.   Using the Scheffé procedure, the family confidence interval for the simultaneous intervals is $1-\alpha$.

$$\hat{y}_h \pm S \cdot s \{ \mbox{pred} \}$$
where $S^2 = g F_{(1-\alpha; g, n-2)}$.

### Bonferroni Procedure {-}

We could have also produced Bonferroni intervals, but those would have been determined using the number $g$ of intervals of interest (as opposed to Working-Hotelling which cover the entire range of $x$ values).

$$\hat{y}_h \pm B s \{ \mbox{pred} \}$$
where $B = t_{(1-\alpha/2g; n-2)}$.


## More

Note that ALSM sections 4.6 (Inverse Predictions) and 4.7 (Choice of $x$ values) provide additional information into good model building.  The sections are worth reading on your own.


## <i class="fas fa-lightbulb" target="_blank"></i> Reflection Questions

1. Why do simultaneous CIs worry us (from an error perspective)?  
2. What is the difference between Bonferroni, Working-Hotelling, and Scheffé adjustments?  
3. When are Bonferroni intervals larger than the other two?  When are they smaller?  
4. Why do we say the Bonferroni procedure is more general than other multiple comparisons procedures?  
5. If $g$ is very large, why is the Working-Hotelling procedure preferred to the Bonferroni?  


## <i class="fas fa-balance-scale"></i> Ethics Considerations

1. Why are interval estimates often more valuable to report than p-values?    
2. What does it mean for one of the adjustments to be "conservative"?
3. If the sample is not representative of the population, how can an interval estimate be misleading?
4. What words can be used to distinguish mean confidence intervals from individual prediction intervals in order for better communication of results?

### R: Simultaneous inference

There are R packages that will do simultaneous inference automatically.  However, for the purposes of what we are covering, we'll focus only on changing the multiplier in order to control the type I error rate.

Consider the regression on the `ames` housing data.  We regression `ln_price` on `area` of the home (in sqft).  See the full analysis in section \@ref{ames-inf}.




```r
ames_lm <- ames_inf %>%
  lm(price_ln ~ area, data = .) 

ames_lm %>%
  tidy()
```

```
## # A tibble: 2 × 5
##   term         estimate std.error statistic p.value
##   <chr>           <dbl>     <dbl>     <dbl>   <dbl>
## 1 (Intercept) 11.1      0.0177        628.        0
## 2 area         0.000614 0.0000114      53.9       0
```

```r
ames_lm %>%
  glance()
```

```
## # A tibble: 1 × 12
##   r.squared adj.r.squared sigma statistic p.value    df logLik   AIC   BIC
##       <dbl>         <dbl> <dbl>     <dbl>   <dbl> <dbl>  <dbl> <dbl> <dbl>
## 1     0.500         0.500 0.284     2901.       0     1  -461.  928.  946.
## # … with 3 more variables: deviance <dbl>, df.residual <int>, nobs <int>
```

```r
ames_df <- ames_lm %>%
  glance() %>%
  select(df.residual) %>%
  pull()

ames_df
```

```
## [1] 2902
```

Let's say that we want CI for both the intercept and the slope parameters.  In that case, two intervals are created.  Bonferroni controls the type I error by dividing the alpha error by the number of intervals.  So the multiplier is a t value with the adjusted alpha level and degrees of freedom from the linear model (`n-2`). 


```r
num_int_param <- 2  # for beta0 and beta1

# Bonferroni:
crit_Bonf <- qt((1-.975)/num_int_param, ames_df)
crit_Bonf
```

```
## [1] -2.24
```

The intervals can then be created directly from the output of the `tidy()` function.


```r
ames_lm %>%
  tidy() %>%
  select(term, estimate, std.error) %>%
  mutate(lower.ci = estimate + crit_Bonf*std.error,
         upper.ci = estimate - crit_Bonf*std.error)
```

```
## # A tibble: 2 × 5
##   term         estimate std.error  lower.ci  upper.ci
##   <chr>           <dbl>     <dbl>     <dbl>     <dbl>
## 1 (Intercept) 11.1      0.0177    11.1      11.1     
## 2 area         0.000614 0.0000114  0.000588  0.000639
```


Similarly, the intervals for mean response (confidence interval) and individual response (prediction interval) use the appropriate standard errors and a new multiplier.  Below is the code for the Working-Hotelling multiplier and the Scheffe multiplier, both for 10 new observations.


```r
# Working-Hotelling
crit_WH <- sqrt(2*qf(.95, 2, ames_df))
crit_WH
```

```
## [1] 2.45
```

```r
# Scheffe
num_int_pred <- 10 # if 10 new observations for prediction
crit_Sch <- sqrt(num_int_pred*qf(0.95, num_int_pred, ames_df))
crit_Sch
```

```
## [1] 4.28
```

