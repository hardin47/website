# Smoothing Methods {#smooth}







There are different names for the smoothing functions:  smoothers, loess, lowest (locally weighted scatterplot smoothing).  They are all slightly different, and we will investigate some of the nuanced differences.  Note, however, the goal is to fit a model on $X$ that predicts $E[Y | X]$ which is not necessarily linear in $X$.  So far in the course, every model fit has been *linear* in the parameters (of said differently, the expected response is a linear function of the explanatory variables, which are sometimes transformed).

$$E[Y | X] = \beta_0 + \beta_1 X_1 + \beta_2 X_2 + \cdots + \beta_{p-1} X_{p-1} = f(X)$$

With ridge regression and lasso we were able to improve the model by making it simpler, but it was still linear.  Linear models can only go so far, because not all relationships are linear!

We've talked about transformations, and relatedly, polynomial regression.  That is, by including powers of the original variable ($X$, $X^2$, $X^3$, etc.), the model can better fit the data.

## Step functions

> **Step functions** cut the range of a variable into K distinct regions in order to produce a qualitative variable. This has the effect of fitting a piecewise constant function.

A similar idea to to polynomial regression is to fit step functions to the data.  That is, to fit a flat line for different sets of values of a given explanatory variable.  Note that the flat lines don't have any requirement that they be monotonically increasing.  (Just like the polynomial fit allows for many different increasing or decreasing trends.)

Consider the following cutpoints which partition the range of $X$:  $c_1 < c_2 < \cdots < c_K$, and create $K+1$ new variables:

\begin{eqnarray*}
C_0(X) &=& I(X < c_1)\\
C_1(X) &=& I(c_1 \leq X < c_2)\\
C_2(X) &=& I(c_2 \leq X < c_3)\\
&\vdots&\\
C_{K-1}(X) &=& I(c_{K-1} \leq X < c_K)\\
C_K(X) &=& I(c_K \leq X)
\end{eqnarray*}

where $I(\cdot)$ is the indicator function which returns a 1 if the condition is true and 0 otherwise.  Note that $C_0(X) + C_1(X) + \cdots + C_K(X) =1$, so only $K$ predictors should be used in the model.  That is:

$$E[Y_i | X_i] = \beta_0 + \beta_1 C_1(X_i) + \beta_2 C_2(X_i )+ \cdots + \beta_K C_K(X_i) $$


Note that at most one of the $C_k$ are non-zero. $\beta_0$ can be interpreted as the mean value of $Y$ given that $X < c_1$.  In contrast, the mean value of$Y$  $c_j \leq X < c_{j+1} $ is $\beta_0 + \beta_j$.  Therefore, $\beta_j$ is interpreted as the increase in expected response for $X$ in $c_j \leq X < c_{j+1} $  as compared to $X < c_1$.


Any of the $K$ step functions can be used to create the step function as a model on $X$.  However, it should be noted that using $C_1, \ldots C_K$ is more intuitive than any other set of $K$ indicator functions.  Why is that?  Consider the following functions and related models:

\begin{eqnarray*} 
C_0(X) &=& 1 \mbox{ if } X < 4\\
C_1(X) &=& 1 \mbox{ if } 4 <= X < 10\\
C_2(X) &=& 1 \mbox{ if } 10 <= X < 50\\
C_3(X) &=& 1 \mbox{ if } 50 <= X
\end{eqnarray*}

Valid models can be built with any 3 of the above basis functions:
 
\begin{eqnarray*}
\mbox{model1:  } E[Y|X] &=& \beta_0 + \beta_1 C_1(X) + \beta_2 C_2(X) + \beta_3 C_3(X)\\
\mbox{model2: }  E[Y|X] &=& \beta_0^* + \beta_1^* C_0(X) + \beta_2^* C_1(X) + \beta_3^* C_2(X) \\
\end{eqnarray*}
n.b.  The $*$ indicates that the coefficients will differ across the two models.

Given the two different models (which lead to the exact same prediction models!), note the following:

\begin{eqnarray*}
\mbox{model1:  } E[Y| X=0] &=& \beta_0\\
\mbox{model2:  } E[Y | X=0] &=& \beta_0^* + \beta_1^*\\
\mbox{model2: }  E[Y | X=100] &=& \beta_0^*
\end{eqnarray*}
Which is to say, it is more **intuitive** to have the intercept value match with X=0.  But the intercept is given when the **basis functions** equal zero (not necessarily when the X value equals zero).


### Basis Functions

Polynomial and piecewise-constant regression models are both special cases of a **basis function** approach to modeling.  The idea is that instead of regressing on a series of different $X$ values, you can regress on different functions of $X$.  We've seen this already in the form of transformations on $X$.  The basis function model is:

$$E[Y_i | X_i] = \beta_0 + \beta_1 bf_1(X_i) + \beta_2 bf_2(X_i) + \cdots + \beta_K bf_K(X_i).$$


*Remember that there are no assumptions made about the explanatory variables when running the OLS model.*  Which is to say that functions of $X$ cause no problem in the model as long as the variables are not collinear.  Note that with polynomial regression, the basis functions are: $bf_j(X_i) = X_i^j$.  When applying step functions to the model, the basis functions are $bf_j(X_i) = I(c_j \leq X_i < c_{j+1})$.  The basis function model above can be fit using standard OLS techniques.

One of the big advantages to using OLS with basis functions is that we get to bring along all of the inference tools we covered in the first part of the course.  That is, we have estimates for the standard errors of the coefficients as well as an ability to compute p-values associated with nested F-tests.  The 2*SE bounds on the estimated curves are from the appropriate errors given by the `predict()` function on the basis function model(s).



## Regression splines

> **Regression splines** (also called smoothing splines) are more flexible than polynomials and step functions, and in fact are an extension of the two. They involve dividing the range of X into K distinct regions. Within each region, a polynomial function is fit to the data. However, these polynomials are constrained so that they join smoothly at the region boundaries, or knots. Provided that the interval is divided into enough regions, this can produce an extremely flexible fit.


By combining the ideas of polynomial fits and step functions, we can create a model which fits locally but is not required to be a horizontal line.  In particular, if cubic functions are fit to each region, the model ends up as something like:

\begin{eqnarray}
E[Y_i | X_i] =
\begin{cases}
\beta_{01} + \beta_{11} X_i + \beta_{21} X_i^2 + \beta_{31}X_i^3  \mbox{  if  } X_i < c\\
\beta_{02} + \beta_{12} X_i + \beta_{22} X_i^2 + \beta_{32}X_i^3  \mbox{  if  } X_i \geq c
\end{cases}
\end{eqnarray}


**Notes:**  

* Any polynomial can be fit (step functions are polynomials of degree 0!) 
* The fit is independent of any normality or independence assumptions.  However, those assumptions are important in oder to perform inference. 
* If $f(X)$ isn't linear or polynomial in X, the model can be fit *locally*.  Note:  every function can be written as a sum of polynomials. 
* Keep in mind that splines computed from truncated polynomials can be numerically unstable because the explanatory variables may be highly correlated.


Note, however, that the cubic model in the equation above has no requirement of continuity at the value $c$.  The solution is to fit a piecewise polynomial under the constraint that the fitted curve must be continuous.   Additionally, in order for the curves to seem smooth} the constraint that both the first and second derivatives are also continuous is added.  Generally, for a degree-$d$ spline:  fit degree-$d$ polynomials with continuity in derivatives up to degree $d-1$ at each knot.

One method for fitting continuous cubic models to a partitioned $X$ variable is to create the following function $h(X, \xi)$ at each knot $\xi$.

\begin{eqnarray*}
h(X, \xi) = (X - \xi)^3_+ =
\begin{cases}
(X-\xi)^3 & \mbox{  if  } X > \xi\\
0 & \mbox{  otherwise}
\end{cases}
\end{eqnarray*}
The following cubic spline with $K$ knots is then modeled as
\begin{eqnarray}
E[Y_i | X_i] = \beta_0 + \beta_1 X_i + \beta_2 X_i^2 + \beta_3 X_i^3 + \beta_4 h(X_i, \xi_1) + \beta_5 h(X_i, \xi_2) + \cdots + \beta_{K+3} h(X_i, \xi_K). 
\end{eqnarray}
Note that there are $K+3$ predictors and $K+4$ regression coefficients to model.  We are using up $K+4$ degrees of freedom.


A little bit of work can show that the spline equation will lead to continuity in the first two derivatives and discontinuity in the third derivative (with a continuous function).  Proof ideas:


* for the continuity, consider only one knot.  As $X$ approaches $\xi$ from the left, we follow the function without the $h$ part of the function.  As $X$ approaches $\xi$ from the right, we get arbitrarily close to the function without any $h$.

Consider what happens for points before the second knot.  That is, $X \leq \xi_2$:
\begin{eqnarray*}
(X - \xi_1)^3 &=& X^3 - 3X^2 \xi_1 + 3X \xi_1^2 - \xi_1^3\\
E[Y | \xi_1 < X \leq \xi_2] &=& (\beta_0 - \beta_4 \xi_1^3) + (\beta_1 + \beta_4 3 \xi_1^2)X + (\beta_2 - \beta_4 3 \xi_1)X^2 + (\beta_3 + \beta_4)X^3\\
E[Y | X \leq \xi_1] &=& \beta_0  + \beta_1X + \beta_2X^2 + \beta_3 X^3\\
lim_{X \rightarrow \xi_1^-} E[Y|X] &=& \beta_0  + \beta_1 \xi_1 + \beta_2\xi_1^2 + \beta_3 \xi_1^3\\
lim_{X \rightarrow \xi_1^+} E[Y|X] &=& \beta_0  - \beta_4 \xi_1^3 + \beta_1 \xi_1 + \beta_4 3 \xi_1^3 + \beta_2\xi_1^2 - \beta_4 3 \xi_1^3 + \beta_3 \xi_1^3 + \beta_4\xi_1^3\\
&=&  \beta_0  + \beta_1 \xi_1 + \beta_2\xi_1^2 + \beta_3 \xi_1^3\\
\end{eqnarray*}


* for the continuity in the derivatives, recall that the derivatives are with respect to $X$.  By taking the derivatives of $E[Y_i]$ and then the limit as $X \rightarrow \xi$, the continuity of the first few derivatives and discontinuity of later derivatives can be seen.


#### Knots {-}

Knots can be placed uniformly or at places where the function is expected to change rapidly.   Most often the number of knots is set and the software places them uniformly.  The number of knots is directly related to the degrees of freedom of the model, so setting the degrees of freedom also sets the number of knots.  Ideally, a method such as dross validation will be used to optimize the number of knots.

#### degrees of freedom {-}

Note that we can fit the model based on placing the knots or based on the number of knots (specified by degrees of freedom which places df-1 internal knots).  Consider the following call to our model.  Note that there are at least three different ways to think about "degrees of freedom."


* `df` = the number in the argument of the function.  Here the number is 6 = # coefficients - 1 = # "explanatory variables" 
* df as defined in your text = the number of explanatory variables you are estimating.  Note that ISLR generally defines $p$ as the number of explanatory variables, ALSM defines $p$ to be the number of parameters.
* The remaining degrees of freedom (n - # coefficients).  Here that number is 349 - 7 = 342.  (This last version of "df" is how we are used to thinking about degrees of freedom -- how much information do you have to estimate variability?)
* Also note that the `knots` argument overrides the `df` argument.



## Local regression

> **Local regression** is similar to splines, but differs in an important way. The regions are allowed to overlap, and indeed they do so in a very smooth way.


Local regression (loess - locally weighted scatterplot smoothing) models fit flexible, non-linear models to a point $x_0$ using only training values that are close to $x_0$.  The distance of the training point from $x_0$ is considered to be a weight and is given by $K_{i0}$.   We fit weighted least squares regression using the weights from the $X$-direction.  The algorithm for local regression is given by (page 282, @ISLR):

******  
**Local Regression at $X=x_0$ ($p=2$)**  

******  
1. Gather the fraction $s=k/n$ of training points whose $X_i$ are closest to $x_0$. 
2. Assign a weight $K_{i0} = K(X_i, x_0)$ to each point in the neighborhood, so that the furthest point from $x_0$ has weight zero and the closest point has the highest weight.  All but the $k$ closest points get zero weight. 
3. Fit a weighted least squares regression of the $Y_i$ on the $X_i$ using the $K_{i0}$ weights.  Find $b_0$ and $b_1$ that minimize: 
$$\sum_{i=1}^n K_{i0}(Y_i - b_0 - b_1 X_i)^2.$$
4. The fitted value at $x_0$ is given by $\hat{f}(x_0) = b_0 + b_1x_0$. 
5.  Repeat steps 1. - 4. for every point; the coefficients & SE are re-computed each time.

To create the smooth regression function, the points are connected by drawing a line (or surface) between each predicted value.  The fraction of points with non-zero weights is given by the *span*, $s=k/n$.  The span plays a role similar to other tuning parameters.  It can be made to produce a model similar to OLS (large span) or to produce a model which way overfits the data (small span).  Cross validation can be used to find $s$.


Local Regression can theoretically be expanded to higher dimensions.  Weighted least squares (see section 11.1 in @kutner) is given by minimizing:

$$\sum_{i=1}^n w_i(Y_i - \beta_0 - \beta_1X_{i1} - \cdots - \beta_{p-1}X_{i,p-1})^2.$$

The normal equations are solved in the same way given coefficient estimates and standard errors as ($W$ is the diagonal matrix of weights):
\begin{eqnarray*}
(X^t W X) b_w &=& X^t W Y\\
b_w &=& (X^t W X)^{-1} X^t W Y\\
var(b_w) &=& \sigma^2 (X^t W X)^{-1} (X^t W W X) (X^t W X)^{-1}
\end{eqnarray*}


However, in high dimensional settings the *distance* to $x_0$ might be quite large, and there will be very few points in a high dimensional neighborhood of $x_0$.  The distance problem leads to most points have zero weight (i.e., large distance) from the other points.  And the regression estimates become quite variable and hard to estimate.

### Weight function for local regression

The standard weight function used in local regression is called the *tricubic weight function*.


* For $s < 1$, the neighborhood includes proportion $s$ of the points, and these have tricubic weighting

$$K_{i0}  = \Bigg(1 - \bigg(\frac{d(x_i, x_0)}{\max_{i \in S} d(x_i, x_0)} \bigg)^3 \Bigg)^3 I(d(x_i, x_0) < \max_{i \in S} d(x_i, x_0))$$
where $S$ defines the set of $x_i$ values which are the $k$ closest points to $x_0$.

* For $s > 1$, all points are used, with the "maximum distance" (as above) assumed to be $s^{(1/(p-1))}$ times the actual maximum distance for $p$ coefficients ($p-1$ explanatory variables). 
* Distance can be defined using any distance function, Euclidean being the default although not resistant to outliers. 
* Regression is done by least squares (default) although other regression techniques can be used (e.g., Tukey's biweight M-estimation regression...  we won't talk about that in class).
* The `loess()` function in R does the modeling / prediction.  In **ggplot2** the default method for `geom_smooth()` plot uses `loess`.



### Imputation

Imputation is the process of replacing missing data with summary values (i.e., statistics) from the rest of the data.   The biggest reason to impute data is so that the complete dataset can be used for an analysis.   Notice that within the context of the models throughout the semester, it might make sense to smooth $Y$ on some of the explanatory variables (if $Y$ is missing for some observations), but it also might make sense to smooth $X_1$ on the other explanatory variables (if $X_1$ is missing and should be used in the linear model).  

Keep in mind that the algorithm for creating a smooth prediction at $x_0$ does not depend on $x_0$ being part of the model.  That is, the prediction is possible whether or not $x_0$ has a corresponding response value.

See the R code (posted on website) for an example on imputing data using a loess smoother.


### Normalization

Microarrays and other high-throughput analysis techniques require normalization in order to create apples to apples comparisons.  From Wikipedia, https://en.wikipedia.org/wiki/Microarray_analysis_techniques

> Comparing two different arrays, or two different samples hybridized to the same array generally involves making adjustments for systematic errors introduced by differences in procedures and dye intensity effects. Dye normalization for two color arrays is often achieved by local regression. LIMMA provides a set of tools for background correction and scaling, as well as an option to average on-slide duplicate spots.[8] A common method for evaluating how well normalized an array is, is to plot an MA plot of the data.

\begin{figure}[H]
\begin{center}
\includegraphics[width=.6\textwidth]{LH_microarray.jpg}
\caption{The microarray shows differing amounts of expression across two conditions (here old and young yeast).  The expectation is that, on median, the dots (i.e., genes) should be yellow.   As can be seen from the image, points on the left side of the microarray are dimmer than the points on the right side.  The imbalance is an artifact of the technical limitations of the technique.  Image due to Laura Hoopes, Pomona College.}
\end{center}
\end{figure}




\begin{figure}[H]
\begin{center}
\includegraphics[width=.47\textwidth]{19MA.pdf} \includegraphics[width=.47\textwidth]{nolow_array_norm.pdf}
\caption{[left] M = ratio of expression, A = product of expression (total amount of expression).  The different smooth curves refer to different locations on the microarray chip.  To normalize, we subtract the line from each corresponding dot which can be thought of as taking the colored lines and pulling them taut. [right] By centering each array's expression values to zero (either across the location on the chip "print-tip group" or within an array itself), we can do an apples to apples comparison of the expression across different samples.}
\end{center}
\end{figure}

### Prediction

After Hurricane Maria devastated Puerto Rico, there was much discussion on how to count the resulting number of deaths.  Rafael Irizzary talks about his models on the <a http = "https://simplystatistics.org/2018/06/08/a-first-look-at-recently-released-official-puerto-rico-death-count-data/" target = "_blank">simplystatistics blog.</a>


\begin{figure}[H]
\begin{center}
\includegraphics[width=.47\textwidth]{deathratesmooth.png} 
\caption{Increase in death rate as a function of date.  Note the y-axis which is observed rate minus expected rate (found by using a trend line given by loess).}
\end{center}
\end{figure}

## Last Thoughts...

### Why smooth?

#### Advantages of smoothing {-}

* Smoothing methods do not require a known functional relationship between $X$ and $Y$. 
   - Regression splines does provide a functional model 
   - loess does not provide a functional model 
* The relationships are easy to fit 
* and they retain many of the advantages of weighted least squares (including confidence estimates for the predicted values). 


#### Disadvantages of smoothing {-}

* Local regression can be computationally intensive, with methods giving unstable estimates in high dimensions due to sparsity of points. 
* Regression splines have arbitrary knots which may not fit the model well. 
* Although interpolation can be used (and is used in R!) to get predictions (with standard errors), there is no functional form for the relationship between $X$ and $Y$ with loess.  Inference on coefficients is meaningless. 

## Inference

Keep in mind that in order to have a p-value (which is a probability), there must be a probability model.   OLS assumes normal errors, and if basis functions or weighted OLS are applied using standard linear model techniques, then there should be some notion that there is an *iid* normal error structure.  Confidence intervals also require a probability model in order to apply the standard inferential interpretations.

In particular, the wind temperature observations are *not* independent.  There is a strong dependency between the temperature on any two consecutive days.  The data are much better described by an autoregressive model if the goal of inference.  (Autoregression is used, e.g., when the x-variable is time and the observations are correlated.  The y-variable could be stock price or temperature.  We haven't talked about these types of models in any formal way.)  If the goal is more descriptive (or simply predictive for reasons such as normalization or extrapolation), then SE values and CI bounds are not needed, and a smooth curve will probably be effective even if the technical conditions do not hold.


#### Don't Forget {-}
There is no substitute for thinking carefully about how you are modeling relationships.  Whether it be linear, non-linear, sparse, locally weighted, or optimized.   There will not be a model which is the *one* right model.  Instead, your expertise and practice will provide you with strategies to help come up with a model that describes your data well.


For more on kernel smoothers, see the appendix of @sheather and chapter 6 of @ESL.

## <i class="fas fa-lightbulb" target="_blank"></i> Reflection Questions

1. How are the different types of flexible models represented in linear model form?  (Step functions, polynomials, regression splines, local regression) 
2. How are inferential methods applied to the models above?  What are the necessary technical assumptions to make inferential claims? 
3. What is a basis function?  How is it used similarly / differently in step functions, polynomials, and regression splines? 
4. In regression splines, how does the number of knots play a role?  How do the different choice for the number of knots change the resulting model?  Why would you choose to fit a model that had more or fewer knots? 
5.  For local regression, how do the weights play a role?  What different choices could be made with respect to the weight functions? 
6.  For local regression, how does the span play a role?  How do the different choices for the span change the resulting model?  Why would you choose to fit a model that had more or fewer knots? 
7. If inference claims are not accessible, what else can smoothing techniques be used for? 



## <i class="fas fa-balance-scale"></i> Ethics Considerations


## R: Smoothing
