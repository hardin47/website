# Sampling Distributions of Estimators {#sampdist}

A **statistic** is a function of some observed random variables.  The **sampling distribution** of a statistic tells us which values a statistic assumes and how likely those values are.  Because a statistic is a function of the random variables $X_1, X_2, \ldots, X_n$, if we know the distribution of $X$, in principle, we should be able to derive the distribution of our statistic.

::: {.example}
If the data are normal, the sampling distribution of their mean is also normal.  While the result may look like the Central Limit Theorem, there is no limiting behavior here.  That is, the sampling distribution of $\overline{X}$ is normal regardless of the sample size.  The proof come directly from the result that linear combinations of normal random variables are also normal.

\begin{eqnarray*}
X_i &\sim& N(\mu, \sigma^2)\\
\overline{X} &\sim& N(\mu, \sigma^2 / n)
\end{eqnarray*}
:::

## The Chi-Square Distribution

The chi-square distribution is a probability distribution with the following characteristics.

\begin{eqnarray*}
X &\sim& \chi^2_n\\
f_X(x) &=& \frac{1}{2^{n/2} \Gamma(n/2)} x^{n/2 -1} e^{-x/2} \ \ \ \ \ \ x > 0\\
E[X] &=& n\\
Var[X] &=& 2n\\
\psi_X(t) &=& \Bigg( \frac{1}{1-2t} \Bigg)^{n/2} \ \ \ \ \ \ t < 1/2\\
( &=&  E[e^{tX}] )\\
\end{eqnarray*}

Recall Moment Generating Functions $(\psi_X(t))$, @degroot page 205.

::: {.theorem}
@degroot 7.2.1

Let $X_1, X_2, \ldots X_k \sim \chi^2_{n_i}, \ \ i=1, \ldots, k$, independently.  Then, $X_1 + X_2 + \cdots + X_k = \sum_{i=1}^k X_i \sim \chi^2_{n_1+n_2 +\cdots+n_k}$.

That is, if the data are independent chi-square random variables, the sampling distribution of their sum is also chi-square.
:::


::: {.proof}

\begin{eqnarray*}
Y&=& \sum_{i=1}^k X_i\\
\psi_Y (t) &=& E[e^{Yt} ]\\
&=& E[e^{t \sum_{i=1}^k X_i}]\\
&=& \prod_{i=1}^k E[e^{tX_i}]\\
&=& \prod_{i=1}^k \psi_{X_i}(t)\\
&=& \prod_{i=1}^k \bigg( \frac{1}{1-2t} \bigg)^{ n_i /2}\\
&=& \Bigg( \frac{1}{1-2t} \Bigg)^{\sum n_i /2}
\end{eqnarray*}
See theorem 4.4.3, pg 207.
:::


::: {.theorem}
@degroot 7.2.1 1/2

If $Z \sim N(0,1), Y=Z^2,$ then $Y \sim \chi^2_1$.

Note that the result here is to provide the distribution of a transformation of a random variable.  There is a single data value $(Z)$, and the result provides the distribution of another single value, $(Y).$  The value $Y$ would typically not be referred to as a statistic because it is not a summary of observations.

That said, just below, $Z$ itself will be a statistic (instead of a single value) and then both $Z$ and $Y$ will have sampling distributions!
:::

::: {.proof}
Let $\Phi$ and $\phi$ be the cdf and pdf of Z.\\
Let F and f be the cdf and pdf of Y.\\
\begin{eqnarray*}
F(y) &=& P(Y \leq y) = P(Z^2 \leq y)\\
&=& P(-y^{1/2} \leq Z \leq y^{1/2})\\
&=& \Phi(y^{1/2}) -  \Phi(- y^{1/2})  \ \ \ \ \ y > 0\\
\end{eqnarray*}
\smallskip
\begin{eqnarray*}
f(y) &=& \frac{\partial F(y)}{\partial y} = \phi(y^{1/2}) \cdot \frac{1}{2} y^{-1/2} - \phi(-y^{1/2}) \cdot \frac{1}{2} -y^{-1/2}\\
&=& \frac{1}{2} y^{-1/2} ( \phi(y^{1/2}) + \phi(-y^{1/2})) \ \ \ \ \ \ y > 0\\
\mbox{we know} && \phi(y^{1/2}) = \phi(-y^{1/2}) = \frac{1}{\sqrt{2 \pi}} e^{-y/2}\\
%\therefore
f(y) &=& y^{-1/2} \frac{1}{\sqrt{2 \pi}} e^{-y/2} \ \ \ \ \ \ y > 0 \\
&=& \frac{1}{2^{1/2}\pi^{1/2}} y^{1/2 - 1} e^{-y/2} \ \ \ \ \ \ y >0\\
Y &\sim& \chi^2_1\\
\end{eqnarray*}
note: $\Gamma(1/2) = \sqrt{\pi}$.
:::



By combining Theorems 7.2.1 and 7.2.1 1/2, we get:

::: {.theorem}
@degroot 7.2.2

If $X_1, X_2, \ldots, X_k \stackrel{iid}{\sim} N(0,1)$,
\begin{eqnarray*}
\sum_{i=1}^k X_i^2 \sim \chi^2_k
\end{eqnarray*}
\noindent
Note: if $X_1, X_2, \ldots, X_k \stackrel{iid}{\sim} N(\mu, \sigma^2)$,
\begin{eqnarray*}
\frac{X_i - \mu}{\sigma} &\sim& N(0,1)\\
\sum_{i=1}^k \frac{(X_i - \mu)^2}{\sigma^2} &\sim& \chi^2_k\\
\end{eqnarray*}

If the data are $iid$ normal, the sum of their squared values has a sampling distribution which is chi-square.
:::


## Independence of the Mean and Variance of a Normal Random Variable


::: {.theorem}
@degroot 8.3.1

Let $X_1, X_2, \ldots, X_n \stackrel{iid}{\sim} N(\mu, \sigma^2)$.

1. $\overline{X}$ and $\frac{1}{n} \sum(X_i - \overline{X})^2$ are independent.  (This is **only** true for normal random variables.  You should read through the proof in your book.) 
2. $\overline{X} \sim N(\mu, \sigma^2/n)$.  (Not the CLT, why not?) 
3. $\frac{\sum(X_i - \overline{X})^2}{\sigma^2} \sim \chi^2_{n-1}$.  (Main idea is that we only have $n-1$ independent things.)
:::



## The t-distribution

Let $Z \sim N(0,1)$ and $Y \sim \chi^2_n$.  If $Z$ and $Y$ are independent, then:

::: {.definition}
\begin{eqnarray*}
X = \frac{Z}{\sqrt{Y/n}} \sim t_n \mbox{  by definition}
\end{eqnarray*}
:::

\begin{eqnarray*}
f(x) &=& \frac{\Gamma(\frac{n+1}{2})}{(n \pi)^{1/2} \Gamma(\frac{n}{2})} (1 + \frac{x^2}{n})^{-(n+1)/2} \ \ \ \ n > 2\\
E[X] &=&0\\
Var(X) &=& \frac{n}{n-2}
\end{eqnarray*}

Remember:
\begin{eqnarray*}
\frac{\overline{X} - \mu}{\sigma/\sqrt{n}} \sim N(0,1) \mbox{ independently of } \frac{\sum(X_i - \overline{X})^2}{\sigma^2} \sim \chi^2_{n-1}
\end{eqnarray*}

\begin{eqnarray*}
\frac{\frac{\overline{X} - \mu}{\sigma/\sqrt{n}}}{\sqrt{\frac{\sum(X_i - \overline{X})^2}{\sigma^2}/(n-1)}} &=& \frac{\overline{X} - \mu}{\sqrt{\frac{\sum(X_i - \overline{X})^2}{n-1}/n}}\\
&=& \frac{\overline{X} - \mu}{s/\sqrt{n}} \sim t_{n-1} !
\end{eqnarray*}

As stated above, the t-distribution is defined as the distribution which is given when a standard normal is divided by the square root of a chi-square random variable divided by its degrees of freedom.  And while that may seem obtuse at first glance, it comes in extremely handy when standardizing a sample mean by using the standard error (instead of the standard deviation) of the mean.


::: {.example}
According to some investors, foreign stocks have the potential for high yield, but the variability in their dividends may be greater than what is typical for American companies.   Let's say we take a random sample of 10 foreign stocks; assume also that we know the population distribution from which American stocks come (i.e., we have the American parameters).  If **we believe that foreign stock prices are distributed similarly  (normal with the same mean and variance)** to American stock prices, how likely is it that a sample of 10 foreign stocks would produce a standard deviation which is 50% bigger than American stocks?

\begin{eqnarray*}
P(\hat{\sigma} / \sigma > 1.5 ) &=& ?\\
\frac{\sum (X_i - \overline{X})^2}{\sigma^2} &\sim& \chi^2_{n-1} \ \ \ \ \mbox{(normality assumption)}\\
\frac{\sum (X_i - \overline{X})^2}{\sigma^2} &=& n\frac{\sum (X_i - \overline{X})^2/n}{\sigma^2}\\
&=& \frac{n \hat{\sigma^2}}{\sigma^2}\\
P(\hat{\sigma} / \sigma > 1.5 ) &=& P(\hat{\sigma}^2 / \sigma^2 > 1.5^2 ) \\
&=& P(n \hat{\sigma}^2 / \sigma^2 > n 1.5^2 )\\
&=& 1 - \chi^2_{n-1} (n 1.5^2)\\
&=& 1 - \chi^2_{n-1} (22.5)\\
&=& 1 - pchisq(22.5,9) = 0.00742 \ \ \ \mbox{ in R}
\end{eqnarray*}
:::

::: {.example}
Suppose we take a random sample of foreign stocks (both $\mu$ and $\sigma^2$ unknown).  Find the value of $k$ such that the sample mean is no more than $k$ sample standard deviations $(s)$ above the mean $\mu$ with probability 0.90.

\noindent
Data:  $n=10$, $\hat{\mu}  = \overline{x}$, $s^2 = \frac{\sum(x_i - \overline{x})^2}{n-1}$, $s = \sigma'$.

\begin{eqnarray*}
P(\overline{X} < \mu + k s) &=& 0.9\\
P\Bigg(\frac{\overline{X} - \mu}{s} < k \Bigg) = P\Bigg(\frac{\overline{X} - \mu}{s/\sqrt{n}} < k \sqrt{n}\Bigg) &=& 0.9\\
\frac{\overline{X} - \mu}{s / \sqrt{n}} &\sim& t_9\\
\sqrt{n} k &=& 1.383\\
k &=& \frac{1.383}{\sqrt{10}} = 0.437\\
\mbox{note, in R: } qt(0.9,9) &=& 1.383
\end{eqnarray*}

How would this problem have been different if we had known $\sigma$?  Or even if we had wanted the answer to the question in terms of number of population standard deviations?
:::


## <i class="fas fa-lightbulb" target="_blank"></i> Reflection Questions

1. 

## <i class="fas fa-balance-scale"></i> Ethics Considerations

1. 


## R code: Tanks Example

