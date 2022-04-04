# Shrinkage Methods {#shrink}





Recall the two methods we've used so far to find sets of variable (and their coefficients):  

1. Choose models using domain knowledge and then applying **computational** methods (i.e., cross validation) to decide which model is superior.  Apply least squares (i.e., calculus) to find the coefficients.  
2. Adding variables systematically using **statistical** criteria (F-tests, adjusted $R^2$, $C_p$, BIC, AIC).  Apply least squares (i.e., calculus) to find the coefficients.
 
We move to a new model building algorithm that uses all $p-1$ explanatory variables and constrains the coefficient estimates, or equivalently, shrinks the coefficient estimates toward zero.   It turns out that shrinking the coefficients toward zero can substantially reduce the variance of the estimates (albeit adding a bit of bias).

3. That is, use **mathematical** optimization to shrink (set) some of the coefficients to zero (while simultaneously solving for the other non-zero coefficients).

The main reason to use shrinkage techniques is when the model has a lot of predictor variables ($p$ big) or when the model has a lot of predictor variables in comparison to the number of observations ($n \approx p$ or $n < p$) --- because that is when we get huge (infinite!) variability associated with the coefficients!



## On Inverting Matrices

**$X_{n \times p}$:**  The data matrix is $n \times p$.  We think of the data as being $n$ points in $p$ dimensions.  It is important to realize that not only are the points indexed in $p$ dimensions, but the points also take up the entire p-dimensional space.  [As an aside:  Whether a set of points takes up an entire space does not depend on how the points are indexed.  For example, think about a (2-dimensional) piece of paper floating in the sky with many many points on it.  You might index the coordinates of points on the paper using three dimensions, however, the paper / points  themselves actually live in a 2-dimensional subspace.]  To reiterate:  in an **ideal** world, the $n$ points live in $p$ space and cannot be considered to live in a smaller dimension than $p$.  Sometimes, the $n$ points are indexed to live in $p$ space, but actually take up a lower dimensional subspace (e.g., if two of the variable columns are perfectly correlated).

*However*, there are times when an $n \times p$ matrix lives in a space which is smaller than $p$.  For example, 

1. If two of the $p$ columns are exact linear combinations of one another, then the points will actually live in $p-1$ space. 
2. If the number of points is less than $p$  ($n < p$) then the points will only live in $n$ space.  For example, there is no way for two points take up three dimensions!

**$X^t X$:**  The matrix $X^tX$ is a linear transformation of the original $X$ matrix.  That is, if $X$ lives in $p$ space, it can't be linearly transformed into a higher dimension.  We could transform $X$ into a higher dimension by using functions or some kind of kernel mapping, but we can't do it via linear transformations.  That is to say, if $X$ has a rank which is lower than $p$, any linear combination will also, necessarily, transform the data into a space which is lower than $p$.

**$(X^tX)^{-1}$:**  The inverse of the matrix also represents a mapping.   Recall that if $AX = Y$ then $X= A^{-1}Y$.  But if we are mapping into a smaller space (smaller than $p$) then we can't invert back to a larger space (i.e., back to $p$).  And because $(X^tX)^{-1}$ is a $p \times p$ matrix, we are trying to invert back to a $p$ dimensional space.  Recall the Big Theorem in Linear Algebra that says if a $p \times p$ matrix has rank lower than $p$, it isn't invertible (also that it will have determinant zero, will have some eigenvalues that are zero, etc.)

**So...**  The point is that if $X$ doesn't have full rank (that is, if it has dimension less than $p$), there will be problems with computing $(X^tX)^{-1}$.  And the matrix $(X^tX)^{-1}$ is vitally important in computing both the least squares coefficients and their standard errors.

## Ridge Regression

Recall that the OLS (ordinary least squares) technique minimizes the distance between the observed and predicted values of the response.  That is, we found the $b_0, b_1, \ldots b_{p-1}$ that minimize:
$$SSE = \sum_{i=1}^n \bigg( Y_i - b_0 - \sum_{j=1}^{p-1} b_j X_{ij} \bigg)^2.$$

Using the OLS algorithm for modeling, the values of $b_i$ give the exact same model as the model built using the standardized variables which produce $b_i^*$.  However, as you will see, it is important to **standardize all variables before running ridge regression**.

For ease of computation, we will assume from here on that the variables have all been standardized as described above (in a previous section).  [Note:  ISL describes standardizing by only dividing by the standard deviation and not centering.  The two different methods will not produce different models (with respect to significance, etc.), but they will produce different intercept coefficients.  Indeed, scale is the important aspect to consider when working with shrinkage models.]

The ridge regression coefficients are calculated in a similar way to OLS, but the optimization equation seeks to minimize:

$$\sum_{i=1}^n \bigg( Y_i - b_0 - \sum_{j=1}^{p-1} b_j X_{ij} \bigg)^2 + \lambda \sum_{j=1}^{p-1} b_j^2 = SSE + \lambda \sum_{j=1}^{p-1} b_j^2$$
where $\lambda \geq 0$ is a *tuning parameter*, to be determined separately.  The ridge regression optimization provides a trade-off between two different criteria: variance and bias.  As with OLS, ridge regression seeks to find coefficients that fit the data well (minimize SSE!).   Additionally, ridge regression shrinks the coefficients to zero by adding a penalty so that smaller values of $b_j$ are preferred - the shrinkage makes the estimates less variable.  It can be proved that there is always a $\lambda \ne 0$ which gives smaller E[MSE] than OLS.    Note:  the shrinkage does not apply to the intercept!

Note:  the Gauss-Markov theorem says that OLS solutions are the best (i.e., smallest variance) linear unbiased estimates (BLUE).  But if we add a bit of bias, we can do better.  There is an existence theory that says:
$$ \exists \ \  \lambda \mbox{ such that } E[MSE_{RR}] < E[MSE_{OLS}].$$

### The Ridge Regression Solution

\begin{eqnarray*}
\mbox{OLS: } \underline{b} &=& (X^t X)^{-1} X^t \underline{Y}\\
\mbox{ridge regression: } \underline{b} &=& (X^t X + \lambda \mathtt{I})^{-1} X^t \underline{Y}\\
\end{eqnarray*}



**Notes:**  
* The tuning parameter $\lambda$ balances the effect of the two different criteria in the optimization equation.  When $\lambda=0$, ridge regression is reduced to OLS.  As $\lambda \rightarrow \infty$, the coefficient estimates will shrink to zero.  
* We have assumed that the variables have been centered to have mean zero before ridge regression is performed.  Therefore, the estimated intercept will be $$b_0 = \overline{Y} = \frac{1}{n} \sum_i Y_i \ \ \ \ \ \ (= 0 \mbox{ if $Y$ is also centered}) $$  
* Note that the ridge regression optimization above is a constrained optimization equation, solved by Lagrange multipliers.  That is, we minimize $SSE = \sum_{i=1}^n \bigg( Y_i - b_0 - \sum_{j=1}^{p-1} b_j X_{ij} \bigg)^2$ subject to $\sum_{j=1}^{p-1} b_j^2 \leq s$ for some value of $s$.  Note that $s$ is inversely related to $\lambda$.


### Ridge Regression visually

Ridge regression is typically applied to situations with many many variables.  In particular, ridge regression will help us avoid situations of multicollinearity.  It doesn't make sense to apply it to a situation with only one or two variables.  However, we will demonstrate the process visually with $p=3$ dimensions because it is difficult to visualize in higher dimensions.

The ridge regression coefficient estimates solve the following optimization problem:

$$ \min_\beta \Bigg\{ \sum_{i=1}^n \Bigg( Y_i - b_0 - \sum_{j=1}^{p-1} b_j X_{ij} \Bigg)^2 \Bigg\} \mbox{  subject to  } \sum_{j=1}^{p-1} b_j^2 \leq s$$



### Why Ridge Regression?

Recall that the main benefit to ridge regression is when $p$ is large (particularly in relation to $n$).  Remember that this (and multicollinearity) leads to instability of $(X^tX)^{-1}$.  Which leads to huge variability in the coefficient estimates.  A small change in the model or the observations can create wildly different estimates.   So the expected value of the MSE can be quite inflated due to the variability of the model.   Ridge regression adds a small amount of bias to the model, but it lowers the variance substantially and creates lower (on average) MSE values.

Additionally, ridge regression has computational advantages over the subset selection models (where all subsets requires searching through $2^{p-1}$ models).

#### Why is ridge regression better than least squares? {-}

The advantage is apparent in the bias-variance trade-off. As $\lambda$ increases, the flexibility of the ridge regression fit decreases. This leads to decrease variance, with a smaller increase in bias. Regular OLS regression is fixed with high variance, but no bias. However, the lowest test MSE tends to occur at the intercept between variance and bias. Thus, by properly tuning $\lambda$ and acquiring less variance at the cost of a small amount of bias, we can find a lower potential MSE.


> Ridge regression works best in situations for least squares estimates have high variance. Ridge regression is also much more computationally efficient that any subset method, since it is possible to simultaneously solve for all values of $\lambda$.

<div class="figure" style="text-align: center">
<img src="figs/rrContours.jpg" alt="A coordinate plane with beta 1 on the x-axis and beta 2 on the y-axis.  A blue disk around the origin represents the contraint region.  Red elipses show regions of constant SSE that are hoped to be minimized." width="265" />
<p class="caption">(\#fig:unnamed-chunk-5)The red contours represent pairs of $eta$ coefficients that produce constant values for SSE on the data.  The blue circle represents the possible values of $eta$ given the constraint (that the squared magnitude is less than some cutoff). Image credit: ISLR</p>
</div>


### Inference on Ridge Regression Coefficients

Note that just like the OLS coefficients, the RR coefficients are a linear combination of the $Y$ values based on the $X$ matrix and (now) $\lambda$.  It is not hard, therefore, to find the variance of the coefficient vector at a particular value of $\lambda$.  Additionally, the same theory that gives normality (and the resulting t-statistics) drives normality for the ridge regression coefficients.

$$var(b^{RR}) = \sigma^2 W X^t X W \mbox{ where } W = (X^t X + \lambda \mathtt{I})^{-1}$$

However, all the distributional properties above give theoretical results for a fixed value of $\lambda$.  We now discuss estimating $\lambda$, but as soon as we estimate $\lambda$, it becomes dependent on the data and thus a random variable.  That is, the SE of $b^{RR}$ is a function of not only the variability associated with the data estimating the coefficients but also the variability of the data estimating $\lambda$.  

An additional problem is that the RR coefficients are known to be biased, and the bias is not easy to estimate.  Without a sense of where the variable is centered, the SE isn't particularly meaningful.  For these reasons, functions like `lm.ridge()` in R do not include tests / p-values but do approximate the SE of the coefficients (as an estimate).



## How do you choose $\lambda$?

Note that $\lambda$ is a function of the data, and therefore a random variable to estimate (just like estimating the coefficients).  However, we can use diagnostic measures to give a sense of $\lambda$ values which will give a good variance-bias trade-off.

1. Split data into test and training, and plot test MSE as a function of $\lambda$.  
2. Actually cross validate the data (remove test samples in groups of, say 1/10, to see which $\lambda$ gives the best predictions on "new" data) and find $\lambda$ which gives the smallest MSE for the cross validated data.

******  
**Cross Validating to Find $\lambda$**  

******  
1.  Set $\lambda$  (e.g., try $\lambda$ between $10^{-2}$ and $10^{5}$: `lambda.grid = 10^seq(5,-2, length =100)`)
   a. Remove 1/10 of the observations (partition the data into 10 groups).
   b. Find the RR / Lasso model using the remaining 90% of the observations and the given value of $\lambda$. 
   c. Predict the response value for the removed points given the 90% training values.
   d. Repeat (a) - (c) until every point has been predicted as a test value.
2. Using the CV predictions, find $MSE_\lambda$ for the $\lambda$ at hand.
3. Repeat steps 1 and 2 across the grid of $\lambda$ values.
4. Choose the $\lambda$ value that minimizes the CV $MSE_\lambda$.






## Lasso

Ridge regression had at least one disadvantage; it includes all $p$ predictors in the final model. The penalty term will set many of them close to zero, but never exactly to zero. This isn't generally a problem for prediction accuracy, but it can make the model more difficult to interpret the results. Lasso overcomes this disadvantage and is capable of forcing some of the coefficients to zero granted that $\lambda$ is big enough. Since $\lambda = 0$ results in regular OLS regression, as $\lambda$ approaches $\infty$ the coefficients shrink towards zero.


### Lasso Coefficients

The lasso (least absolute shrinkage and selection operator) coefficients are calculated from a similar constraint to that of ridge regression, but the calculus is much harder now.  The L-1 norm is the only norm that gives sparsity and is convex (so that the optimization problem can be solved).  The lasso optimization equation seeks to minimize:

$$\sum_{i=1}^n \bigg( Y_i - b_0 - \sum_{j=1}^{p-1} b_j X_{ij} \bigg)^2 + \lambda \sum_{j=1}^{p-1} |b_j| = SSE + \lambda \sum_{j=1}^{p-1} |b_j|$$
where $\lambda \geq 0$ is a *tuning parameter*, to be determined separately.  As with ridge regression lasso optimization provides a trade-off between bias and variance.  Lasso seeks to find coefficients that fit the data well (minimize SSE!).   Additionally, lasso shrinks the coefficients to zero by adding a penalty so that smaller values of $b_j$ are preferred.    Note:  the shrinkage does not apply to the intercept!  The minimization quantities for ridge regression and lasso are extremely similar:  ridge regression constrains the sum of the squared coefficients; lasso constrains the sum of the absolute coefficients.  [As with ridge regression, we use standardized variables in modeling.]

### Lasso visually

As with ridge regression Lasso is also typically applied to situations with many many variables (also to avoid multicollinearity).  It doesn't make sense to apply it to a situation with only one or two variables.  However, we will demonstrate the process visually with p=3 dimensions because it is difficult to visualize in higher dimensions.  Notice here that there is a very good chance for the red contours to hit the turquoise square at a corner (producing some coefficients to be estimated as zero).  The corner effect becomes more extreme in higher dimensions.

The lasso coefficient estimates solve the following optimization problem:

$$ \min_\beta \Bigg\{ \sum_{i=1}^n \Bigg( Y_i - b_0 - \sum_{j=1}^{p-1} b_j X_{ij} \Bigg)^2 \Bigg\} \mbox{  subject to  } \sum_{j=1}^{p-1} |b_j| \leq s$$

<div class="figure" style="text-align: center">
<img src="figs/rrContours.jpg" alt="A coordinate plane with beta 1 on the x-axis and beta 2 on the y-axis.  A blue diamond around the origin represents the contraint region.  Red elipses show regions of constant SSE that are hoped to be minimized." width="265" />
<p class="caption">(\#fig:unnamed-chunk-8)The red contours represent pairs of $eta$ coefficients that produce constant values for SSE on the data.  The blue square represents the possible values of $eta$ given the constraint (that the absolute magnitude is less than some cutoff). Image credit: ISLR</p>
</div>

The key to lasso (in contrast to ridge regression) is that it does variable selection by shrinking the coefficients all the way to zero.  We say that the lasso yields *sparse* models - that is, only a subset of the original variables will be retained in the final model.

### How do you choose $\lambda$?

Note that $\lambda$ is a function of the data, and therefore a random variable to estimate (just like estimating the coefficients).  However, we can use diagnostic measures to give a sense of $\lambda$ values which will give a good variance-bias trade-off.

1. Split data into test and training, and plot test MSE as a function of $\lambda$.  
2. Actually cross validate the data (remove test samples in groups of, say 1/10, to see which $\lambda$ gives the best predictions on "new" data) and find $\lambda$ which gives the smallest MSE for the cross validated data.  




## Ridge Regression vs. Lasso

Quote from *An Introduction to Statistical Learning*, V2, page 246.

> These two examples illustrate that neither ridge regression nor the lasso will universally dominate the other. In general, one might expect the lasso to perform better in a setting where a relatively small number of predictors have substantial coefficients, and the remaining predictors have coefficients that are very small or that equal zero. Ridge regression will perform better when the response is a function of many predictors, all with coefficients of roughly equal size. However, the number of predictors that is related to the response is never known a priori for real data sets. A technique such as cross-validation can be used in order to determine which approach is better on a particular data set.

> As with ridge regression, when the least squares estimates have excessively high variance, the lasso solution can yield a reduction in variance at the expense of a small increase in bias, and consequently can generate more accurate predictions. Unlike ridge regression, the lasso performs variable selection, and hence results in models that are easier to interpret.

<div class="figure" style="text-align: center">
<img src="figs/fig68RRwins.jpg" alt="A coordinate plane with beta 1 on the x-axis and beta 2 on the y-axis.  A blue diamond around the origin represents the contraint region.  Red elipses show regions of constant SSE that are hoped to be minimized." width="649" />
<p class="caption">(\#fig:unnamed-chunk-10-1)From ISLR, pgs 245-246.  The data in Figure 6.8 were generated in such a way that all 45 predictors were related to the response.  That is, none of the true coefficients beta1,... , beta45 equaled zero. The lasso implicitly assumes that a number of the coefficients truly equal zero. Consequently, it is not surprising that ridge regression outperforms the lasso in terms of prediction error in this setting. Figure 6.9 illustrates a similar situation, except that now the response is a function of only 2 out of 45 predictors. Now the lasso tends to outperform ridge regression in terms of bias, variance, and MSE.</p>
</div><div class="figure" style="text-align: center">
<img src="figs/fig69lassowins.jpg" alt="A coordinate plane with beta 1 on the x-axis and beta 2 on the y-axis.  A blue diamond around the origin represents the contraint region.  Red elipses show regions of constant SSE that are hoped to be minimized." width="652" />
<p class="caption">(\#fig:unnamed-chunk-10-2)From ISLR, pgs 245-246.  The data in Figure 6.8 were generated in such a way that all 45 predictors were related to the response.  That is, none of the true coefficients beta1,... , beta45 equaled zero. The lasso implicitly assumes that a number of the coefficients truly equal zero. Consequently, it is not surprising that ridge regression outperforms the lasso in terms of prediction error in this setting. Figure 6.9 illustrates a similar situation, except that now the response is a function of only 2 out of 45 predictors. Now the lasso tends to outperform ridge regression in terms of bias, variance, and MSE.</p>
</div>



## Elastic Net

It is also possible to combine ridge regression and lasso through what is called *elastic net regularization*.  (The R package **glmnet** allows for the combined elastic net model.) The main idea is that the optimization contains both L-1 and L-2 penalties.  The model may produce more stable estimates of the coefficients but requires and additional tuning parameter to estimate.  That is, find the coefficients that minimize:

$$\sum_{i=1}^n \bigg( Y_i - b_0 - \sum_{j=1}^{p-1} b_j X_{ij} \bigg)^2 + \lambda \bigg[(1-\alpha)(\frac{1}{2})\sum_{j=1}^{p-1} b_j^2  + \alpha \sum_{j=1}^{p-1} |b_j| \bigg].$$


## <i class="fas fa-lightbulb" target="_blank"></i> Reflection Questions

1. How do ridge regression coefficient estimates differ from OLS estimates?  How are they similar?  
2. How do Lasso coefficient estimates differ from OLS estimates?  How are they similar?  
3. What is the difference between ridge regression and Lasso?  
4. What are some of the ways to find a good $\lambda$ for ridge regression?  
5. Why does the 1-norm regularization yield "sparse" solutions?  (What does "sparse" mean?)  
6. Give two different situations when ridge regression or Lasso are particularly appropriate.


## <i class="fas fa-balance-scale"></i> Ethics Considerations


## R: Ridge Regression and Lasso


%\textcolor{red}{EXAMPLES!!!!} -- look at the R plots that help us interpret the model, coefficients, and choice of $\lambda$

%\begin{verbatim}
%fit <- lm.ridge(lpsa~.,prostate,lambda=seq(0,50,by=0.1))
%R (unlike SAS, unfortunately) also provides the GCV criterion for each ?:
%fit$GCV
%\end{verbatim}


