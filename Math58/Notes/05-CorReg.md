# Correlation & Regression



## 4/16/20 Agenda {#Apr16}
1. Definition of correlation (r)
2. Interpretation of correlation (r)  
3. (Probably not: Inference on $\rho$)


The last topic of the semester will focus on modeling and inference using two quantitative variables.  That is, both the explanatory and the response variables are measured on a numeric scale.   

To get started, consider a handful of variables taken on the top 80 PGA golfers in 2004.  The example comes from Investigation 5.7 in @iscam  

<div class="figure" style="text-align: center">
<img src="figs/golf.jpg" alt="Investigation 5.7, `Drive for show, putt for dough`, @iscam" width="80%" />
<p class="caption">(\#fig:unnamed-chunk-1)Investigation 5.7, `Drive for show, putt for dough`, @iscam</p>
</div>

Rank the eight scatterplots from strongest negative to strongest positive.  Some questions to ask yourself:

* What would the correlation be if there was a perfect positive relationship?
* What would the correlation be if there was a perfect negative relationship?
* What would the correlation be if there was no relationship?

## Correlation {#cor}

Correlation measures the association between two numerical variables.  [Note, that when describing how two categorical (or one numerical & one categorical) variables vary together, they are said to be *associated* instead of *correlated*.]  

> The *correlation coefficient* measures the strength and direction of the linear association between two numerical variables.

### Estimating Correlation

The value of the correlation is defined as:

\begin{eqnarray*}
r &=& \frac{ \sum_i (x_i  - \overline{x})(y_i - \overline{y})}{\sqrt{\sum_i(x_i - \overline{x})^2} \sqrt{ \sum_i(y_i - \overline{y})^2}}\\
&=& \frac{1}{n-1} \sum_{i=1}^n \bigg(\frac{x_i - \overline{x}}{s_x} \bigg) \bigg(\frac{y_i - \overline{y}}{s_y} \bigg)
\end{eqnarray*}

<div class="figure" style="text-align: center">
<img src="figs/golfcor.jpg" alt="Scatterplots with average X and Y values superimposed.  Investigation 5.7, `Drive for show, putt for dough`, @iscam" width="80%" />
<p class="caption">(\#fig:unnamed-chunk-2)Scatterplots with average X and Y values superimposed.  Investigation 5.7, `Drive for show, putt for dough`, @iscam</p>
</div>


For each red dot (on each plot), consider the distance the observation is from the $\overline{X}$ line and the $\overline{Y}$ line.  Is the observation (red dot) above both?  below both?  above one and below the other?  

How does the particular red dot (observation) contribute to the correlation?  In a positive way (to make $r$ bigger)?  In a negative way (to make $r$ smaller)?

Some ideas worth thinking about:

* quadratic plots can have zero correlation yet a perfect functional relationship
* $-1 \leq r \leq 1$
* correlation does not imply causation (ice cream & boating accidents!)
* for inference with $\rho$ as well as $\beta_1$, the data should come from a bivariate normal distribution.  That is, histograms of $X$ and $Y$ should both be normal, and the scatterplot should be a cloud.
* correlation will go down when only a narrow range of X values is represented (see denominator of r).
* measurement error biases the estimate of a correlation coefficient toward zero.


### Coefficient of Determination -- $R^2$

The coefficient of determination ($R^2$) is the square of the correlation (given above).  However, it also has an additional interpretation that will be useful for us.  It can measure how much of the original variability in Y is given by the regression line.  Both SSE and least-squares will be defined below when we fit a line to the scatter plot of observations.

SSE is "sum of squared errors" (think about how $s^2$ is defined).  So, $SSE(\overline{y})$ is the amount the response variable varies on its own.  $SSE(\mbox{least-squares})$ is the amount the response variable varies around the line.

\begin{eqnarray*}
R^2 = \frac{SSE(\overline{y}) - SSE(\mbox{least-squares})}{SSE(\overline{y})}
\end{eqnarray*}

$R^2$ can be used even in models with many explanatory variables.  As such, the way to think about $R^2$ is in terms of how much of the variability in the response variable was removed (when we learned the values of the explanatory variables).  $R^2$ **is the proportion reduction in the variability of the response variable which is explained by the explanatory variable.**

### Inference for correlation


Note:  we won't actually cover inference for correlation in class, but the notes on inference for correlation are included so that you can see that the process is very similar to all of the other statistics seen in the course to this point.

Parameter: $\rho$  
Statistic: $r$  
SE$_r: \sqrt{\frac{1-r^2}{n-2}}$   
**BUT**, $r$ is only normally distributed when $\rho$ = 0!  Otherwise, the distribution of $r$ from sample to sample is skewed (think about the scenario when $\rho = 0.9$).


#### Hypothesis Testing

\begin{eqnarray*}
H_0:&& \rho = 0\\
H_A:&& \rho \ne 0\\
t^* &=& \frac{r}{SE_r} = \frac{r}{\sqrt{(1-r^2)/(n-2)}}\\
t^* &\sim& t_{n-2}  \mbox{ when } H_0 \mbox{ is true}
\end{eqnarray*}

#### Confidence Interval


If $\rho \ne 0$, then the SE might be okay, but the sampling distribution of $r$ will not be normal (and thus will not be a $t$ when we use the SE).


Let:

\begin{eqnarray*}
z &=& 0.5 \ln \bigg( \frac{1+r}{1-r} \bigg)\\
\xi &=& 0.5 \ln \bigg( \frac{1+\rho}{1-\rho} \bigg)\\
var(z) &=& \sqrt{\frac{1}{n-3}}\\
95\% \mbox{ CI for } \xi : &&\\
z &\pm& 1.96 \cdot \sqrt{\frac{1}{n-3}}\\
\mbox{we're 95% confident that } && \\
&&z - 1.96 \cdot  \sqrt{\frac{1}{n-3}} \leq \xi \leq z + 1.96 \cdot \sqrt{\frac{1}{n-3}}\\
&& a \leq \xi \leq b\\
&& a \leq 0.5 \ln \bigg(\frac{1+\rho}{1-\rho} \bigg) \leq b\\
&& \frac{e^{2a} - 1}{e^{2a} + 1} \leq \rho \leq \frac{e^{2b} - 1}{e^{2b} + 1}
\end{eqnarray*}


### Example: Cat Jumping^[@iscam, Inv 5.6 & 5.13]



Consider the cat data given in Investigations 5.6 and 5.13.  The idea is to understand cat jumping velocity as a function of body characteristics. Note that the correlation $r=-0.496$  between bodymass and velocity.




```r
cats <- read_table2("http://www.rossmanchance.com/iscam2/data/CatJumping.txt")

cats %>%
  select(bodymass, velocity) %>%
  cor()
```

```
##            bodymass   velocity
## bodymass  1.0000000 -0.4964022
## velocity -0.4964022  1.0000000
```



**HT:**  
\begin{eqnarray*}
H_0:&& \rho = 0\\
H_a:&& \rho \ne 0\\
t^* &=& \frac{r}{\sqrt{(1-r^2)/(n-2)}} = \frac{-0.496}{\sqrt{(1-0.496^2) / (18-2)}}= -2.2849\\
p-value &=& 2 \cdot P(t_{18-2} \leq -2.2849) = 2\cdot(pt(-2.2849,16)) = 0.036 \mbox{  (borderline significant)}
\end{eqnarray*}

**CI:**  
\begin{eqnarray*}
95\% && \mbox{CI for } \xi : \\
z &\pm& 1.96 \cdot \sqrt{\frac{1}{n-3}}\\
&&\mbox{we're } 95\% \mbox{ confident that}\\
&& 0.5 \ln\bigg(\frac{1+r}{1-r}\bigg) - 1.96 \cdot  \sqrt{\frac{1}{n-3}} \leq \xi \leq 0.5 \ln\bigg(\frac{1+r}{1-r}\bigg) + 1.96 \cdot \sqrt{\frac{1}{n-3}}\\
&& 0.5 \ln\bigg(\frac{1 - 0.496}{1+0.496}\bigg) - 1.96 \cdot  \sqrt{\frac{1}{18-3}} \leq \xi \leq 0.5 \ln\bigg(\frac{1-0.496}{1+0.496}\bigg) + 1.96 \cdot \sqrt{\frac{1}{18-3}}\\
&& -1.05 \leq \xi \leq -0.04\\
&& \frac{e^{2\cdot -1.05} - 1}{e^{2\cdot -1.05} + 1} \leq \rho \leq \frac{e^{2\cdot -0.04} - 1}{e^{2\cdot -0.04} + 1}\\
&& (-0.781, -0.04)
\end{eqnarray*}



```r
summary(lm(velocity ~ bodymass, data = cats))
```

```
## 
## Call:
## lm(formula = velocity ~ bodymass, data = cats)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -48.069 -16.729  -8.524  10.546  84.625 
## 
## Coefficients:
##               Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 394.473238  23.441939  16.828 1.35e-11 ***
## bodymass     -0.012196   0.005332  -2.287   0.0361 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 29.6 on 16 degrees of freedom
## Multiple R-squared:  0.2464,	Adjusted R-squared:  0.1993 
## F-statistic: 5.232 on 1 and 16 DF,  p-value: 0.03613
```




An alternative way to work with the output is in specific pieces (instead of the entire summary output).


```r
library(broom)

lm(velocity ~ bodymass, data = cats) %>% tidy(conf.int = TRUE)
```

```
## # A tibble: 2 x 7
##   term        estimate std.error statistic  p.value conf.low  conf.high
##   <chr>          <dbl>     <dbl>     <dbl>    <dbl>    <dbl>      <dbl>
## 1 (Intercept) 394.      23.4         16.8  1.35e-11 345.     444.      
## 2 bodymass     -0.0122   0.00533     -2.29 3.61e- 2  -0.0235  -0.000893
```

And to work with the residuals, use `augment()`.


```r
lm(velocity ~ bodymass, data = cats) %>% augment()
```

```
## # A tibble: 18 x 9
##    velocity bodymass .fitted .se.fit .resid   .hat .sigma .cooksd
##       <dbl>    <dbl>   <dbl>   <dbl>  <dbl>  <dbl>  <dbl>   <dbl>
##  1     334.     3640    350.    7.58 -15.6  0.0656   30.3 1.04e-2
##  2     387.     2670    362.   10.7   25.4  0.131    29.7 6.40e-2
##  3     411.     5600    326.   10.2   84.6  0.119    19.8 6.29e-1
##  4     319.     4130    344.    6.99 -25.5  0.0557   29.8 2.32e-2
##  5     369.     3020    358.    9.38  11.1  0.101    30.4 8.67e-3
##  6     359.     2660    362.   10.8   -3.23 0.132    30.6 1.05e-3
##  7     345.     3240    355.    8.64 -10.4  0.0853   30.4 6.24e-3
##  8     325.     5140    332.    8.60  -7.19 0.0844   30.5 2.97e-3
##  9     301.     3690    349.    7.48 -48.1  0.0639   27.7 9.62e-2
## 10     332.     3620    350.    7.62 -18.5  0.0664   30.2 1.49e-2
## 11     313.     5310    330.    9.16 -17.1  0.0957   30.2 1.96e-2
## 12     317.     5560    327.   10.1   -9.86 0.116    30.4 8.23e-3
## 13     376.     3970    346.    7.08  29.5  0.0572   29.5 3.21e-2
## 14     372.     3770    348.    7.34  23.9  0.0615   29.9 2.28e-2
## 15     314.     5100    332.    8.48 -18.0  0.0820   30.2 1.79e-2
## 16     368.     2950    358.    9.64   9.01 0.106    30.5 6.14e-3
## 17     286.     7930    298.   21.1  -11.5  0.508    30.3 1.57e-1
## 18     352.     3550    351.    7.78   1.32 0.0692   30.6 7.97e-5
## # … with 1 more variable: .std.resid <dbl>
```

```r
lm(velocity ~ bodymass, data = cats) %>% augment() %>%
  ggplot(aes(x = .fitted, y = .resid)) + 
  geom_point() +
  geom_hline(yintercept = 0)
```

<img src="05-CorReg_files/figure-html/unnamed-chunk-6-1.png" width="480" style="display: block; margin: auto;" />



## 4/21/20 Agenda {#Apr21}
1. Least Squares estimation of the line
2. Distribution of the least squares line from sample to sample

## 4/23/20 Agenda {#Apr23}
1. Inferential technical assumptions
2. Residual Plots
3. Transformations
4. Prediction Intervals

## Simple Linear Regression

###  Least Squares estimation of the regression line {#ls}

### Inference on the slope, $\beta_1$ {#infbeta1}

## 4/28/20 Agenda {#Apr28}
1. Multiple Linear Regression

## 4/30/20 Agenda {#Apr30}
1. Choosing model
2. Residual Plots
3. Prediction Intervals (harder to plot!)


## Multiple Linear Regression {#MLR}

### Model selection {#MLRmod}

### Checking model assumptions



