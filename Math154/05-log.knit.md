# Logistic Regression



\newcommand{\logit}{\mathrm{logit}}




## Motivation for Logistic Regression {#logmodel}

During investigation of the US space shuttle *Challenger* disaster, it was learned that project managers had judged the probability of mission failure to be 0.00001, whereas engineers working on the project had estimated failure probability at 0.005.  The difference between these two probabilities, 0.00499 was discounted as being too small to worry about.  Is a different picture provided by considering odds?  How is it interpreted?

The logistic regression model is a *generalized* linear model.  That is, a linear model as a function of the expected value of the response variable.  We can now model binary response variables.
\begin{eqnarray*}
GLM: g(E[Y | X]) = \beta_0 + \beta_1 X
\end{eqnarray*}
where $g(\cdot)$ is the link function.  For logistic regression, we use the logit link function:
\begin{eqnarray*}
\logit (p) = \ln \bigg( \frac{p}{1-p} \bigg)
\end{eqnarray*}


\BeginKnitrBlock{example}<div class="example"><span class="example" id="exm:burnexamp"><strong>(\#exm:burnexamp) </strong></span>Surviving third-degree burns   
These data refer to 435 adults who were treated for third-degree burns by the University of Southern California General Hospital Burn Center. The patients were grouped according to the area of third-degree burns on the body (measured in square cm). In the table below are recorded, for each midpoint of the groupings `log(area +1)`, the number of patients in the corresponding group who survived, and the number who died from the burns. [@burn]

| log(area+1) midpoint	| survived 	| died 	| prop surv 	|
|:-----------:	|:--------:	|:----:	|:---------:	|
| 1.35 	| 13 	| 0 	| 1 	|
| 1.60 	| 19 	| 0 	| 1 	|
| 1.75 	| 67 	| 2 	| 0.971 	|
| 1.85 	| 45 	| 5 	| 0.900 	|
| 1.95 	| 71 	| 8 	| 0.899 	|
| 2.05 	| 50 	| 20 	| 0.714 	|
| 2.15 	| 35 	| 31 	| 0.530 	|
| 2.25 	| 7 	| 49 	| 0.125 	|
| 2.35 	| 1 	| 12 	| 0.077 	|
  </div>\EndKnitrBlock{example}



<img src="05-log_files/figure-html/unnamed-chunk-3-1.png" width="480" style="display: block; margin: auto;" />

We can see that the logit transformation linearizes the relationship.



A first idea might be to model the relationship between the probability of success (that the patient survives) and the explanatory variable `log(area +1)` as a simple linear regression model. However, the scatterplot of the proportions of patients surviving a third-degree burn against the explanatory variable shows a distinct curved relationship between the two variables, rather than a linear one. It seems that a transformation of the data is in place.

The functional form relating x and the probability of success looks like it could be an `S` shape.  But we'd have to do some work to figure out what the form of that `S` looks like.  Below I've given some different relationships between x and the probability of success using $\beta_0$ and $\beta_1$ values that are yet to be defined.  Regardless, we can see that by tuning the functional relationship of the `S` curve, we can get a good fit to the data.

<img src="05-log_files/figure-html/unnamed-chunk-4-1.png" width="480" style="display: block; margin: auto;" />

S-curves ( `y = exp(linear) / (1+exp(linear))` ) for a variety of different parameter settings.  Note that the x-axis is some continuous variable `x` while the y-axis is the probability of success at that value of `x`.  More on this as we move through this model.



Why doesn't linear regression work here?  

* The response isn't normal  
* The response isn't linear (until we transform)  
* The predicted values go outside the bounds of (0,1)   
* Note: it *does* work to think about values inside (0,1) as probabilities  

### The logistic model

Instead of trying to model the using *linear regression*, let's say that we consider the relationship between the variable $x$ and the probability of success to be given by the following generalized linear model. (The logistic model is just one model, there isn't anything magical about it.  We do have good reasons for how we defined it, but that doesn't mean there aren't other good ways to model the relationship.)

\begin{eqnarray*}
p(x) = \frac{e^{\beta_0 + \beta_1 x}}{1+e^{\beta_0 + \beta_1 x}}
\end{eqnarray*}
Where $p(x)$ is the probability of success (here surviving a burn).  $\beta_1$ still determines the direction and *slope* of the line.  $\beta_0$ now determines the location (median survival).

* **Note 1**  What is the probability of success for a patient with covariate of $x = -\beta_0 / \beta_1$?  
\begin{eqnarray*}
x &=& - \beta_0 / \beta_1\\
\beta_0 + \beta_1 x &=& 0\\
e^{0} &=& 1\\
p(-\beta_0 / \beta_1) &=& p(x) = 0.5
\end{eqnarray*}
(for a given $\beta_1$, $\beta_0$ determines the median survival value)
* **Note 2**  If $x=0$,
\begin{eqnarray*}
p(0) = \frac{e^{\beta_0}}{1+e^{\beta_0}}
\end{eqnarray*}
$x=0$ can often be thought of as the baseline condition, and the probability at $x=0$ takes the place of thinking about the intercept in a linear regression.
* **Note 3**  
\begin{eqnarray*}
1 - p(x) = \frac{1}{1+e^{\beta_0 + \beta_1 x}}
\end{eqnarray*}  
gives the probability of failure.
\begin{eqnarray*}
\frac{p(x)}{1-p(x)} = e^{\beta_0 + \beta_1 x}
\end{eqnarray*}  
gives the odds of success.
\begin{eqnarray*}
\ln \bigg( \frac{p(x)}{1-p(x)} \bigg) = \beta_0 + \beta_1 x
\end{eqnarray*}  
gives the $\ln$ odds of success .

* **Note 4** Every type of generalized linear model has a link function. Ours is called the *logit*.  The link is the relationship between the response variable and the *linear* function in x.
\begin{eqnarray*}
\logit(\star) = \ln \bigg( \frac{\star}{1-\star} \bigg) \ \ \ \ 0 < \star < 1
\end{eqnarray*}



#### model assumptions

Just like in linear regression, our `Y` response is the only random component.

\begin{eqnarray*}
y &=& \begin{cases}
1 & \mbox{ died}\\
0 & \mbox{ survived}
\end{cases}
\end{eqnarray*}

\begin{eqnarray*}
Y &\sim& \mbox{Bernoulli}(p)\\
P(Y=y) &=& p^y(1-p)^{1-y}
\end{eqnarray*}

<!--
%\begin{eqnarray*}
%Y &\sim& \mbox{Binomial}(m,p)\\
%P(Y=y) &=& {m \choose y}p^y(1-p)^{m-y}\\
%E(Y/m) &=& p\\
%E(Y) &=& m p\\
%Var(Y) &=& m p (1-p)
%\end{eqnarray*}
-->

When each person is at risk for a different covariate (i.e., explanatory variable), they each end up with a different probability of success.
\begin{eqnarray*}
Y_i \sim \mbox{Bernoulli} \bigg( p(x_i) = \frac{e^{\beta_0 + \beta_1 x_i}}{1+ e^{\beta_0 + \beta_1 x_i}}\bigg)
\end{eqnarray*}


* independent trials  
* success / failure  
* probability of success is constant for a particular $X$.  
* $E[Y|x] = p(x)$ is given by the logistic function  


#### interpreting coefficients

Let's say the log odds of survival for given observed (log) burn areas $x$ and $x+1$ are:
\begin{eqnarray*}
\logit(p(x)) &=& \beta_0 + \beta_1 x\\
\logit(p(x+1)) &=& \beta_0 + \beta_1 (x+1)\\
\beta_1 &=& \logit(p(x+1)) - \logit(p(x))\\
&=& \ln \bigg(\frac{p(x+1)}{1-p(x+1)} - \frac{p(x)}{1-p(x)} \bigg)\\
&=& \ln \bigg( \frac{p(x+1) / [1-p(x+1)]}{p(x) / [1-p(x)]} \bigg)\\
e^{\beta_1} &=& \bigg( \frac{p(x+1) / [1-p(x+1)]}{p(x) / [1-p(x)]} \bigg)\\
\end{eqnarray*}

$e^{\beta_1}$ is the *odds ratio* for dying associated with a one unit increase in x. [$\beta_1$ is the change in log-odds associated with a one unit increase in x.

\begin{eqnarray*}
\logit (\hat{p}) = 22.708 - 10.662 \cdot \ln(\mbox{ area }+1).
\end{eqnarray*}

(Suppose we are interested in comparing the odds of surviving third-degree burns for patients with burns corresponding to `log(area +1)= 1.90`, and patients with burns corresponding
to `log(area +1)= 2.00`. The odds ratio $\hat{OR}_{1.90, 2.00}$ is given by
\begin{eqnarray*}
\hat{OR}_{1.90, 2.00} = e^{-10.662} (1.90-2.00) = e^{1.0662} = 2.904
\end{eqnarray*}
That is, the odds of survival for a patient with `log(area+1)= 1.90` is 2.9 times higher than the odds of survival for a patient with `log(area+1)= 2.0`.)


What about the RR (relative risk) or difference in risks?  It won't be constant for a given $X$, so it must be calculated as a function of $X$.

### constant OR, varying RR

The previous model specifies that the OR is constant for any value of $X$ which is not true about RR.  Using the burn data, convince yourself that the RR isn't constant.  Try computing the RR at 1.5 versus 2.5, then again at 1 versus 2.
\begin{eqnarray*}
\logit (\hat{p}) &=& 22.708 - 10.662 \cdot \ln(\mbox{ area }+1)\\
\hat{p(x)} &=& \frac{e^{22.708 - 10.662 x}}{1+e^{22.708 - 10.662 x}}\\
\end{eqnarray*}

\begin{eqnarray*}
\hat{p}(1) &=& 0.9999941\\
\hat{p}(1.5) &=& 0.9987889\\
\hat{p}(2) &=& 0.7996326\\
\hat{p}(2.5) &=& 0.01894664\\
\hat{RR}_{1, 2} &=& 1.250567\\
\hat{RR}_{1.5, 2.5} &=& 52.71587\\
\end{eqnarray*}

\begin{eqnarray*}
\hat{RR} &=& \frac{\frac{e^{b_0 + b_1 x}}{1+e^{b_0 + b_1 x}}}{\frac{e^{b_0 + b_1 (x+1)}}{1+e^{b_0 + b_1 (x+1)}}}\\
&=& \frac{\frac{e^{b_0}e^{b_1 x}}{1+e^{b_0}e^{b_1 x}}}{\frac{e^{b_0} e^{b_1 x} e^{b_1}}{1+e^{b_0}e^{b_1 x} e^{b_1}}}\\
&=& \frac{1+e^{b_0}e^{b_1 x}e^{b_1}}{e^{b_1}(1+e^{b_0}e^{b_1 x})}\\
\end{eqnarray*}
(see log-linear model below, \@ref(altmodels) )

#### Alternative strategies for binary outcomes {#altmodels}

It is quite common to have binary outcomes (response variable) in the medical literature.  However, the logit link (logistic regression) is only one of a variety of models that we can use. We see above that the logistic model imposes a constant OR for any value of $X$ (and *not* a constant RR).


* **complementary log-log**  
The complementary log-log model is used when you have a rate of, for example, infection, model by instances of contact (based on a Poisson model).
\begin{eqnarray*}
p(k) &=& 1-(1-\lambda)^k\\
\ln[ - \ln (1-p(k))] &=& \ln[-\ln(1-\lambda)] + \ln(k)\\
\ln[ - \ln (1-p(k))] &=& \beta_0 + 1 \cdot \ln(k)\\
\ln[ - \ln (1-p(k))] &=& \beta_0 + \beta_1 x\\
p(x) &=& 1 - \exp [ -\exp(\beta_0 + \beta_1 x) ]
\end{eqnarray*}
* **linear**  
The excess (or additive) risk model can modeled by using simple linear regression:
\begin{eqnarray*}
p(x) &=& \beta_0 + \beta_1 x
\end{eqnarray*}
which we have already seen is problematic for a variety of reasons.  However, any **unit increase in $x$ gives a $\beta_1$ increase in the risk** (for *all* values of $x$).
* **log-linear**  
As long as we do not have a case-control study, we can model the risk using a log-linear model.
\begin{eqnarray*}
\ln (p(x)) = \beta_0 + \beta_1 x
\end{eqnarray*}
The regression coefficient, $\beta_1$, has the interpretation of the **logarithm of the relative risk associated with a unit increase in $x$**.  Although many software programs will fit this model, it may present numerical difficulties because of the constraint that the sum of terms on the right-hand side must be no greater than zero for the results to make sense (due to the constraint that the outcome probability p(x) must be in the interval [0,1]).  As a result, convergence of standard fitting algorithms may be unreliable in some cases.


## Estimating coefficients in logistic regression  {#logMLE}

### Maximum Likelihood Estimation

Recall how we estimated the coefficients for linear regression. We minimized the residual sum of squares:
\begin{eqnarray*}
RSS &=& \sum_i (Y_i - \hat{Y}_i)^2\\
 &=& \sum_i (Y_i - (b_0 + b_1 X_i))^2
\end{eqnarray*}
That is, we take derivatives with respect to both $b_0$ and $b_1$, set them equal to zero (take second derivatives to ensure minimums), and solve for $b_0$ and $b_1$.  It turns out that we've also *maximized the normal likelihood*.
\begin{eqnarray*}
L(\underline{y} | b_0, b_1, \underline{x}) &=& \prod_i \frac{1}{\sqrt{2 \pi \sigma^2}} e^{(y_i - b_0 - b_1 x_i)^2 / 2 \sigma}\\
&=& \bigg( \frac{1}{2 \pi \sigma^2} \bigg)^{n/2} e^{\sum_i (y_i - b_0 - b_1 x_i)^2 / 2 \sigma}\\
\end{eqnarray*}


What does that even mean?  Likelihood?  Maximizing the likelihood? WHY???  The likelihood is the probability distribution of the data given *specific* values of the unknown parameters.

Consider a toy example describing, for example, flipping coins. Let's say $X \sim Bin(p, n=4).$  We have 4 trials and $X=1$.  Would you guess $p=0.49$??  No, you would guess $p=0.25$... you *maximized* the likelihood of **seeing your data**.
\begin{eqnarray*}
P(X=1 | p) &=& {4 \choose 1} p^1 (1-p)^{4-1}\\
P(X=1 | p = 0.9) &=& 0.0036 \\
P(X=1 | p = 0.75) &=& 0.047 \\
P(X=1 | p = 0.5) &=& 0.25\\
P(X=1 | p = 0.05) &=& 0.171\\
P(X=1 | p = 0.15) &=& 0.368\\
P(X=1 | p = 0.25) &=& 0.422\\
\end{eqnarray*}

Or, we can think about it as a set of independent binary responses, $Y_1, Y_2, \ldots Y_n$.  Since each observed response is independent and follows the Bernoulli distribution, the probability of a particular outcome can be found as:
\begin{eqnarray*}
P(Y_1=y_1, Y_2=y_2, \ldots, Y_n=y_n) &=& P(Y_1=y_1) P(Y_2 = y_2) \cdots P(Y_n = y_n)\\
&=& p^{y_1}(1-p)^{1-y_1} p^{y_2}(1-p)^{1-y_2} \cdots p^{y_n}(1-p)^{1-y_n}\\
&=& p^{\sum_i y_i} (1-p)^{\sum_i (1-y_i)}\\
\end{eqnarray*}
where $y_1, y_2, \ldots, y_n$ represents a particular observed series of 0 or 1 outcomes and $p$ is a probability $0 \leq p \leq 1$.  Once $y_1, y_2, \ldots, y_n$ have been observed, they are fixed values.  Maximum likelihood estimates are functions of sample data that are derived by finding the value of $p$ that maximizes the likelihood functions.

To maximize the likelihood, we use the natural log of the likelihood (because we know we'll get the same answer):
\begin{eqnarray*}
\ln L(p) &=& \ln \Bigg(p^{\sum_i y_i} (1-p)^{\sum_i (1-y_i)} \Bigg)\\
&=& \sum_i y_i \ln(p) + (n- \sum_i y_i) \ln (1-p)\\
\frac{ \partial \ln L(p)}{\partial p} &=& \sum_i y_i \frac{1}{p} + (n - \sum_i y_i) \frac{-1}{(1-p)} = 0\\
0 &=& (1-p) \sum_i y_i + p (n-\sum_i y_i) \\
\hat{p} &=& \frac{ \sum_i y_i}{n}
\end{eqnarray*}

Using the logistic regression model makes the likelihood substantially more complicated because the probability of success changes for each individual. Recall:
\begin{eqnarray*}
p_i = p(x_i) &=& \frac{e^{b_0 + b_1 x_i}}{1+e^{b_0 + b_1 x_i}}
\end{eqnarray*}
which gives a likelihood of:
\begin{eqnarray*}
L(\underline{p}) &=& \prod_i \Bigg( \frac{e^{b_0 + b_1 x_i}}{1+e^{b_0 + b_1 x_i}} \Bigg)^{y_i} \Bigg(1-\frac{e^{b_0 + b_1 x_i}}{1+e^{b_0 + b_1 x_i}} \Bigg)^{(1- y_i)} \\
\mbox{& a loglikelihood of}: &&\\
\ln L(\underline{p}) &=& \sum_i y_i \ln\Bigg( \frac{e^{b_0 + b_1 x_i}}{1+e^{b_0 + b_1 x_i}} \Bigg) + (1-  y_i) \ln \Bigg(1-\frac{e^{b_0 + b_1 x_i}}{1+e^{b_0 + b_1 x_i}} \Bigg)\\
\end{eqnarray*}

Why use maximum likelihood estimates?

* Estimates are essentially unbiased.  
* We can estimate the SE (Wald estimates via Fisher Information).  
* The estimates have low variability.  
* The estimates have an approximately normal sampling distribution for large sample sizes because they are maximum likelihood estimates.  
* Though it is important to realize that we cannot find estimates in closed form.  

## Formal Inference {#loginf}

### Wald Tests & Intervals

Because we will use maximum likelihood parameter estimates, we can also use large sample theory to find the SEs and consider the estimates to have normal distributions (for large sample sizes).  However, [@menard] warns that for large coefficients, standard error is inflated, lowering the Wald statistic (chi-square) value. [@agresti] states that the likelihood-ratio test is more reliable for small sample sizes than the Wald test.

\begin{eqnarray*}
z = \frac{b_1 - \beta_1}{SE(b_1)}
\end{eqnarray*}


```r
library(tidyverse); library(broom)
glm(burnresp~burnexpl, data = burnglm, family="binomial")
```

```
## 
## Call:  glm(formula = burnresp ~ burnexpl, family = "binomial", data = burnglm)
## 
## Coefficients:
## (Intercept)     burnexpl  
##       22.71       -10.66  
## 
## Degrees of Freedom: 434 Total (i.e. Null);  433 Residual
## Null Deviance:	    525.4 
## Residual Deviance: 335.2 	AIC: 339.2
```

```r
glm(burnresp~burnexpl, data = burnglm, family="binomial") %>% tidy()
```

```
## # A tibble: 2 x 5
##   term        estimate std.error statistic  p.value
##   <chr>          <dbl>     <dbl>     <dbl>    <dbl>
## 1 (Intercept)     22.7      2.27     10.0  1.23e-23
## 2 burnexpl       -10.7      1.08     -9.85 6.95e-23
```

### Likelihood Ratio Tests
$\frac{L(p_0)}{L(\hat{p})}$ gives us a sense of whether the null value or the observed value produces a higher likelihood. Recall:
\begin{eqnarray*}
L(\hat{\underline{p}}) > L(p_0)
\end{eqnarray*}
always.  [Where $\hat{\underline{p}}$ is the maximum likelihood estimate for the probability of success (here it will be a vector of probabilities, each based on the same MLE estimates of the linear parameters). ] The above inequality holds because $\hat{\underline{p}}$ maximizes the likelihood.

We can show that if $H_0$ is true,
\begin{eqnarray*}
-2 \ln \bigg( \frac{L(p_0)}{L(\hat{p})} \bigg) \sim \chi^2_1
\end{eqnarray*}
If we are testing only one parameter value.  More generally,
\begin{eqnarray*}
-2 \ln \bigg( \frac{\max L_0}{\max L} \bigg) \sim \chi^2_\nu
\end{eqnarray*}
where $\nu$ is the number of extra parameters we estimate using the unconstrained likelihood (as compared to the constrained null likelihood).


\BeginKnitrBlock{example}<div class="example"><span class="example" id="exm:unnamed-chunk-6"><strong>(\#exm:unnamed-chunk-6) </strong></span>Consider a data set with 147 people.  49 got cancer and 98 didn't.  Let's test whether the true proportion of people who get cancer is $p=0.25$.
\begin{eqnarray*}
H_0:&& p=0.25\\
H_1:&& p \ne 0.25\\
\hat{p} &=& \frac{49}{147}\\
-2 \ln \bigg( \frac{L(p_0)}{L(\hat{p})} \bigg) &=& -2 [ \ln (L(p_0)) - \ln(L(\hat{p}))]\\
&=& -2 \Bigg[ \ln \bigg( (0.25)^{y} (0.75)^{n-y} \bigg) - \ln \Bigg( \bigg( \frac{y}{n} \bigg)^{y} \bigg( \frac{(n-y)}{n} \bigg)^{n-y} \Bigg) \Bigg]\\
&=& -2 \Bigg[ \ln \bigg( (0.25)^{49} (0.75)^{98} \bigg) - \ln \Bigg( \bigg( \frac{1}{3} \bigg)^{49} \bigg( \frac{2}{3} \bigg)^{98} \Bigg) \Bigg]\\
&=& -2 [ \ln(0.0054) - \ln(0.0697) ] = 5.11\\
P( \chi^2_1 \geq 5.11) &=& 0.0238
\end{eqnarray*}</div>\EndKnitrBlock{example}



But really, usually likelihood ratio tests are more interesting.  In fact, usually, we use them to test whether the coefficients are zero:

\begin{eqnarray*}
H_0: && \beta_1 =0\\
H_1: && \beta_1 \ne 0\\
p_0 &=& \frac{e^{\hat{\beta}_0}}{1 + e^{\hat{\beta}_0}}
\end{eqnarray*}
where $\hat{\beta}_0$ is fit from a model without any explanatory variable, $x$.

**Important note:**
\begin{eqnarray*}
\mbox{deviance} = \mbox{constant} - 2 \ln(\mbox{likelihood})
\end{eqnarray*}
That is, the difference in log likelihoods will be the opposite difference in deviances:
\begin{eqnarray*}
\mbox{test stat} &=& \chi^2\\
&=& -2 \ln \bigg( \frac{L(p_0)}{L(\hat{p})} \bigg)\\
&=& -2 [ \ln(L(p_0)) - \ln(L(\hat{p})) ]\\
&=& \mbox{deviance}_0 - \mbox{deviance}_{model}\\
&=& \mbox{deviance}_{null} - \mbox{deviance}_{residual}\\
&=& \mbox{deviance}_{reduced} - \mbox{deviance}_{full}\\
\end{eqnarray*}



```r
summary(glm(burnresp~burnexpl, data = burnglm, family="binomial"))
```

```
## 
## Call:
## glm(formula = burnresp ~ burnexpl, family = "binomial", data = burnglm)
## 
## Deviance Residuals: 
##     Min       1Q   Median       3Q      Max  
## -2.8518  -0.6998   0.1859   0.5239   2.2089  
## 
## Coefficients:
##             Estimate Std. Error z value Pr(>|z|)    
## (Intercept)   22.708      2.266  10.021   <2e-16 ***
## burnexpl     -10.662      1.083  -9.849   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 525.39  on 434  degrees of freedom
## Residual deviance: 335.23  on 433  degrees of freedom
## AIC: 339.23
## 
## Number of Fisher Scoring iterations: 6
```

```r
glm(burnresp~burnexpl, data = burnglm, family="binomial") %>% tidy()
```

```
## # A tibble: 2 x 5
##   term        estimate std.error statistic  p.value
##   <chr>          <dbl>     <dbl>     <dbl>    <dbl>
## 1 (Intercept)     22.7      2.27     10.0  1.23e-23
## 2 burnexpl       -10.7      1.08     -9.85 6.95e-23
```

```r
glm(burnresp~burnexpl, data = burnglm, family="binomial") %>% glance() %>% 
  print.data.frame(digits=6)
```

```
##   null.deviance df.null   logLik     AIC     BIC deviance df.residual
## 1       525.386     434 -167.616 339.231 347.382  335.231         433
```

\begin{eqnarray*}
\mbox{test stat} &=& G\\
&=& -2 \ln \bigg( \frac{L(p_0)}{L(\hat{p})} \bigg)\\
&=& -2 [ \ln(L(p_0)) - \ln(L(\hat{p})) ]\\
&=& \mbox{deviance}_0 - \mbox{deviance}_{model}\\
&=& \mbox{deviance}_{null} - \mbox{deviance}_{residual}\\
&=& \mbox{deviance}_{reduced} - \mbox{deviance}_{full}\\
\end{eqnarray*}

So, the LRT here is (see columns of `null deviance` and `deviance`):
\begin{eqnarray*}
G &=& 525.39 - 335.23 = 190.16\\
p-value &=& P(\chi^2_1 \geq 190.16) = 0
\end{eqnarray*}


#### modeling categorical predictors with multiple levels 

##### Snoring 
A study was undertaken to investigate whether snoring is related to a heart disease. In the survey, 2484 people were classified according to their proneness to snoring (never, occasionally, often, always) and whether or not they had the heart disease.

| Variable 	| Description 	|
|--------------------------------	|--------------------------------------------------	|
| disease (response variable) 	| Binary variable: having disease=1, 	|
|  	| not having disease=0 	|
| snoring (explanatory variable) 	| Categorical variable indicating level of snoring 	|
|  	| (never=1, occasionally=2, often=3 and always=4) 	|	

Source: [@snoring]

\begin{eqnarray*}
X_1 = \begin{cases}
  1 & \text{for occasionally} \\
  0 & \text{otherwise} \\
\end{cases}
X_2 = \begin{cases}
  1 & \text{for often} \\
  0 & \text{otherwise} \\
\end{cases}
X_3 = \begin{cases}
  1 & \text{for always} \\
  0 & \text{otherwise} \\
\end{cases}
\end{eqnarray*}

Our new model becomes:
\begin{eqnarray*}
\logit(p) = \beta_0 + \beta_1 X_1 + \beta_2 X_2 + \beta_3 X_3
\end{eqnarray*}


We can use the drop-in-deviance test to test the effect of any or all of the parameters (of which there are now *four*) in the model.


See the birdnest example, \@ref(birdexamp)

## Multiple Logistic Regression {#multlog}

### Interaction

Another worry when building models with multiple explanatory variables has to do with variables interacting.  That is, for one level of a variable, the relationship of the main predictor on the response is different.

\BeginKnitrBlock{example}<div class="example"><span class="example" id="exm:unnamed-chunk-8"><strong>(\#exm:unnamed-chunk-8) </strong></span>Consider a simple linear regression model on number of hours studied and exam grade.  Then addclass year to the model.  There would probably be a different slope for each class year in order to model the two variables most effectively.  For simplicity, consider only first year students and seniors.

\begin{eqnarray*}
E[\mbox{grade seniors}| \mbox{hours studied}] &=& \beta_{0s} + \beta_{1s} \mbox{hrs}\\
E[\mbox{grade first years}| \mbox{hours studied}] &=& \beta_{0f} + \beta_{1f} \mbox{hrs}\\
E[\mbox{grade}| \mbox{hours studied}] &=& \beta_{0} + \beta_{1} \mbox{hrs} + \beta_2 I(\mbox{year=senior}) + \beta_{3} \mbox{hrs} I(\mbox{year = senior})\\
\beta_{0f} &=& \beta_{0}\\
\beta_{0s} &=& \beta_0 + \beta_2\\
\beta_{1f} &=& \beta_1\\
\beta_{1s} &=& \beta_1 + \beta_3
\end{eqnarray*}</div>\EndKnitrBlock{example}

Why do we need the $I(\mbox{year=seniors})$ variable?

\BeginKnitrBlock{definition}<div class="definition"><span class="definition" id="def:unnamed-chunk-9"><strong>(\#def:unnamed-chunk-9) </strong></span>*Interaction* means that the effect of an explanatory variable on the outcome differs according to the level of another explanatory variable.  (Not the case with age on smoking and lung cancer above.  With the smoking example, age is a significant variable, but it does not interact with lung cancer.)</div>\EndKnitrBlock{definition}

<!--
Recall the homework assignment where APACHE score was a significant predictor of the odds of dying for treated black patients but not for untreated.  This is interaction.  The relationship between the explanatory variable (APACHE score) and the response (survival) changes depending on a 3rd variables (treated vs. untreated).
-->

\BeginKnitrBlock{example}<div class="example"><span class="example" id="exm:unnamed-chunk-10"><strong>(\#exm:unnamed-chunk-10) </strong></span>The Heart and Estrogen/progestin Replacement Study (HERS) is a randomized, double-blind, placebo-controlled trial designed to test the efficacy and safety of estrogen plus progestin therapy for prevention of recurrent coronary heart disease (CHD) events in women. The participants are postmenopausal women with a uterus and with CHD.  Each woman was randomly assigned to receive one tablet containing 0.625 mg conjugated estrogens plus 2.5 mg medroxyprogesterone acetate daily or an identical placebo.  The results of the first large randomized clinical trial to examine the effect of hormone replacement therapy (HRT) on women with heart disease appeared in JAMA in 1998 [@HERS].

The Heart and Estrogen/Progestin Replacement Study (HERS) found that the use of estrogen plus progestin in postmenopausal women with heart disease did not prevent further heart attacks or death from coronary heart disease (CHD). This occurred despite the positive effect of treatment on lipoproteins: LDL (bad) cholesterol was reduced by 11 percent and HDL (good) cholesterol was increased by 10 percent.

The hormone replacement regimen also increased the risk of clots in the veins (deep vein thrombosis) and lungs (pulmonary embolism).  The results of HERS are surprising in light of previous observational studies, which found lower rates of CHD in women who take postmenopausal estrogen.
 
 
Data available at: http://www.biostat.ucsf.edu/vgsm/data/excel/hersdata.xls  For now, we will try to predict whether the individuals had a pre-existing medical condition (other than CHD, self reported), `medcond`.  We will use the variables `age`, `weight`, `diabetes` and `drinkany`.</div>\EndKnitrBlock{example}



```r
HERS <- read.table("~/Dropbox/teaching/math150/HERS.csv", 
                   sep=",", header=T, na.strings=".")

glm(medcond ~ age, data = HERS, family="binomial") %>% tidy()
```

```
## # A tibble: 2 x 5
##   term        estimate std.error statistic   p.value
##   <chr>          <dbl>     <dbl>     <dbl>     <dbl>
## 1 (Intercept)  -1.60     0.401       -4.00 0.0000624
## 2 age           0.0162   0.00597      2.71 0.00664
```

```r
glm(medcond ~ age + weight, data = HERS, family="binomial") %>% tidy()
```

```
## # A tibble: 3 x 5
##   term        estimate std.error statistic   p.value
##   <chr>          <dbl>     <dbl>     <dbl>     <dbl>
## 1 (Intercept) -2.17      0.496       -4.37 0.0000124
## 2 age          0.0189    0.00613      3.09 0.00203  
## 3 weight       0.00528   0.00274      1.93 0.0542
```

```r
glm(medcond ~ age+diabetes, data = HERS, family="binomial") %>% tidy()
```

```
## # A tibble: 3 x 5
##   term        estimate std.error statistic      p.value
##   <chr>          <dbl>     <dbl>     <dbl>        <dbl>
## 1 (Intercept)  -1.89     0.408       -4.64 0.00000349  
## 2 age           0.0185   0.00603      3.07 0.00217     
## 3 diabetes      0.487    0.0882       5.52 0.0000000330
```

```r
glm(medcond ~ age*diabetes, data = HERS, family="binomial") %>% tidy()
```

```
## # A tibble: 4 x 5
##   term         estimate std.error statistic     p.value
##   <chr>           <dbl>     <dbl>     <dbl>       <dbl>
## 1 (Intercept)   -2.52     0.478       -5.26 0.000000141
## 2 age            0.0278   0.00707      3.93 0.0000844  
## 3 diabetes       2.83     0.914        3.10 0.00192    
## 4 age:diabetes  -0.0354   0.0137      -2.58 0.00986
```

```r
glm(medcond ~ age*drinkany, data = HERS, family="binomial") %>% tidy()
```

```
## # A tibble: 4 x 5
##   term         estimate std.error statistic p.value
##   <chr>           <dbl>     <dbl>     <dbl>   <dbl>
## 1 (Intercept)  -0.991     0.511       -1.94  0.0526
## 2 age           0.00885   0.00759      1.17  0.244 
## 3 drinkany     -1.44      0.831       -1.73  0.0833
## 4 age:drinkany  0.0168    0.0124       1.36  0.175
```

Write out a few models *by hand*, does any of the significance change with respect to interaction?  Does the interpretation change with interaction?  In the last model, we might want to remove all the age information.  Age seems to be less important than drinking status. How do we decide?  How do we model?

### Simpson's Paradox

**Simpson's paradox** is when the association between two variables is opposite the partial association between the same two variables after controlling for one or more other variables.

\BeginKnitrBlock{example}<div class="example"><span class="example" id="exm:unnamed-chunk-12"><strong>(\#exm:unnamed-chunk-12) </strong></span>Back to linear regression to consider Simpson's Paradox.  Consider data on SAT scores across different states with information on educational expenditure.  The correlation between SAT score and average teacher salary is negative with the combined data.  However, SAT score and average teacher salary is positive after controlling for the fraction of students who take the exam.  The fewer students who take the exam, the higher the SAT score.  That's because states whose public universities encourage the ACT have SAT-takers who are leaving the state for college (with their higher SAT scores).</div>\EndKnitrBlock{example}







































