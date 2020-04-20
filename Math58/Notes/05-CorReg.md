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

Rank the seven scatterplots from strongest negative to strongest positive.  Some questions to ask yourself:

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
r &=& \frac{1}{n-1} \sum_{i=1}^n \bigg(\frac{x_i - \overline{x}}{s_x} \bigg) \bigg(\frac{y_i - \overline{y}}{s_y} \bigg)
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
R^2 &=& \frac{SSE(\overline{y}) - SSE(\mbox{least-squares})}{SSE(\overline{y})} \\
 &=& \frac{Var(y_i) - Var(e_i)}{Var(y_i)} \\
 &=& 1 - \frac{Var(e_i)}{Var(y_i)}\\
\end{eqnarray*}

[The value $e_i$ is discussed in detail below, but it is the distance from the observed response variable to the prediction on the line:  $$e_i = y_i - \hat{y}_i.]$$

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

ggplot(cats, aes(x=bodymass, y = velocity)) +
  geom_point() +
  geom_smooth(method = "lm", se=FALSE)
```

<img src="05-CorReg_files/figure-html/unnamed-chunk-3-1.png" width="480" style="display: block; margin: auto;" />



```r
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

<img src="05-CorReg_files/figure-html/unnamed-chunk-7-1.png" width="480" style="display: block; margin: auto;" />



## 4/21/20 Agenda {#Apr21}
1. Least Squares estimation of the line
2. Distribution of the least squares line from sample to sample

## 4/23/20 Agenda {#Apr23}
1. Inferential technical conditions
2. Residual Plots
3. Transformations
4. Prediction Intervals

## Simple Linear Regression

*Regression* is a method that predicts the value of one numerical variable from that of another.  That is, as an extension to describing the degree of linearity of the relationship (correlation), the goal is now to create the best linear model -- often for prediction.  Note that many of the characteristics explored with correlation are applicable for regression.  However, correlation treats $X$ and $Y$ as interchangeable, whereas regression treats $X$ as fixed and known and $Y$ as random and unknown.  As we have previously, we call $X$ the explanatory variable, and $Y$ the response variable.  Again, we do not assume that there is any causal mechanism between $X$ and $Y$ even if they have a strong linear (or otherwise) relationship.



#### Population Model {-}

Notice the Greek letters representing parameters:

\begin{eqnarray*}
E[y|x] &=& \beta_0 + \beta_1 x \\
y_i &=& \beta_0 + \beta_1 x_i + \epsilon_i\\
\epsilon_i &=& y_i -  (\beta_0 + \beta_1 x_i)\\
\end{eqnarray*}

#### Predicted Values {-}

The predicted values of Y from a regression line estimate the *mean value* of $Y$ for all individuals that have a given value of $X$.  Notice the Roman letters (English letters) represting statistics:

\begin{eqnarray*}
\hat{y} &=& b_0 + b_1 x\\
\hat{y}_i &=& b_0 + b_1 x_i\\
y_i &=& b_0 + b_1 x_i + e_i\\
e_i &=& y_i - \hat{y}_i = y_i -  (b_0 + b_1 x_i)\\
\end{eqnarray*}

Notice, that we are predicting the **mean** value of the response variable at a given value of the explanatory variable!  

###  Least Squares estimation of the regression line {#ls}


To find the values of the regression statistics, the sum of squared errors is minimized.

**SSE:** Sum of squared errors (or residuals) is a measure of how closely the line fits to the points.  SSE is the value of the squared deviations calculated at the "best" possible values of $\beta_0$ and $\beta_1$ for a given dataset.

\begin{eqnarray*}
SSE = \sum_i (y_i - \hat{y}_i)^2 = \sum_i (y_i - (b_0 + b_1 x_i) )^2
\end{eqnarray*}
is minimized by the values:
\begin{eqnarray*}
b_0 = \overline{y} - b_1 \overline{x} & \ \ \ \ \ \ \ & b_1 = r \frac{s_y}{s_x}
\end{eqnarray*}

To find the "best" fitting line, we searched for the line that has the smallest residuals (SSE) in some sense.  In particular, the goal is to try to find the line that minimizes the following quantity: $$Q=\sum e_i^2 = \sum (y_i-(b_0+b_1x_i))^2.$$


Finding $b_0$ and $b_1$ that minimize Q is a calculus problem.
$$\frac{dQ}{db_0}=-2\sum (y_i-(b_0+b_1x_i)),\qquad \frac{dQ}{db_1}=-2\sum
x_i(y_i-(b_0+b_1x_i))$$ 
Setting both derivatives equal to 0 and solving for $b_0$ and $b_1$ yields the optimal values, denoted as $b_0$ and $b_1$

One aspect of the optimization problem that is worth pointing out has to do with the role of the two variables of interest $X$ and $Y$.   If we switch the roles of $X$ and $Y$, the best fitting line will be different.  If the relationship was invariant to which variable we choose as a response, then switching the roles of $X$ and $Y$ should give a slope of $1/b_1$, which is not the case.  [Note that the role of $X$ and $Y$ **is** invariant when calculating the correlation but not when calculating the least squares regression line.]

#### Residuals {-}

Residuals measure the scatter of points above and below the least squares regression line.  We use the residuals in many of the calculations and interpretations of the model.  Indeed, the goal of the linear regression is to find a model that has small residuals.  That is, ideally, the known variable $X$ will tell us all there is to know about the unknown variable $Y$.

\begin{eqnarray*}
e_i &=& (y_i - \hat{y}_i)\\
MSE&=& \frac{\sum_i (y_i - \hat{y}_i)^2}{n-2} = \frac{\sum_i (e_i)^2}{n-2} = s^2\\
SSE &=& \sum_i (y_i - \hat{y}_i)^2 = \sum_i (e_i)^2\\
R^2 &=& 1 - \frac{Var(e_i)}{Var(y_i)}
\end{eqnarray*}


### Inference on the slope, $\beta_1$ {#infbeta1}

#### SE of the slope {-}

\begin{eqnarray*}
SE(b_1) &=& \sqrt{\frac{MSE}{\sum_i (x_i - \overline{x})^2}} = \sqrt{\frac{MSE}{(n-1)s_x^2}} = = \sqrt{\frac{\frac{\sum_i (y_i - \hat{y}_i)^2}{n-2}}{(n-1)s_x^2}}\\
\end{eqnarray*}

Just like any other statistic, the value of $b_1$ can be calculated for every sample.  The manner in which $b_1$ varies from sample to sample becomes the sampling distribution of the sample slope.  The SE of the slope will be the standard deviation associated with the sampling distribution of the slope.  The resulting inference theory is very similar to that which we saw with the mean.  The CLT describes $b_1$ to have a normal distribution, and estimating the $SE(b_1)$ induces extra variability which leads to a t-score test statistic with a t-distribution with df = $n-2$.

\begin{eqnarray*}
\mbox{t-score} = \frac{b_1 - \beta_1}{SE(b_1)} \sim t_{n-2}
\end{eqnarray*}

#### CI for the slope {-}

\begin{eqnarray*}
b_1- t^*_{\alpha/2, n-2} SE(b_1) \leq \beta_1 \leq b_1 + t^*_{\alpha/2, n-2} SE(b_1)
\end{eqnarray*}

Back to the housing data...
\begin{eqnarray*}
t_{\alpha/2,n-2} &=& qt(.975, 18-2) = 2.1199\\
SE(b_1) &=& 26.4\\
b_1 &=& 202\\
b_1 &\pm& t_{\alpha/2, n-2} SE(b_1): 202 \pm 2.1199 \cdot 26.4\\
&& (146.03, 257.97)\\
\end{eqnarray*}

That is, we are 95\% confident that the true average change in price associated with an additional square foot of house is between \$146.03 and \$257.97.


#### HT for the slope {-}

As mentioned previously,
\begin{eqnarray*}
\mbox{t-score} = \frac{b_1 - \beta_1}{SE(b_1)} \sim t_{n-2}
\end{eqnarray*}

Typically, interested is in testing whether or not the slope is zero.  The null hypothesis of $H_0: \beta_1 = 0$ addresses whether there is a non-zero linear relationship between $X$ and $Y$:

\begin{eqnarray*}
H_0:&& \mbox{ the slope of the regression line is zero}, \beta_1=0\\
H_A:&& \mbox{ the slope of the regression line is not zero}, \beta_1 \ne 0\\
\end{eqnarray*}

As with previous tests, the alternative can be one- or two-sided (depending on the research question).


Again, back to the housing data... (consider a two sided test)
\begin{eqnarray*}
t^* &=& 7.67\\
p-value &=& 2 \cdot P(t_{16} \geq 7.67) = 2 \cdot (1-pt(7.67, 16)) \approx 0
\end{eqnarray*}



#### Regression Technical Conditions {-}

* **L:** At each value of X, there is a population of possible Y-values whose mean lies on the "true" regression line (**linearity**)
* **I:** At each value of X, the Y-measurements represent a random sample from the population of possible Y-values (**independence**)  [Consider this example of lack of independence.  The researcher is trying to determine whether the number of pieces in a puzzle is linearly associated with the time to complete the puzzle.  At first we choose 2 people and let them do 10 puzzles each.  Then we let 20 independent people do the puzzles.  The first experiment will create a slope which is particular to the two people sampled (it may or may not be close to the parameter).  The second one will create a slope close to the 20 people sampled.  Note that the effective variability of the first model is based on n=2, but we *think* it is based on n=20 (if we don't notice the lack of independence).  The second slope is based on n=20, and so it will have the correct associated variability.]
* **N:** At each value of X, the distribution of possible Y-values is normal (**normality**)
* **E:** The variance of Y-values is the same at all values of X (**equal variance**)

#### Residual Plots {-}


Within a residual plot, you should be looking for the same types of things you want in a scatter plot:
* a roughly symmetric cloud of points above and below the horizontal line at zero, with a higher density of points close to the line than far from the line,
* little noticeable curvature as we move from left to right along the X-axis, and
* approximately equal variance of points above and below the line at all values of X.




## 4/28/20 Agenda {#Apr28}
1. Multiple Linear Regression

## 4/30/20 Agenda {#Apr30}
1. Choosing model
2. Residual Plots
3. Prediction Intervals (harder to plot!)


## Multiple Linear Regression {#MLR}

### Model selection {#MLRmod}

### Checking model assumptions



