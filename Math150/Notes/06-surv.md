# Survival Analysis



To motivate the technical details which are vital to understanding survival analysis, consider the following example [@gerds].

::: {.example}
In class -- experience the Titanic going down.

* The Titanic is sinking.  How long can you hold your breath?  
* Every person is sinking and will also be their own time keeper (number of seconds the sinker can hold their breath).  
* Because the Titanic is sinking slowly, the participants go under water asynchronously (i.e., at different times).  
* Accrual period will last about a minute.  
* When I say "stop" (about another minute), everyone should end their time clocks (this is the end of the follow-up period).  
* Each participant will have a recorded time as well as an indicator as to whether or not they have died.  
  

Based on the data, we would like to calculate:  
1. What is the probability of surviving 40 seconds?  
2. What is the median survival time?  
3. What is the average survival time?  
:::


\begin{eqnarray*}
& &\\
& & \\
\end{eqnarray*}

The next example is given in your text [@KuiperSklar (chapter 9)] as part of the motivation for survival analysis.

::: {.example}

Class chocolate melting activity 

* Each student should be randomly assigned to a white or milk chocolate chip (flip a coin)  
* When the instructor gives approval, students should place either a white or milk chocolate chip into their mouths and record the time until it completely melts.  
* Treat the study as if it could only be done for a specified period of time (this may require some experimenting, but 60 seconds has worked well).  If the actual time is less than 60 seconds, then the actual time will be complete.  The student should submit the data (chip color, actual time, censoring status); 1=observed, 0=censored. Any chips that are "swallowed" prior to 60 seconds should be regarded as censored.
:::

Survival analysis is typically done with a prospective study (see censoring below) on a cohort of patients (observational or experimental) to determine some clinical outcome.  We will also usually measure covariates of interest: treatment, clinical variables measured at recruitment, etc.

> **Key Point**: the outcome of interest (death, recurrence, etc.) may *not* occur


Possible responses:  

* Outcome of interest occurs  
* Study ends  
* The individual can no longer be measured (moves away, etc.)  
 
* **response** fate *and* length of follow-up  
* **data** suppose we are following n patients  
\begin{eqnarray*}
t_i &=& \mbox{time the } i^{th} \mbox{ has event of interest}\\
m(t) &=& \mbox{number of patients for whom } t_i > t \mbox{ (die later)}\\
d(t) &=& \mbox{number of patients for whom } t_i \leq t \mbox{ (die sooner)}\\
\end{eqnarray*}

## Time-to-event data {#timedata}


### Survival Function
The two main quantities of interest (i.e., *parameters*) are:

\begin{eqnarray*}
S(t) &=& P(T > t) = \mbox{ probability of surviving until after time } t\\
D(t) &=& P(T \leq t) = \mbox{ probability of dying by time } t (= F(t) )\\
\end{eqnarray*}
Where $T$ is a random variable representing the time to event; t is a number.


If $t_i$ is known for all i (no censoring), we can estimate $S(t)$ and $D(t)$ with
\begin{eqnarray*}
\hat{S}(t)_E &=& m(t)/n = \mbox{ proportion alive at time } t\\
\hat{D}(t)_E &=& d(t)/n = \mbox{ proportion who have died by time } t\\
\end{eqnarray*}

#### censoring

* **right** censoring: when the observation on an individual begins at a defined starting time and ends before the outcome of interest happens (this is the censoring for our model)  
* **left** censoring: when the outcome of interest is known to have occurred before the study begins (infection of a disease, learning to count).  Note that the event of interest *has happened*, unlike in right censoring where the event of interest has not happened.  
* **interval** censoring; when the event of interest is only known to have occurred between two time points, but the precise time is not known.


**Important Assumption**:  survival time must be independent of any mechanism which causes censoring (called non-informative censoring).  Censoring should be random:  a person who is censored has the same probability of dying as non-censored people at given explanatory variables $\underline{X}$.  

Said differently:  within any subgroup of interest, the subjects who are censored at time $t$ should be representative of all the subjects in that subgroup who remained at risk at time $t$ with respect to their survival experience.

* Not independent  
    * Subjects who drop out because they are extremely ill  
    * Subjects who drop out because of adverse effects of the treatment regimen  
* Independent  
    * Subjects who drop out because the study ends  
    * Subjects who drop out because they move away  

::: {.example}

Suppose we have the following melting times (in seconds) of milk chocolate chips for 7 students where the maximum time allowed for the experiment was 60 seconds:  


| Student |  1 |  2 |  3 |  4 |  5 |  6 |  7 |
|--------:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
|    Time | 35 | 30 | 60 | 45 | 25 | 55 | 30 |

To find the estimated proportion of chocolate chips that have not melted after 45 seconds we use the **empirical survival function**,  $\hat{S}(45)_E$.
\begin{eqnarray*}
\hat{S}(45)_E &=& \frac{\mbox{number of chips that have not melted after 45 seconds}}{\mbox{total number of chips in the sample}}\\
&=& 2/7 = 0.286\\
\hat{S}(t)_E &=& \frac{\mbox{number of individuals yet to experience the event at time } t}{\mbox{number of individuals in the study}}\\
&=& \frac{\mbox{number of event times greater than } t}{\mbox{number of individuals in the study}}\\
\end{eqnarray*}

What if some of the observations are incomplete (i.e., censored)?  

| Student 	| 1 	| 2 	| 3 	| 4 	| 5 	| 6 	| 7 	|
|--------:	|:------:	|:--:	|:------:	|:--:	|:--:	|:--:	|:------:	|
| Time 	| $35^+$ 	| 30 	| $60^+$ 	| 45 	| 25 	| 55 	| $30^+$ 	|
  
  
One way to deal with censored observations is to remove them from the study.  We would consider our sample to be only those observations that have complete information.  

| Student 	| 2 	| 4 	| 5 	| 6 	|
|--------:	|:--:	|:--:	|:--:	|:--:	|
| Time 	| 30 	| 45 	| 25 	| 55 	|

\begin{eqnarray*}
\hat{S}(45)_E &=& \frac{\mbox{number of chips that have not melted after 45 seconds}}{\mbox{total number of chips in the sample}}\\
&=& 1/4 = 0.25\\
\end{eqnarray*}
:::


By treating censored observations as complete, we assume that the event times are shorter than what they actually are (thereby underestimating the true probability of survival).  By removing the censored observations from the data, we lose information.  By treating censored observations as complete we bias the estimate based on the remaining times; by ignoring censored observations, we reduce the power of the inferential model.

## Kaplan-Meier Curves {#KM}

When a data set contains incomplete observations, the best estimator of the survival function is the Kaplan-Meier estimator, $\hat{S}(t)_{KM}$.  We'll create a few curves by hand, and then we'll let R make them for us.

\begin{eqnarray*}
t_1 < t_2 < \cdots < t_n & & \mbox{are the ordered completed times}\\
n_i &=& \mbox{number of patients known to be at risk at time (day) } t_i, \mbox{ just before } [t_i, t_{i+1})\\
d_i &=& \mbox{number of patients who die at time (day) } t_i, \mbox{ in } [t_i, t_{i+1})\\
\end{eqnarray*}

\noindent
For the patients alive at the beginning of the $t_i^{th}$ time, the probability of surviving that time is \begin{eqnarray*}
p_i = \frac{n_i - d_i}{n_i}
\end{eqnarray*}
The probability that a patient survives to time 2 given that they survived to time 1 is
\begin{eqnarray*}
p_2 = \frac{n_2 - d_2}{n_2}
\end{eqnarray*}
The probability that (at the outset) a patient survives to time 2 is:
\begin{eqnarray*}
P(T > t_2) &=& P(T > t_2 | T > t_1) P(T > t_1)\\
&=& \frac{n_1 - d_1}{n_1} \frac{n_2 - d_2}{n_2}
\end{eqnarray*}
The probability of surviving the first t days is:
\begin{eqnarray*}
\hat{S}(t)_{KM} &=& \prod_{i:t_i < t} \frac{n_i - d_i}{n_i}\\
&=& \prod_{i:t_i < t} p_i\\
\hat{D}(t)_{KM} = 1 - \hat{S}(t)_{KM}\\
\end{eqnarray*}
If there are no deaths at time $t_i$, then $(n_i -d_i) / n_i = 1$.  


If there is no censoring at time $t_i$, then $n_i - d_i = n_{i+1}$.  The Kaplan-Meier survival curve will be equivalent to the empirical survival curve:

\begin{eqnarray*}
\hat{S}(t)_{KM} &=& \prod_{i:t_i < t} \frac{n_i - d_i}{n_i}\\
&=& \frac{n_1 - d_1}{n_1} \frac{n_2 - d_2}{n_2} \cdots \frac{n_k - d_k}{n_k}\\
&=& \frac{m(t)}{n}
\end{eqnarray*}

::: {.example}
milk chocolate times by hand.


| $t_i$ 	| $n_i$ 	| $d_i$ 	| $n_i - d_i$ 	| $\frac{n_i - d_i}{n_i}$ 	|
|:-----:	|:-----:	|:-----:	|:-----------:	|:-----------------------:	|
| 25 	| 7 	| 1 	| 6 	| 6/7= 0.857 	|
| 30 	| 6 	| 1 	| 5 	| 5/6 = 0.833 	|
| 35 	| 4 	| 0 	| 4 	| 4/4 = 1 	|
| 45 	| 3 	| 1 	| 2 	| 2/3 = 0.667 	|
| 55 	| 2 	| 1 	| 1 	| 1/2=0.5 	|
| 60 	| 1 	| 0 	| 1 	| 1/1=1 	|

| time interval 	| $\hat{S}(t)_{KM}$ 	|
|:-------------:	|:---------------------------:	|
| $[0,25)$ 	| 1 	|
| $[25,30)$ 	| 0.857 	|
| $[30, 35)$ 	| 0.857 $\cdot$ 0.833 = 0.714 	|
| $[35,45)$ 	| 0.714 $\cdot$ 1 = 0.714 	|
| $[45,55)$ 	| 0.714 $\cdot$ 0.667 = 0.476 	|
| $[55,60)$ 	| 0.476 $\cdot$ 0.5 = 0.238 	|
:::


### CI for KM curve {#KMCI}

Recall: $\hat{S}(t)_{KM} = \prod_{k:t_k < t} [ (n_k - d_k) / n_k]$.

Because $\hat{S}(t)_{KM}$ is just a product of counts, we can "easily" estimate the SE:
\begin{eqnarray*}
s^2 _{\hat{S}(t)_{KM}} = \hat{S}(t)_{KM}^2 \sum_{k:t_k < t} \frac{d_k}{n_k(n_k - d_k)}
\end{eqnarray*}

Your book uses the above SE and normal theory which does work, particularly with large sample sizes.  However, with smaller sample sizes and at the ends of the survival curve (close to zero or one), the sampling distribution of the estimated KM curve will not be normal.  Additionally if we try to apply normal theory, we'll get something meaningless because the CI will go outside the bounds of 0 and 1.  Fortunately, someone figured out a transformation for us!

$l l \hat{S}(t) = \ln (-\ln \hat{S}(t)_{KM})$ has a much more normal sampling distribution than the sampling distribution of the untransformed estimator $\hat{S}(t)_{KM}$.


\begin{eqnarray*}
\hat{\sigma}^2(t) &=& SE( l l \hat{S}(t))\\
&=& \frac{\sum_{k:t_k < t} \frac{d_k}{n_k(n_k - d_k)}}{\bigg[\sum_{k:t_k < t} \ln ( (n_k - d_k) / n_k) \bigg]^2}
\end{eqnarray*}

A 95  % CI for $\ln ( -\ln S(t))$ is
\begin{eqnarray*}
ll\hat{S}(t) \pm 1.96 \hat{\sigma}(t) \ \ \ \mbox{(a function of t!!!)}
\end{eqnarray*}

A 95  % CI for $S(t)$ is
\begin{eqnarray*}
\bigg(\hat{S}(t)_{KM}^{ \exp(1.96\hat{\sigma}(t))}, \hat{S}(t)_{KM}^{\exp(-1.96\hat{\sigma}(t))} \bigg)
\end{eqnarray*}

We can also find a CI for $D(t) = 1- S(t)$ using:
\begin{eqnarray*}
\bigg(1 - \hat{S}(t)_{KM}^{\exp(-1.96\hat{\sigma}(t))}, 1 - \hat{S}(t)_{KM}^{\exp(1.96\hat{\sigma}(t))} \bigg)
\end{eqnarray*}

#####  Derivation of the above confidence intervals.  {-}

Remember that $\exp(a \cdot b) = (\exp(a))^b$, we'll need that below.  A CI is an interval of values that captures the true parameter in 95 of samples.  Let's say that the complementary log-log interval from above happens to catch the true value of $S(t)$.  Then, 

\begin{eqnarray*}
ll\hat{S}(t) - 1.96 \hat{\sigma}(t) \leq & llS(t) & \leq ll\hat{S}(t) + 1.96 \hat{\sigma}(t) \\
\exp(ll\hat{S}(t) - 1.96 \hat{\sigma}(t)) \leq & -lS(t) & \leq \exp(ll\hat{S}(t) + 1.96 \hat{\sigma}(t)) \\
-l\hat{S}(t)\exp(- 1.96 \hat{\sigma}(t))\leq & -lS(t) & \leq -l\hat{S}(t)\exp(1.96 \hat{\sigma}(t)) \\
l\hat{S}(t)\exp(- 1.96 \hat{\sigma}(t))\geq & lS(t) & \geq l\hat{S}(t)\exp(1.96 \hat{\sigma}(t)) \\
l\hat{S}(t)\exp(1.96 \hat{\sigma}(t))\leq & lS(t) & \leq l\hat{S}(t)\exp(-1.96 \hat{\sigma}(t)) \\
\exp(l\hat{S}(t)\exp(1.96 \hat{\sigma}(t))) \leq & S(t) & \leq \exp(l\hat{S}(t)\exp(-1.96 \hat{\sigma}(t))) \\
\exp(l\hat{S}(t))^{\exp(1.96 \hat{\sigma}(t))} \leq & S(t) & \leq \exp(l\hat{S}(t))^{\exp(-1.96 \hat{\sigma}(t))} \\
(\hat{S}(t))^{\exp(1.96 \hat{\sigma}(t))} \leq & S(t) & \leq (\hat{S}(t))^{\exp(-1.96 \hat{\sigma}(t))}
\end{eqnarray*}

#### Mean and Median values

**Mean**    

> Mean survival time is estimated as the area under the survival curve. The estimator is based upon the entire range of data. Some software uses only the data up to the last observed event [@SurvHL] point out that this biases the estimate of the mean downwards, and they recommend that the entire range of data be used. A large sample method is used to estimate the variance of the mean survival time and thus to construct a confidence interval [@Andersen]. [@KMmean]

In some ways, it is easier to conceptualize the mean as the average under the curve by thinking about calculating average as horizontal bars instead of vertical bars. The jumps along the y-axis are approximately 1/n, so each horizontal bar represents one of the individual deaths.  See the example here: http://blog.data-miners.com/2010/06/why-is-area-under-survival-curve-equal.html

\begin{eqnarray*}
\hat{\mu} = \left\{
    \begin{array}{ll}
    \sum_{i=0}^{m-1} \hat{S}(t_i)_{KM} (t_{i+1} - t_i) & \mbox{if } t_n = t_m  \mbox{ (last obs is complete)}\\
    \sum_{i=0}^{m-1} \hat{S}(t_i)_{KM} (t_{i+1} - t_i) + \hat{S}(t_m)_{KM}(t_n-t_m) & \mbox{if last obs is censored}
    \end{array}
\right.
\end{eqnarray*}

Each entry can be rearranged to be thought of as the proportion of people who die in the interval times the width of the interval: $[\hat{S}(t_{i-1})_{KM} - \hat{S}(t_{i})_{KM}]t_i$.  The difference, $[\hat{S}(t_{i-1})_{KM} - \hat{S}(t_{i})_{KM}]$, gives the proportion of individuals who die in that time interval.  Therefore, our estimate is a weighted average of the time points $t_i$ where the weight is $[\hat{S}(t_{i-1})_{KM} - \hat{S}(t_{i})_{KM}]$.   

\begin{eqnarray*}
\hat{\mu} &=& \sum_{i=0}^{m-1} \hat{S}(t_i)_{KM}(t_{i+1} - t_i)\\
&=& \hat{S}(t_0)_{KM}(t_1 - t_0) + \hat{S}(t_1)_{KM}(t_2 - t_1) + \hat{S}(t_2)_{KM} (t_3 - t_2) + \cdots + \hat{S}(t_{m-1})_{KM} (t_m - t_{m-1}) \\
&=& -t_0  \hat{S}(t_0)_{KM} + t_1 ( \hat{S}(t_0)_{KM} -  \hat{S}(t_1)_{KM}) + \cdots + t_{m-1}( \hat{S}(t_{m-2})_{KM} -  \hat{S}(t_{m-1})_{KM}) + t_m  \hat{S}(t_{m-1})_{KM}\\
&=& 0 + t_1 ( \hat{S}(t_0)_{KM} -  \hat{S}(t_1)_{KM}) + \cdots + t_{m-1}( \hat{S}(t_{m-2})_{KM} -  \hat{S}(t_{m-1})_{KM}) + t_m ( \hat{S}(t_{m-1})_{KM} - 0)\\
&=& \mbox{a weighted average of the times}
\end{eqnarray*}

**Median**  
Since the distribution of survival times tend to be positively skewed, the median is often the preferred summary measure of location of the distribution.  Once the survivor function has been estimated, it is straightforward to obtain an estimate of the *median survival time*.  That is, the time beyond which 50  % of the individuals in the population under study are expected to survive, and is given by the value $t_{(50)}$ such that $S(t_{(50)}) = 0.5$.

\begin{eqnarray*}
\hat{t}_{(p)} = \mbox{smallest complete event time, } t_i, \mbox{ in the sample such that } \hat{S}(t_i)_{KM} \leq 1-p/100
\end{eqnarray*}

$\hat{S}(t_i)_{KM}$ then gives the time at which at least p  % of events have occurred.  There are also ways of compute confidence intervals for percentiles.  We won't cover those here.



### Log-rank Test {#logrank}

As before, we'd like to know if two treatments produce the same probability of survival (how did we do that with logistic regression?  significance of the $\beta$ coefficient).  Here:
\begin{eqnarray*}
H_0: && S_1(t) = S_2(t) \ \ \ \ \ \forall t \mbox{ parameters!}\\
H_1: && S_1(t) \ne S_2(t) \ \ \ \ \ \mbox{ for some } t\\
\end{eqnarray*}

We want to test whether the curves are the same over all $t$ (or different at any $t$).  Let's consider a particular time, the $j^{th}$ time point:

| died 	| $d_{1j}$ 	| $d_{2j}$ 	| $D_j$ 	|
|---------:	|:-----------------:	|:-----------------:	|-------------	|
| survived 	| $n_{1j} - d_{1j}$ 	| $n_{2j} - d_{2j}$ 	| $N_j - D_j$ 	|
|  	| $n_{1j}$ 	| $n_{2j}$ 	| $N_j$ 	|

Because it's a $2x2$ table with fixed margins, we only need to consider one group.  If survival is similar for the two groups, we'd expect:
\begin{eqnarray*}
d_{ij} &\approx& \frac{D_j}{N_j}n_{1j}\\
d_{ij} &=& \mbox{observed}\\
\frac{D_j}{N_j} n_{1j} &=& E(d_{1j} | D_j) \\
var(d_{ij}) &=& \frac{n_{1j} n_{2j} D_j (N_j - D_j)}{N_j^2(N_j-1)}\\
\end{eqnarray*}
where the variance is derived from the hypergeometric distribution.

To estimate the overall difference between the observed and expected death counts:
\begin{eqnarray*}
\sum_j d_{1j} - \sum_j E(d_{1j} | D_j) = \sum_j d_{1j} - \sum_j \frac{D_j}{N_j}n_{1j}
\end{eqnarray*}
The overall variability:
\begin{eqnarray*}
\sum_j var(d_{1j}|D_j)
\end{eqnarray*}
The test statistic we use to compare the observed and expected frequency of deaths.  (Sum over all of the death (or recurrence) times.)
\begin{eqnarray*}
T = \frac{(|\sum_j d_{1j} - \sum_j E(d_{1j} | D_j)| - 0.5)^2}{\sum_j var(d_{1j}|D_j)} \sim \chi^2_1
\end{eqnarray*}


What if we had had $g$ groups (instead of 2)?  We'll have $g-1$ "death" values.  Consider the test statistic above, call it $T_1$.  We want to sum $T_i, i=1,2, \ldots, g-1$, but the variances are now correlated (values have to sum to $D_k$)... so the whole thing is slightly more complicated.  [@Collett(section 2.6)]

* The Wilcoxon test is very similar to the log-rank test, but it uses a different derivation for the variance, and therefore a different denominator and test statistic.  
* The log-rank test is more powerful than the Wilcoxon, but the log-rank test requires the proportional hazards assumption.  
* Wilcoxon test does not require the proportional hazards assumption, but it does require that one curve is always bigger than the other.  
* Neither work if the curves cross.  
* Other technical conditions are that the sample size should be "big enough."  The sample size is dependent on the number of deaths.  No specific criteria, but the results are asymptotic, so the p-values converge to the actual probabilities as the number of deaths gets larger.  


## Hazard Functions  {#hazfunc}

Another important idea in survival analysis is the hazard function or instantaneous death rate.  Let T be the random variable representing death time.  [Your text implicitly redefines $S(t) = P(T \geq t)$ which is inconsistent but not fundamentally problematic.]

\begin{eqnarray*}
h(t)&=& \lim_{\Delta t \rightarrow 0} \frac{P(\mbox{patient dies by time } t + \Delta t | \mbox{alive at } t)}{\Delta t}\\
 &=& \lim_{\Delta t \rightarrow 0} \frac{P(T < t + \Delta t | T \geq t)}{\Delta t}\\
 &=& \lim_{\Delta t \rightarrow 0} \frac{P(t \leq T < t + \Delta t | T \geq t)}{\Delta t}\\
 &=& \lim_{\Delta t \rightarrow 0} \frac{P(t \leq T < t + \Delta t )}{P(T \geq t) \Delta t}\\
 &=& \lim_{\Delta t \rightarrow 0} \frac{S(t) - S(t + \Delta t)}{S(t) \Delta t}\\
 &=& \lim_{\Delta t \rightarrow 0} -\frac{S(t + \Delta t) - S(t)}{\Delta t}\frac{1}{S(t)}\\
 &=& -S'(t) \frac{1}{S(t)}\\
 &=& -\frac{d}{dt} \ln(S(t))\\
S(t) &=& \exp \{ - \int^t_0 h(x) dx  \}\\
\end{eqnarray*}



How do different functions of $h$ affect the survival curve, $S$?
\begin{eqnarray*}
h(t) = 0 &&\Rightarrow \mbox{ no risk of death at time } t\\
&& \Rightarrow S(t) \mbox{ is flat at } t\\
h(t)  > >&&  \Rightarrow S(t) \mbox{ is rapidly declining in } t\\
h(t) =k && \Rightarrow S(t) = e^{-kt}
\end{eqnarray*}


#### hazard function as a constant
If $h(t) =k \rightarrow S(t) = e^{-kt}$.

Plots of different hazard functions and their corresponding survival functions.
<img src="06-surv_files/figure-html/unnamed-chunk-2-1.png" width="80%" style="display: block; margin: auto;" />


### Estimating $h(t)$ ala Kaplan-Meier

$h(t)$ is the rate at which individuals in the population experience the event in the next *instant* of time, conditional on surviving to time $t$.  The estimated hazard curve can only extend to the last complete event time, otherwise the denominator is infinitely large.  Also, keep in mind that $h(t)$ is very hard to estimate, and $\hat{h}_{KM}(t)$ can be erratic.

\begin{eqnarray*}
\hat{P}(t_i \leq T < t_{i+1} | T \geq t_i) &=& \frac{d_i}{n_i} = \hat{p}_i\\
\hat{h}_{KM}(t) &=& \frac{\hat{p}_i}{t_{i+1} - t_i}  \ \ \ \ \ \ t_{i+1} \leq t < t_i\\
\end{eqnarray*}

### Proportional Hazards
Suppose that $h_0(t)$ and $h_1(t)$ are the hazard functions for patients on control and experimental treatments.  The two groups have {\sc proportional hazards} if $h_1(t) = R h_0(t)$ for some constant R:
\begin{eqnarray*}
\frac{h_1(t)}{h_0(t)} = R \ \ \ \ \ \forall t
\end{eqnarray*}
R is called the **hazard ratio**.  $h_0(t)$ can be anything as long as $h_1(t)$ is proportional.  Note in the pictures below that no one dies between 3 and 7 days, the survival curves are flat over that interval.


<img src="06-surv_files/figure-html/unnamed-chunk-3-1.png" width="80%" style="display: block; margin: auto;" />

Consider the notion of risk of death:
\begin{eqnarray*}
\mbox{risk of death by } t + \Delta t \mbox{ given alive at } t= \left\{
    \begin{array}{ll}
   h_0(t) \Delta t & \mbox{control}\\
   h_1(t) \Delta t & \mbox{experiment}
   \end{array}
\right.
\end{eqnarray*}

\begin{eqnarray*}
\frac{\mbox{risk of dying for experim}}{\mbox{risk of dying control}} = \frac{h_1(t) \Delta t}{h_0(t) \Delta t} = \frac{h_1(t) }{h_0(t) } = R
\end{eqnarray*}

Ratio of hazard functions can be thought of as the \underline{instantaneous relative risk} (i.e., at a time $t$).


### Cox PH Regression Analysis {#coxph}

#### Simple proportional hazards model

ASSUMING proportional hazards!  Let $h_0(t)$ be the hazard function for the control group.  $x_i$ =1 if the $i^{th}$ patient receives treatment; 0 if the $i^{th}$ patient receives the control.  A big value of $\beta$ means that the event is more likely to happen.

\begin{eqnarray*}
h_i(t) &=& h_0(t) e^{\beta x_i} = \left\{
\begin{array}{ll}
h_0(t) e^\beta & \mbox{experim}\\
h_0(t) & \mbox{control}
\end{array}
\right.\\
\mbox{inst. RR} &=& \frac{h_0(t) e^\beta}{h_0(t)} = e^\beta\\
S_i(t) &=& (S_0(t))^{e^\beta}\\
\end{eqnarray*}

We don't yet know how to run this model and estimate the parameters, but still, we can probably do it.  Right?  We run a **Cox proportional hazards model**, get $b$, and estimate the RR using: $\hat{RR} = e^{b}$!  It turns out that for large samples (as with logistic regression, the CI and tests below are again called Wald CI and tests),

\begin{eqnarray*}
b \sim N: && \\
&& 95\% \mbox{ CI for } \beta: b \pm 1.96 SE(b)\\
&& 95\% \mbox{ CI for } RR: (e^{b - 1.96 SE(b)}, e^{b + 1.96 SE(b)})\\
\end{eqnarray*}

And we can test RR by using $\beta$:
\begin{eqnarray*}
H_0:&& \beta=0 \iff RR = 1\\
Z &=& \frac{b - 0 }{SE(b)}
\end{eqnarray*}

#### Estimating the proportional hazards coefficients

The main point of proportional hazards is that if we have proportional hazards, then we don't actually need to know the hazard function in order to estimate the coefficients which affect the survival function.  [We divide out the hazard function.]  

Intervals between death times convey no information about the relationship between hazard and explanatory variables (including treatment).  We are also assuming that we have no ties for our death times.  [Importantly, we assume that the proportional hazards assumption holds over *all* $t$.]

\begin{eqnarray*}
P(i^{th} \mbox{ indiv, w/}x_i, \mbox{ dies at } t_i | \mbox{one death at } t_i) &=& \frac{P(i^{th} \mbox{ indiv w/}x_i \mbox{ dies at } t_i )}{P(\mbox{at least one death at } t_i)}\\
&=& \frac{\mbox{hazard at } t_i}{\mbox{sum over all patients at risk at time } t_i}\\
&=& \frac{h_i(t_i)}{\sum_{k:t_k \geq t_i} h_k (t_i)} \\
&=& \frac{e^{\beta x_i}}{\sum_{k:t_k \geq t_i} e^{\beta x_k}}
\end{eqnarray*}

As with logistic regression (and linear regression!) we'll use maximum likelihood to estimate the parameter(s). (The product is over only patients who have death times recorded, not censored times).

\begin{eqnarray*}
L(\beta) &=& \prod_{i=1}^r \frac{e^{\beta x_i}}{\sum_{k:t_k \geq t_i} e^{\beta x_k}}\\
\delta_i &=& \left\{\begin{array}{ll}
1 & \mbox{death}\\
0 & \mbox{censored}
\end{array}
\right.\\
L(\beta) &=&  \prod_{i=1}^n \Bigg( \frac{e^{\beta x_i}}{\sum_{k:t_k \geq t_i} e^{\beta x_k}} \Bigg)^{\delta_i}\\
\ln L(\beta) &=& \sum_{i=1}^n \delta_i \bigg[ \beta x_i - \ln (\sum_{k:t_k \geq t_i} e^{\beta x_k}) \bigg]
\end{eqnarray*}
$b$ is found using numerical methods (as it was with logistic regression).  

::: {.example}
Consider the following data from a prostate cancer study.  The study was performed as a randomized clinical trail to compare treatments for prostatic cancer, and was begun in 1967 by the Veteran's Administration Cooperative Urological Research Group.  The trial was double blind and two of the treatments used were a placebo and 1.0 mg of diethylstilbestrol (DES).  The time origin of the study is the date on which a patient was randomized to a treatment, and the end-point is the death of the patient from prostate cancer.  The full data set is given in @AndHerz, but the data used in this example are from patients presenting with Stage III cancer and given in @Collett (page 8).



```r
library(survival)
prostate <- readr::read_csv("PROSTATE.csv")
head(prostate)
#> # A tibble: 6 x 7
#>   Treatment  Time Status   Age  Haem  Size Gleason
#>       <dbl> <dbl>  <dbl> <dbl> <dbl> <dbl>   <dbl>
#> 1         1    65      0    67  13.4    34       8
#> 2         2    61      0    60  14.6     4      10
#> 3         2    60      0    77  15.6     3       8
#> 4         1    58      0    64  16.2     6       9
#> 5         2    51      0    65  14.1    21       9
#> 6         1    51      0    61  13.5     8       8

coxph(Surv(Time,Status) ~ Treatment, data = prostate)
#> Call:
#> coxph(formula = Surv(Time, Status) ~ Treatment, data = prostate)
#> 
#>           coef exp(coef) se(coef)  z    p
#> Treatment -2.0       0.1      1.1 -2 0.07
#> 
#> Likelihood ratio test=5  on 1 df, p=0.03
#> n= 38, number of events= 6

coxph(Surv(Time,Status) ~ Treatment, data = prostate) %>% tidy()
#> # A tibble: 1 x 5
#>   term      estimate std.error statistic p.value
#>   <chr>        <dbl>     <dbl>     <dbl>   <dbl>
#> 1 Treatment    -1.98      1.10     -1.80  0.0717
coxph(Surv(Time,Status) ~ Treatment, data = prostate) %>% glance()
#> # A tibble: 1 x 18
#>       n nevent statistic.log p.value.log statistic.sc p.value.sc statistic.wald
#>   <int>  <dbl>         <dbl>       <dbl>        <dbl>      <dbl>          <dbl>
#> 1    38      6          4.55      0.0329         4.42     0.0355           3.24
#> # … with 11 more variables: p.value.wald <dbl>, statistic.robust <dbl>,
#> #   p.value.robust <dbl>, r.squared <dbl>, r.squared.max <dbl>,
#> #   concordance <dbl>, std.error.concordance <dbl>, logLik <dbl>, AIC <dbl>,
#> #   BIC <dbl>, nobs <int>
```

* **Note 1**: There is no intercept in the model.  The intercept is contained within the $h_0(t)$ parameter.  
* **Note 2**: Nowhere have we made any assumptions about the form of $h_0(t)$.  
* **Note 3**: To estimate $h_0(t)$, we use the pointwise values, just like Kaplan-Meier plots ($\tau_j = t_{(j+1)} - t_j):$
    \begin{eqnarray*}
    h_0(t_j) = \frac{d_j}{n_j \tau_j}
    \end{eqnarray*}
If there are covariates, the estimation gets much more complicated.  
* **Note 4**: The logrank statistic can be derived as the score test for the Cox proportional hazards model comparing two groups.  It is therefore approximately equivalent to the likelihood ratio test statistics from that model [@Collett (section 3.9, page 102-106)].  Additionally, the log-rank test is most powerful against the alternative that the hazard of death at any given time for an individual in one group is proportional to the hazard at that time for a similar individual in the other group (i.e., the proportional hazards assumption).  [@Collett (section 2.5.4, pg 44-45)]
    \begin{eqnarray*}
    H_0: h_1(t) = h_2(t)\\
    H_1: h_1(t) = R h_2(t)
    \end{eqnarray*}

* **Note 5**: You need proportional hazards to do the *inference*  (otherwise your p-values are meaningless!).  The technical assumptions for the Cox Proportional Hazards model are:  
    * Observations are independent  (this is almost always an important assumption in all of statistical inference)  
    * Proportional hazards:  the hazard ratios are not dependent on time.  
    * Independent censoring: the censored observations have the same survival prospects as the non-censored participants.  
:::


#### Cox PH Multiple Regression Analysis  {#multcoxph}

Extending the simple proportional hazards model to include multiple covariates.

Let $x_{i1}, x_{i2}, \ldots, x_{iq}$ be the $q$ covariates for person $i$.  We define the baseline hazard as:
\begin{eqnarray*}
h_0(t) &=& \mbox{hazard for patients with covariates } x_{i1}=x_{i2}=\cdots=x_{iq} = 0\\
h_i(t) &=& h_0(t) e^{\beta_1 x_{i1} + \beta_2 x_{i2} + \cdots + \beta_q x_{iq}}\\
\end{eqnarray*}
is the hazard function for the $i^{th}$ patient.

As before, we can consider nested models and compare their likelihoods.
\begin{eqnarray*}
-2 \ln \frac{L_{\mbox{reduced model}}}{L_{\mbox{full model}}} &\sim& \chi^2_{\Delta p}\\
&& \\
2 ( \ln L_{\mbox{full model}} - \ln L_{\mbox{reduced model}} ) &=& \mbox{test stat}\\
\end{eqnarray*}


::: {.example}

**Framingham Heart Study** [@Dupont (section 3.10)] Long-term follow-up and cardiovascular risk factor data on almost 5000 residents of the town of Framingham, MA.  Recruitment started in 1948 (went for 40+ years).  These data are 4699 patients who were free of coronary heart disease at their baseline exam:
  
| variable |  |  code          |  
|----------	|:-:	|--------------------------------------------------------	|
| sex 	| = 	| gender coded as 	|
|  	|  	| 1=if subject is male 	|
|  	|  	| 0= if subject is female 	|
| sbp 	| = 	| systolic blood pressure (SBP) in mm Hg 	|
| dbp 	| = 	| diastolic blood pressure (DBP) in mm Hg 	|
| scl 	| = 	| serum cholesterol (SCL) in mg/100ml 	|
| chdfate 	| = 	| 1= if the patient develops CHD at the end of follow-up 	|
|  	|  	| 0= otherwise 	|
| followup 	| = 	| the subject's follow-up in days 	|
| age 	| = 	| age in years 	|
| bmi 	| = 	| body mass index (BMI) =weight/height$^2$ in kg/m$^2$ 	|
| month 	| = 	| month of year in which baseline exam occurred 	|
| id 	| = 	| a patient identification variable (numbered 1 to 4699) 	|
  
We look at the K-M survival curves broken down by diastolic blood pressure.   The logrank statistic comparing all 7 groups is highly significant ($p < 10^{-52}$), and the pairwise logrank tests for adjacent pairs of risk groups are also all significant (though be careful with multiple comparisons!).
:::



```r
heart <- readr::read_csv("framingham.csv")

heart <- heart %>% 
  mutate(dbpf = case_when(
    dbp <= 60 ~ "under60",
    dbp <=70 ~ "60-70",
    dbp <= 80 ~ "70-80",
    dbp <=90 ~ "80-90",
    dbp <=100 ~ "90-100",
    dbp <=110 ~ "100-110",
    TRUE ~ "over110")) %>%
  mutate(dbpf = factor(dbpf,
                       levels = c("under60", "60-70", "70-80","80-90", "90-100","100-110","over110")),
         sex = case_when(
           sex == 1 ~ "male", 
           TRUE ~ "female"))
```

\begin{eqnarray*}
dbp_{ij} &=& \left\{
\begin{array}{ll}
1 & \mbox{if the } i^{th} \mbox{ patient is in DBP group } j\\
0 & \mbox{otherwise}
\end{array}
\right.\\
male_i &=& \left\{
\begin{array}{ll}
1 & \mbox{if the } i^{th} \mbox{ patient is male}\\
0 & \mbox{if the } i^{th} \mbox{ patient is female}\\
\end{array}
\right.\\
\end{eqnarray*}

* **Table 7.1**  
Using a proportional hazards model for estimating the hazard ratio associated with each blood pressure group, we get:
\begin{eqnarray*}
h_i(t) &=& h_0(t) \exp \bigg\{ \beta_2 dbp_{i2} + \beta_3 dbp_{i3} + \beta_4 dbp_{i4} + \beta_5 dbp_{i5} + \beta_6 dbp_{i6} + \beta_7 dbp_{i7} \bigg\}\\
h_i(t) &=& h_0(t) \exp \bigg\{ \sum_{j=2}^7 \beta_j dbp_{ij} \bigg\}
\end{eqnarray*}

We can use the model with dbp as categorical to check whether dbp could be used as a continuous variable.  Indeed, it seems that the model is linear (in ln(HR)) with respect to dbp.  One reason, however, to keep the variable broken into groups is because of the way the results are nicely laid out for each group.


```r
coxph(Surv(followup,chdfate) ~ dbpf, data = heart) %>% tidy()
#> # A tibble: 6 x 5
#>   term        estimate std.error statistic  p.value
#>   <chr>          <dbl>     <dbl>     <dbl>    <dbl>
#> 1 dbpf60-70      0.677     0.247      2.74 6.11e- 3
#> 2 dbpf70-80      0.939     0.241      3.90 9.56e- 5
#> 3 dbpf80-90      1.12      0.241      4.64 3.54e- 6
#> 4 dbpf90-100     1.51      0.243      6.22 4.97e-10
#> 5 dbpf100-110    1.84      0.254      7.23 4.86e-13
#> 6 dbpfover110    2.25      0.271      8.29 1.18e-16
```

* **Table 7.2**  
As our next step, we can consider adding gender as a *multiplicative effect* to our model.
\begin{eqnarray*}
h_i(t) &=& h_0(t) \exp \bigg\{ \sum_{j=2}^7 \beta_j dbp_{ij} + \gamma male_i \bigg\}
\end{eqnarray*}
We say the effects are multiplicative because we are adding in the exponent, so any effect due to gender will be multiplied with the effect due to dbp.  How do we tell - from the results - that interaction wasn't modeled?  Look at the hazard ratios, are they consistent when comparing one variable and keeping the other one constant?  That is, check to see if the HR for two different levels of dbp is the same regardless of whether men or women are considered.


     * The change in deviance is 133 ($H_0: \gamma =0$), so with one degree of freedom, the p-value is very small. We do not think that $\gamma=0$, so we need gender in the model.


```r
coxph(Surv(followup,chdfate) ~ dbpf + sex, data = heart) %>% tidy()
#> # A tibble: 7 x 5
#>   term        estimate std.error statistic  p.value
#>   <chr>          <dbl>     <dbl>     <dbl>    <dbl>
#> 1 dbpf60-70      0.648     0.247      2.62 8.74e- 3
#> 2 dbpf70-80      0.888     0.241      3.69 2.27e- 4
#> 3 dbpf80-90      1.02      0.241      4.24 2.25e- 5
#> 4 dbpf90-100     1.40      0.243      5.76 8.48e- 9
#> 5 dbpf100-110    1.79      0.254      7.02 2.29e-12
#> 6 dbpfover110    2.22      0.271      8.17 2.97e-16
#> # … with 1 more row
```

* **Table 7.3** 
Considering gender and dbp interacting.
\begin{eqnarray*}
h_i(t) &=& h_0(t) \exp \bigg\{ \sum_{j=2}^7 \beta_j dbp_{ij} + \gamma male_i + \sum_{j=2}^7 \delta_j dbp_{ij} male_i \bigg\}
\end{eqnarray*}


    * The change in deviance is 21.23 ($H_0: \delta_j =0$), so with six degrees of freedom, the p-value is 0.002.  The evidence of interaction is statistically significant.  
    * Note the marked differences between the estimates in table 7.2 and 7.3.  The interactive model indicates that the effect of gender on the risk of CHD is greatest for people with low or moderate blood pressure and diminishes as blood pressure rises.  Gender appears to have no effect on CHD for people with a DBP above 110 mm Hg.  


```r
coxph(Surv(followup,chdfate) ~ dbpf * sex, data = heart) %>% tidy()
#> # A tibble: 13 x 5
#>   term        estimate std.error statistic  p.value
#>   <chr>          <dbl>     <dbl>     <dbl>    <dbl>
#> 1 dbpf60-70      0.603     0.352      1.71 8.66e- 2
#> 2 dbpf70-80      0.887     0.342      2.60 9.44e- 3
#> 3 dbpf80-90      1.26      0.341      3.68 2.30e- 4
#> 4 dbpf90-100     1.55      0.347      4.46 8.29e- 6
#> 5 dbpf100-110    2.03      0.358      5.67 1.41e- 8
#> 6 dbpfover110    2.61      0.372      7.02 2.18e-12
#> # … with 7 more rows
```


* **Table 7.4**  
Adjusting for confounding variables.  Of particular interest is age at baseline exam.  We know that age varied widely among study subjects, and both DBP and risk of CHD increase with age.  We will also consider the effect of body mass index and serum cholesterol.

\begin{eqnarray*}
h_i(t) &=& h_0(t) \exp \bigg\{ \sum_{j=2}^7 \beta_j dbp_{ij} + \gamma male_i + \sum_{j=2}^7 \delta_j dbp_{ij} male_i \\
&& \theta_1 age_i + \theta_2 bmi_i + \theta_3 scl_i \bigg\}
\end{eqnarray*}


    * We need $\theta_1, \theta_2, \theta_3$, as they are all statistically significant.  
    * The HR in Table 7.4 are substantially smaller than those in Table 7.3.  It is important to realize that the HR in Table 7.4 compare people of the same age, body mass index, and serum cholesterol, while those of Table 7.3 compare people without regard to other variables.  It is not surprising that the unadjusted HR are inflated due to the confounding variables.    
    * Goal: to predict CHD $\rightarrow$ because it's easier to measure blood pressure than cholesterol, we may just prefer to use the unadjusted model.  
    * Goal: to establish a causal link $\rightarrow$ we *must* adjust for all possible confounding variables.  

When should we transform a continuous variable into a factor variable?

* **continuous** If we believe that the relationship is linear in log(HR)  
* **factor** There are lots of coefficients to estimate, so we lose df  


```r
coxph(Surv(followup,chdfate) ~ dbpf * sex + age + bmi + scl, data = heart) %>% tidy()
#> # A tibble: 16 x 5
#>   term        estimate std.error statistic   p.value
#>   <chr>          <dbl>     <dbl>     <dbl>     <dbl>
#> 1 dbpf60-70      0.415     0.352      1.18 0.238    
#> 2 dbpf70-80      0.503     0.343      1.47 0.142    
#> 3 dbpf80-90      0.648     0.344      1.89 0.0592   
#> 4 dbpf90-100     0.661     0.351      1.88 0.0599   
#> 5 dbpf100-110    1.13      0.363      3.12 0.00183  
#> 6 dbpfover110    1.66      0.377      4.40 0.0000107
#> # … with 10 more rows
```

### Testing Proportional Hazards {#testingph}

<!-- Note: in my yellow notes from 2008 I've covered all the residual analysis stuff.  The notes aren't particularly organized or well thought-out.  The topic probably isn't relevant for this class. -->

We've discussed that proportional hazards means that the hazard in one group is a constant multiple of the hazard in another group.  What does that mean in terms of the survival function?

\begin{eqnarray*}
h_1 (t) &=& h_0 (t) e^\beta\\
S(t) &=& e^{-\int_0^t h(x) dx}\\
S_0(t) &=& e^{-\int_0^t h_0(x) dx}\\
S_1(t) &=& e^{-\int_0^t h_0(x)e^\beta dx}\\
S_1(t) &=& e^{- e^\beta \int_0^t h_0(x) dx}\\
S_1(t) &=& \bigg[ e^{- \int_0^t h_0(x) dx} \bigg]^{e^\beta}\\
\ln(S_1(t)) &=& e^\beta \ln [e^{- \int_0^t h_0(x) dx}]\\
-\ln(S_1(t)) &=& e^\beta  [-\ln(S_0(t))]\\
\ln(-\ln(S_1(t))) &=& \beta + \ln [-\ln(S_0(t))]\\
\end{eqnarray*}

#### Test 1 for PH

That is to say, the $\ln (- \ln$ survival curves) should be parallel and differ only by a y-intercept constant of $\beta$.


Note that if $h_0(t)$ is a constant (i.e., $h_i(t) = const e^\beta$), then

\begin{eqnarray*}
S(t) &=& e^{-\int_0^t h(x) dx}\\
&=& e^{-e^\beta t}\\
\ln S(t) &=& -e^\beta t\\
- \ln S(t) &=& e^\beta t\\
\ln(- \ln S(t)) &=& \beta + \ln(t)\\
\end{eqnarray*}

Which is to say that if $ln(- ln S(t))$ is linear in $\ln(t)$, then $h_0(t)$ is not only PH but also constant for all $t$.

#### Time dependent covariates

If the PH assumption is violated, then we have:
\begin{eqnarray*}
\frac{h_i(t)}{h_0(t)} = g(t)
\end{eqnarray*}
some function of $t$.  Consider the following model (the function of time is completely specified, but it is just one possibility for the dependence relationship):

\begin{eqnarray*}
x_{i1}  &=& \left\{
\begin{array}{ll}
1 & treatment\\
0 & control
\end{array}
\right.\\
x_{i2} &=& \left\{
\begin{array}{ll}
t & treatment\\
0 & control\\
\end{array}
\right.\\
\end{eqnarray*}

The relative hazard becomes:
\begin{eqnarray*}
h_i(t) = e^{\beta_1 x_{i1} + \beta_2 x_{i2}} h_0(t)\\
\frac{h_1(t)}{h_0(t)} = e^{\beta_1 +\beta_2 t}\\
\end{eqnarray*}


If $\beta_2 < 0$, the relative hazard decreases with time.  If $\beta_2 > 0$, the relative hazard increases with time.

#### Test 2 for PH

The PH test of interest will be:
\begin{eqnarray*}
H_0: \beta_2 = 0
\end{eqnarray*}

It isn't a Wald test, but it is the same general idea (in R: `cox.zph`).  [The variable in the denominator of the likelihood (for calculating the MLE) will have different values at different times.]  An alternative form of the test is to call: $x_{i2} = t \ \ \forall t$ and let $$h_i(t) = e^{\beta_1 x_{i1} + \beta_2 x_{i1} x_{i2}} h_0(t).$$

If there is time dependency in the model, then the `coxph` analysis won't be accurate.  

<!-- One idea is to transform time, possibly the model is proportional with respect to $ln(t)$??  
 Not true:  working on the transformed data will not give a different model at all
In that case, rerunning `coxph` on the *transformed* time variable will give interpretable results.

 https://bmcmedresmethodol.biomedcentral.com/articles/10.1186/1471-2288-10-20
 Also see Kleinman and Klein for more on the cox.zph model  
-->

#### Schoenfeld Residuals
 
Recall:  under the Cox model, the probability that any particular member $i$ fails at time $t_j$ is:
\begin{eqnarray*}
P(i^{th} \mbox{ indiv w/}x_i \mbox{ dies at } t_j | \mbox{at least one death at } t_j) &=& \frac{P(i^{th} \mbox{ indiv w/}x_i \mbox{ dies at } t_j )}{P(\mbox{at least one death at } t_j)}\\
&=& \frac{\mbox{hazard at } t_i}{\mbox{sum over all patients at risk at time } t_j}\\
&=& \frac{h_i(t_j)}{\sum_{k:t_k \geq t_j} h_k (t_j)} \\
&=& \frac{e^{\beta x_i}}{\sum_{k:t_k \geq t_j} e^{\beta x_k}}\\
w_j(\beta, t_j) &=& \frac{e^{\beta x_i}}{\sum_{k:t_k \geq t_j} e^{\beta x_k}}
\end{eqnarray*}

Using the weights above, we can calculate the average value for the $l^{th}$ covariate (i.e., explanatory variable):
\begin{eqnarray*}
\bar{x}_l (\beta,t_j) &=& \sum_{k: t_k \geq t_j} x_{kl} w_j(\beta, t_j)
\end{eqnarray*}

The Schoenfeld Residual for $x_l$ and any subject $i$ who is still alive at time $t_j$, is the *difference* between the covariate $x_{il}$ for that subject and the weighted average of the covariates in the risk set:
\begin{eqnarray*}
\mbox{Schoenfeld resid }_i = x_{il} - \bar{x}_l(\beta, t_i)
\end{eqnarray*}
Note that the calculation is for the $i^{th}$ subject which means there was a death at time $t_i$.

#### Test 3 for PH

The idea is for the plot to be flat.  What if there is a strong linear trend for the residuals?  What would that say about the time dependency?  Imagine a scatterplot where the residual is very positively linearly associated with time.  If $t_i > >$ then $x_i$ is much bigger than expected; if $t_i < < $ then $x_i$ is much smaller than expected.  That is, the covariate of interest changes over time and its effect on the risk of survival does, too.

#### Solutions

* **crossing** If the hazard functions (or survivor functions!) cross over time, the PH assumption is violated.   
* **help**  What should we do?    
1. Don't do coxph, just fit K-M curves separately and perform a log-rank test.  
2. Start at $t^*$, the crossing point.  
3. Fit different models for before $t^*$ and after $t^*$.  
4. Fit a model with a time dependent covariate.  
5. Creative analysis:  instead of tumor size, use   % change over a set period of time.  

* **examples** of PH violations  
     * over time, effect lessens (short term benefits)  
     * tumor size at endpoint is more predictive than tumor size at entrance.  
     * clinical variables that change over time (lung capacity, weight, white blood cell count)  
     * exposure variables (pollution, UV rays, etc.)  
     * age, temperature  


#### Log linearity 

We've also assumed that the log of the hazard ratio is linear in the covariates.  That a one unit change in any covariate has the same effect on the log of the HR (at any level of the covariate).  Just like with logistic regression, this assumption is hard to check.  However, we can see how the modeling performs by checking to see if quadratic (or other higher order terms) are significant in the model.  Another possibility is to categorize a continuous predictor to check PH assumptions as above.



## Other stuff {#othersurv}

### Sample Size Calculation

#### Sample Size for Two Independent Sample Means Inference

Taking a step back to consider a slightly simpler inference (two sample mean), let's say we want a size of $\alpha=0.05$ and a power of $1-\beta=0.8$.  What does that mean?  How do they relate to the type I and type II errors?  Draw some pictures.  We're talking about the only thing we can control:  the sample size.  We cannot actually control the truth of the hypotheses, the extent of the difference in in $H_0$ versus $H_A$, or the variability of the underlying population.  We **can** control the sample size.  The larger your sample size, the easier it is to identify a true alternative hypothesis (that is, the higher the power).

In order to estimate the needed sample size, you need to know how often you are willing to make type I errors, how often you are willing to make type II errors, and how big of a difference between $H_0$ and $H_A$ you would like to determine.  Without all three of those components, it is **impossible** to determine the sample size.  If you read that a sample size calculation has been done, they **must** report the associated size, power, and difference (or their calculation will be meaningless).


\begin{eqnarray*}
H_0: \mu_1 - \mu_2 = 0\\
H_A: \mu_1 - \mu_2 \ne 0
\end{eqnarray*}

We have to make some assumptions.  We assume that the size is 0.05, the power is 0.8, and the alternative hypothesis is $D = \mu_1 - \mu_2$.  For this case, let's also assume that $\sigma_1=\sigma_2=\sigma$ and $n_1=n_2=n$.  Without loss of generality, let's say $\overline{Y}_1 - \overline{Y}_2 > 0$.
\begin{eqnarray*}
P\bigg(\frac{\overline{Y}_1 - \overline{Y}_2 - 0}{\sigma \sqrt{1/n + 1/n}} > 1.96 \bigg| \mu_1 - \mu_2 = 0 \bigg) &=& 0.025\\
P(\overline{Y}_1 - \overline{Y}_2 > 1.96 \sigma \sqrt{1/n + 1/n} \bigg| \mu_1 - \mu_2 = 0) &=& 0.025\\
P(\overline{Y}_1 - \overline{Y}_2 > 1.96 \sigma \sqrt{1/n + 1/n} \bigg| \mu_1 - \mu_2 = D) &\geq& 0.8\\
P\bigg(\frac{\overline{Y}_1 - \overline{Y}_2 - D}{\sigma \sqrt{1/n + 1/n}} > \frac{1.96 \sigma \sqrt{1/n + 1/n}-D}{\sigma \sqrt{1/n + 1/n}} \bigg| \mu_1 - \mu_2 = D \bigg) &\geq& 0.8\\
P\bigg(Z > \frac{1.96 \sigma \sqrt{1/n + 1/n}-D}{\sigma \sqrt{1/n + 1/n}} \bigg) &\geq& 0.8\\
\frac{1.96 \sigma \sqrt{1/n + 1/n}-D}{\sigma \sqrt{1/n + 1/n}} &\leq& Z_{0.8}\\
1.96 \sigma \sqrt{2/n} - D &\leq& Z_{0.8} \sigma \sqrt{2/n}\\
2.845 \sigma \sqrt{2/n} &\leq& D\\
n &\geq& \frac{16 \sigma^2}{D^2}
\end{eqnarray*}

Again, if we want to be able to find a 2 point difference in unrestricted versus deprived mean visual acuity scores,  ($\sigma=14$, equal sample sizes):
\begin{eqnarray*}
n &\geq& \frac{16 \cdot 14^2}{4}\\
&\geq& 784
\end{eqnarray*}


#### Sample Size for Survival model

The sample size calculations below are derived from the inference done with a log-rank statistics comparing two groups.  The total number of deaths required to detect a difference in groups with a size of $\alpha$ and a power of $1-\beta$ is
\begin{eqnarray*}
d = \frac{(z_{\alpha/2} + z_\beta)^2}{\pi_1 \pi_2 \theta^2_R}
\end{eqnarray*}
where $\pi_1$ is the proportion of the sample in group 1, $\pi_2$ is the proportion of the sample in group 2, and $\theta_R$ is the log hazard ratio to detect.


(Derivation in @Collett pg 256.)

Consider the following sample size calculator.  The variables included are slightly different, but give the same general structure to the calculation.  For example, the equation above calculates the number of deaths.  The applet calculates the number of samples (where $d = p_E \cdot n$).
http://powerandsamplesize.com/Calculators/Test-Time-To-Event-Data/Cox-PH-Equivalence

#### Significance level vs. Power vs. Sample Size

* **Sig level** $\alpha$: we *set* our type I error rate  
* **power** $1-\beta$: probability of not making a type II error.  To set the power, we would need to know the sample size, significance level, and the clinically important difference that we wish to detect (effect size).  
* **sample size** n: To set the sample size, we need $\alpha$, $\beta$, and effect size  
1. "The trial has 90% power" is meaningless  
2. "With 500 subjects per group, the trial has 90% power to detect a decrease of 10mmHg in blood pressure due to the new treatment at a 0.05 significance level."  



### Study Design  
* Randomized, controlled trial  

* Factorial design    
     * Random allocation (within a factorial design) allows for estimation of interaction between treatments    
     * Physicians' health study was factorial with aspirin (to measure myocardial infarction) and beta carotene (cancer)    
     * Can include 3 or more treatments (but would need large sample sizes to measure anything)     

|  	|  	| treatment A 	|  	|
|-------------	|-----	|:-----------:	|:-------:	|
|  	|  	| Yes 	| No 	|
|  	| Yes 	| Both A \& B 	| only B 	|
| **treatment B** 	| No 	| only A 	| neither 	|



* Cross-over design:  all participants receive *both* treatments (e.g., surgery and chemotherapy)    
     * Each patient serves as their own control (need fewer samples)    
     * Often cross-over effect from the initial treatment    

| $\swarrow$ 	|  	| $\searrow$ 	|
|:----------------:	|:--------------------------------:	|:----------------:	|
| Group 1 	|  	| Group 2 	|
| $\downarrow$ (1) 	|  	| $\downarrow$ (1) 	|
| Drug A 	| $\stackrel{(2)}{\rightarrow}$ 	| Drug B 	|
|  	| $\stackrel{(2)}{\hookleftarrow}$ 	|  	|


* Noncompliance  
     * Patients will switch on their own!  How do you analyze the data?   
     * Analyze according to assigned treatment (intent-to-treat).  Crossover does not happen randomly and is well known to be associated to outcome.  
     * Can perform a secondary analysis on only those patients who stayed on treatment.  
     * Example: surgery and radiation  

#### subgroup analysis  

* Refers to analyzing a subset of patients in a trial separately (e.g., gender, race, family background, etc.)  
* Important for: clinical decision making, regulatory requirements, hypothesis generation  
* Problems:   
     * insufficient power.  If powered for overall treatment effect, it will be underpowered to detect similar effects in subgroups.  
     * multiple comparisons.  If you torture your data long enough, eventually it will confess to anything.  
     * whenever possible, subgroup analysis should be defined *a priori* in the protocol

#### Some topics worth investigating 

* Meta Analysis [@crowley]  
* General Thoughts on Clinical Trials for cancer [@crowley]    
* Stratified Cox Model [@vittinghoff]   
* Interim analyses / stopping rules  
* Intent-to-treat (missing data)  
* Investigating time-varying effects [@timevar]


### Simulating survival data

There is a package designed to simulate survival data, `simsurv`.  It allows for complex models, but there is some difficulty with scenarios with very few events or with binary explanatory variables.  Sam Brilleman spoke about the `simsurv` package at useR! 2018: https://www.youtube.com/watch?v=fJTYsncvpvI.


## R example: ProPublica Analysis {#Rsurv}

### Recidivism in Florida  

> [The ProPublica] analysis of Northpointe’s tool, called COMPAS (which stands for Correctional Offender Management Profiling for Alternative Sanctions), found that black defendants were far more likely than white defendants to be incorrectly judged to be at a higher risk of recidivism, while white defendants were more likely than black defendants to be incorrectly flagged as low risk.

> [ProPublica] looked at more than 10,000 criminal defendants in Broward County, Florida, and compared their predicted recidivism rates with the rate that actually occurred over a two-year period. When most defendants are booked in jail, they respond to a COMPAS questionnaire. Their answers are fed into the COMPAS software to generate several scores including predictions of “Risk of Recidivism” and “Risk of Violent Recidivism.”  [@angwin]

The original article is here:  https://www.propublica.org/article/machine-bias-risk-assessments-in-criminal-sentencing

The data analysis is here: https://www.propublica.org/article/how-we-analyzed-the-compas-recidivism-algorithm

The GitHub repo with data and code is here: https://github.com/propublica/compas-analysis



```r
library(survival)
recid <- readr::read_csv("https://raw.githubusercontent.com/propublica/compas-analysis/master/compas-scores-two-years.csv")

recid <- dplyr::select(recid, age, c_charge_degree, race, age_cat, score_text, sex, priors_count, 
                    days_b_screening_arrest, decile_score, is_recid, two_year_recid, 
                    c_jail_in, c_jail_out) %>% 
        filter(days_b_screening_arrest <= 30) %>%
        filter(days_b_screening_arrest >= -30) %>%
        filter(is_recid != -1) %>%
        filter(c_charge_degree != "O") %>%
        filter(score_text != 'N/A')
        
recid <- recid %>% mutate(length_of_stay = as.numeric(as.Date(c_jail_out) - as.Date(c_jail_in))) %>%
      mutate(crime_factor = factor(c_charge_degree)) %>%
      mutate(age_factor = as.factor(age_cat)) %>%
      within(age_factor <- relevel(age_factor, ref = 1)) %>%
      mutate(race_factor = factor(race,
                                  labels = c("African-American", 
                                             "Asian",
                                             "Caucasian", 
                                             "Hispanic", 
                                             "Native American",
                                             "Other"))) %>%
      within(race_factor <- relevel(race_factor, ref = 3)) %>%
      mutate(gender_factor = factor(sex, labels= c("Female","Male"))) %>%
      within(gender_factor <- relevel(gender_factor, ref = 2)) %>%
      mutate(score_factor = factor(score_text != "Low", labels = c("LowScore","HighScore")))
      
```


```r
recidKM <- filter(filter(read_csv("https://raw.githubusercontent.com/propublica/compas-analysis/master/cox-parsed.csv"), score_text != "N/A"), end > start) %>%
        mutate(race_factor = factor(race,
                                  labels = c("African-American", 
                                             "Asian",
                                             "Caucasian", 
                                             "Hispanic", 
                                             "Native American",
                                             "Other"))) %>%
        within(race_factor <- relevel(race_factor, ref = 3)) %>%
        mutate(score_factor = factor(score_text)) %>%
        within(score_factor <- relevel(score_factor, ref=2)) %>%
        mutate(timefollow = end - start) %>%
        filter(race %in% c("African-American", "Caucasian"))

recidKMV <- filter(filter(read_csv("https://raw.githubusercontent.com/propublica/compas-analysis/master/cox-violent-parsed.csv"), score_text != "N/A"), end > start) %>%
        mutate(race_factor = factor(race,
                                  labels = c("African-American", 
                                             "Asian",
                                             "Caucasian", 
                                             "Hispanic", 
                                             "Native American",
                                             "Other"))) %>%
        within(race_factor <- relevel(race_factor, ref = 3)) %>%
        mutate(score_factor = factor(score_text)) %>%
        within(score_factor <- relevel(score_factor, ref=2)) %>%
        mutate(timefollow = end - start) %>%
        filter(race %in% c("African-American", "Caucasian"))
```


### Kaplan-Meier survival curve

```r
recid.surv <- survfit(Surv(timefollow,event) ~ score_factor, data=recidKM)
plot(recid.surv, lty=2:4, xlab="time", ylab="survival function")
legend(10,.4, c("low", "high", "medium"),lty=2:4)

survminer::ggsurvplot(recid.surv, conf.int=TRUE, censor=F) + ggtitle("Overall")
```

<img src="06-surv_files/figure-html/unnamed-chunk-12-1.png" width="80%" style="display: block; margin: auto;" /><img src="06-surv_files/figure-html/unnamed-chunk-12-2.png" width="80%" style="display: block; margin: auto;" />


```r
ggsurvplot(recid.surv[1], conf.int=TRUE, censor=FALSE) + ggtitle("Low Only")

ggsurvplot(recid.surv, conf.int=TRUE, censor=FALSE, risk.table = TRUE)
```

<img src="06-surv_files/figure-html/unnamed-chunk-13-1.png" width="80%" style="display: block; margin: auto;" /><img src="06-surv_files/figure-html/unnamed-chunk-13-2.png" width="80%" style="display: block; margin: auto;" />

different options for CI

```r
set.seed(4747)
recidKM2 <- recidKM %>% sample_n(200)  # CI on a smaller random sample just to see the different CIs
ggsurvplot(survfit(Surv(timefollow,event) ~ score_factor, data=recidKM2), 
           censor=F, conf.int=F) + ggtitle("No CI")
ggsurvplot(survfit(Surv(timefollow,event) ~ score_factor, data=recidKM2,
                   conf.type="log"), censor=F, conf.int=T) + ggtitle("Log CI")
ggsurvplot(survfit(Surv(timefollow,event) ~ score_factor, data=recidKM2,
                   conf.type="log-log"), censor=F, conf.int=T) + ggtitle("Log-Log CI")
ggsurvplot(survfit(Surv(timefollow,event) ~ score_factor, data=recidKM2,
                   conf.type="plain"), censor=F, conf.int=T) + ggtitle("Plain CI")

ggsurvplot_facet(survfit(Surv(timefollow,event) ~ score_factor, data=recidKM2), 
                 data=recidKM2, facet.by = "race")
```

<img src="06-surv_files/figure-html/unnamed-chunk-14-1.png" width="80%" style="display: block; margin: auto;" /><img src="06-surv_files/figure-html/unnamed-chunk-14-2.png" width="80%" style="display: block; margin: auto;" /><img src="06-surv_files/figure-html/unnamed-chunk-14-3.png" width="80%" style="display: block; margin: auto;" /><img src="06-surv_files/figure-html/unnamed-chunk-14-4.png" width="80%" style="display: block; margin: auto;" /><img src="06-surv_files/figure-html/unnamed-chunk-14-5.png" width="80%" style="display: block; margin: auto;" />

### Log-rank test [rho=0] and the Wilcoxon test [rho=1]

General recidivism

```r
survdiff(Surv(timefollow,event) ~ score_factor, data=recidKM2, rho=0)
#> Call:
#> survdiff(formula = Surv(timefollow, event) ~ score_factor, data = recidKM2, 
#>     rho = 0)
#> 
#>                      N Observed Expected (O-E)^2/E (O-E)^2/V
#> score_factor=Low    91       16     29.3      6.04     13.13
#> score_factor=High   52       20     11.6      6.11      7.80
#> score_factor=Medium 57       19     14.1      1.70      2.29
#> 
#>  Chisq= 14.1  on 2 degrees of freedom, p= 9e-04
survdiff(Surv(timefollow,event) ~ score_factor, data=recidKM2, rho=1)
#> Call:
#> survdiff(formula = Surv(timefollow, event) ~ score_factor, data = recidKM2, 
#>     rho = 1)
#> 
#>                      N Observed Expected (O-E)^2/E (O-E)^2/V
#> score_factor=Low    91     13.8    24.54      4.68     11.69
#> score_factor=High   52     17.0     9.99      4.88      7.21
#> score_factor=Medium 57     15.8    12.04      1.16      1.82
#> 
#>  Chisq= 12.6  on 2 degrees of freedom, p= 0.002

ggsurvplot(survfit(Surv(timefollow,event) ~ score_factor, data=recidKM2), 
           censor=F, conf.int=F, pval=TRUE) + ggtitle("No CI")
```

<img src="06-surv_files/figure-html/unnamed-chunk-15-1.png" width="80%" style="display: block; margin: auto;" />

Violent recidivism

```r
set.seed(4747)
recidKMV2 <- recidKMV %>%
  sample_n(500)

recidKMV2 %>% filter(race == "Caucasian") %>%
  survdiff(Surv(timefollow,event) ~ score_factor, data=., rho=0)
#> Call:
#> survdiff(formula = Surv(timefollow, event) ~ score_factor, data = ., 
#>     rho = 0)
#> 
#>                       N Observed Expected (O-E)^2/E (O-E)^2/V
#> score_factor=Low    112        6    6.087   0.00126   0.00392
#> score_factor=High    25        2    0.966   1.10625   1.24725
#> score_factor=Medium  46        1    1.946   0.46016   0.58870
#> 
#>  Chisq= 1.6  on 2 degrees of freedom, p= 0.5

recidKMV2 %>% filter(race == "African-American") %>%
  survdiff(Surv(timefollow,event) ~ score_factor, data=., rho=0)
#> Call:
#> survdiff(formula = Surv(timefollow, event) ~ score_factor, data = ., 
#>     rho = 0)
#> 
#>                       N Observed Expected (O-E)^2/E (O-E)^2/V
#> score_factor=Low     94        3     4.11     0.301     0.488
#> score_factor=High   131        6     3.77     1.322     2.037
#> score_factor=Medium  92        2     3.12     0.401     0.560
#> 
#>  Chisq= 2  on 2 degrees of freedom, p= 0.4

survdiff(Surv(timefollow,event) ~ score_factor, data=recidKMV2, rho=1)
#> Call:
#> survdiff(formula = Surv(timefollow, event) ~ score_factor, data = recidKMV2, 
#>     rho = 1)
#> 
#>                       N Observed Expected (O-E)^2/E (O-E)^2/V
#> score_factor=Low    206     8.77     9.63    0.0771     0.158
#> score_factor=High   156     7.78     4.87    1.7317     2.389
#> score_factor=Medium 138     2.96     5.00    0.8343     1.151
#> 
#>  Chisq= 2.7  on 2 degrees of freedom, p= 0.3

ggsurvplot(survfit(Surv(timefollow,event) ~ score_factor, data=recidKMV2), 
           censor=F, conf.int=T, pval=TRUE) + ggtitle("Violent Recidivism")

ggsurvplot(survfit(Surv(timefollow,event) ~ score_factor, data=recidKMV2), 
                 data=recidKMV, censor = FALSE, conf.int = TRUE, facet.by = "race") + 
  ggtitle("Violent Recidivism")

as.data.frame(recidKMV2) %>%  # must be a data.frame see "." below:
ggsurvplot(survfit(Surv(timefollow,event) ~ score_factor, data= .), 
                 data = ., censor = FALSE, conf.int = TRUE, pval=TRUE, facet.by = "race") + 
  ggtitle("Violent Recidivism")
```

<img src="06-surv_files/figure-html/unnamed-chunk-16-1.png" width="80%" style="display: block; margin: auto;" /><img src="06-surv_files/figure-html/unnamed-chunk-16-2.png" width="80%" style="display: block; margin: auto;" /><img src="06-surv_files/figure-html/unnamed-chunk-16-3.png" width="80%" style="display: block; margin: auto;" />


### Cox Proportional Hazards models


```r
# Just score_factor
coxph(Surv(timefollow,event) ~ score_factor, data=recidKM) %>% tidy()
#> # A tibble: 2 x 5
#>   term               estimate std.error statistic   p.value
#>   <chr>                 <dbl>     <dbl>     <dbl>     <dbl>
#> 1 score_factorHigh      1.08     0.0446      24.1 7.67e-129
#> 2 score_factorMedium    0.704    0.0439      16.0 9.78e- 58
coxph(Surv(timefollow,event) ~ score_factor, data=recidKM) %>% glance()
#> # A tibble: 1 x 18
#>       n nevent statistic.log p.value.log statistic.sc p.value.sc statistic.wald
#>   <int>  <dbl>         <dbl>       <dbl>        <dbl>      <dbl>          <dbl>
#> 1 11426   3058          617.   9.39e-135         654.  1.15e-142           609.
#> # … with 11 more variables: p.value.wald <dbl>, statistic.robust <dbl>,
#> #   p.value.robust <dbl>, r.squared <dbl>, r.squared.max <dbl>,
#> #   concordance <dbl>, std.error.concordance <dbl>, logLik <dbl>, AIC <dbl>,
#> #   BIC <dbl>, nobs <int>

# score_factor and race
coxph(Surv(timefollow,event) ~ score_factor + race, data=recidKM) %>% tidy()
#> # A tibble: 3 x 5
#>   term               estimate std.error statistic   p.value
#>   <chr>                 <dbl>     <dbl>     <dbl>     <dbl>
#> 1 score_factorHigh      1.03     0.0460     22.3  3.96e-110
#> 2 score_factorMedium    0.674    0.0445     15.2  7.45e- 52
#> 3 raceCaucasian        -0.170    0.0396     -4.29 1.78e-  5
coxph(Surv(timefollow,event) ~ score_factor + race, data=recidKM) %>% glance()
#> # A tibble: 1 x 18
#>       n nevent statistic.log p.value.log statistic.sc p.value.sc statistic.wald
#>   <int>  <dbl>         <dbl>       <dbl>        <dbl>      <dbl>          <dbl>
#> 1 11426   3058          636.   1.65e-137         671.  3.72e-145           626.
#> # … with 11 more variables: p.value.wald <dbl>, statistic.robust <dbl>,
#> #   p.value.robust <dbl>, r.squared <dbl>, r.squared.max <dbl>,
#> #   concordance <dbl>, std.error.concordance <dbl>, logLik <dbl>, AIC <dbl>,
#> #   BIC <dbl>, nobs <int>

# score_factor, race, age, sex
coxph(Surv(timefollow,event) ~ score_factor + race + age + sex, data=recidKM) %>% tidy()
#> # A tibble: 5 x 5
#>   term               estimate std.error statistic  p.value
#>   <chr>                 <dbl>     <dbl>     <dbl>    <dbl>
#> 1 score_factorHigh     0.926    0.0471      19.6  7.63e-86
#> 2 score_factorMedium   0.611    0.0452      13.5  1.54e-41
#> 3 raceCaucasian       -0.120    0.0398      -3.01 2.63e- 3
#> 4 age                 -0.0137   0.00175     -7.82 5.38e-15
#> 5 sexMale              0.411    0.0502       8.19 2.53e-16
coxph(Surv(timefollow,event) ~ score_factor + race + age + sex, data=recidKM) %>% glance()
#> # A tibble: 1 x 18
#>       n nevent statistic.log p.value.log statistic.sc p.value.sc statistic.wald
#>   <int>  <dbl>         <dbl>       <dbl>        <dbl>      <dbl>          <dbl>
#> 1 11426   3058          768.   8.91e-164         787.  7.45e-168           739.
#> # … with 11 more variables: p.value.wald <dbl>, statistic.robust <dbl>,
#> #   p.value.robust <dbl>, r.squared <dbl>, r.squared.max <dbl>,
#> #   concordance <dbl>, std.error.concordance <dbl>, logLik <dbl>, AIC <dbl>,
#> #   BIC <dbl>, nobs <int>
```


Using the `rms` package, we can plot CIs for each of the relevant HRs for the model at hand:

```r
recid.data <- recidKM %>%
  select(timefollow, event, score_factor, race, age, sex)
recid.final <- rms::cph(Surv(timefollow,event) ~ score_factor + race + age + sex, data=recid.data)
ddist <- rms::datadist(recid.data)
options(datadist = 'ddist')
plot(summary(recid.final), log = TRUE)
```

<img src="06-surv_files/figure-html/unnamed-chunk-18-1.png" width="80%" style="display: block; margin: auto;" />


### Checking proportional hazards with the plot of $\ln(-\ln(S(t)))$


```r
ggsurvplot(survfit(Surv(timefollow,event) ~ score_factor, data=recidKM), 
           censor=F, conf.int=T, fun="cloglog") + ggtitle("Complementary Log-Log")
```

<img src="06-surv_files/figure-html/unnamed-chunk-19-1.png" width="80%" style="display: block; margin: auto;" />

The cox.zph function will test proportionality of all the predictors in the model by creating interactions with time using the transformation of time specified in the transform option. In this example we are testing proportionality by looking at the interactions with log(time). The column rho is the Pearson product-moment correlation between the scaled Schoenfeld residuals and log(time) for each covariate. The last row contains the global test for all the interactions tested at once. A p-value less than 0.05 indicates a violation of the proportionality assumption.

### Checking proportional hazards with cox.zph


```r
cox.zph(coxph(Surv(timefollow,event) ~ score_factor, data=recidKM))
#>              chisq df   p
#> score_factor 0.457  2 0.8
#> GLOBAL       0.457  2 0.8
cox.zph(coxph(Surv(timefollow,event) ~ score_factor, data=recidKM), transform="log")
#>              chisq df    p
#> score_factor  3.04  2 0.22
#> GLOBAL        3.04  2 0.22
cox.zph(coxph(Surv(timefollow,event) ~ score_factor + race + age + sex, data=recidKM))
#>                chisq df      p
#> score_factor  0.5254  2 0.7690
#> race          7.6193  1 0.0058
#> age           6.7511  1 0.0094
#> sex           0.0387  1 0.8440
#> GLOBAL       13.6196  5 0.0182
```

Note the big p-values.  We do not reject the null hypothesis, so we conclude that there is no evidence of non-proportional hazards.  If for example, the model seemed to be non-proportional on time but proportional on log(time), you might consider transforming the time variable (i.e., taking the natural log) in your original model.


The function cox.zph creates a cox.zph object that contains a list of the scaled Schoenfeld residuals.  The ordering of the residuals in the list is the same order as the predictors were entered in the cox model.  So, the first element of the list corresponds to the scaled Schoenfeld residuals for married, the second element corresponds to the scaled Schoenfeld residuals for person, and so forth. The cox.zph object can be used in a plot function.  By specifying a particular element of the list it is possible to generate plots of residuals for individual predictors.  Leaving out the list number results in plots for all the predictors being generated at one time.  In the plots a non-zero slope is evidence against proportionality. The horizontal line at y=0 has been added for reference.


```r
ggcoxzph(cox.zph(coxph(Surv(timefollow,event) ~ score_factor + race + age + sex, data=recidKM))) 
```

<img src="06-surv_files/figure-html/unnamed-chunk-21-1.png" width="80%" style="display: block; margin: auto;" />


###  Coxph diagnostics ... look into all the different arguments of the function!


```r
ggcoxdiagnostics(coxph(Surv(timefollow,event) ~ score_factor + race + age + sex, data=recidKM))
```

<img src="06-surv_files/figure-html/unnamed-chunk-22-1.png" width="80%" style="display: block; margin: auto;" />

