# Bootstrapping {#boot}




## Introduction

As we did with permutation tests, we are going to use random samples to describe the population (assuming we have a simple random sample).

Main idea:  we will be able to estimate the **variability** of the estimator (difference in medians, ordinary least square with non-normal errors, etc.).

* It's not so strange to get $\hat{\theta}$ and SE($\hat{\theta}$) from the data (consider $\hat{p}$ & $\sqrt{\hat{p}(1-\hat{p})/n}$ and $\overline{X}$ & $s/\sqrt{n}$).
* We'll only consider confidence intervals for now.
* Bootstrapping doesn't help get around small samples.

The following applets may be helpful:

* The logic of confidence intervals http://www.rossmanchance.com/applets/ConfSim.html
* Bootstrapping from actual datasets http://lock5stat.com/statkey/index.html

## Basics & Notation {#BSnotation}

Let $\theta$ be the parameter of interest, and let $\hat{\theta}$ be the estimate of $\theta$.  If we could, we'd take lots of samples of size $n$ from the population to create a **sampling distribution** for $\hat{\theta}$.  Consider taking $B$ random samples from $F$:

\begin{align}
\hat{\theta}(\cdot) = \frac{1}{B} \sum_{i=1}^B \hat{\theta}_i
\end{align}
is the best guess for $\theta$.  If $\hat{\theta}$ is very different from $\theta$, we would call it **biased**.
\begin{align}
SE(\hat{\theta}) &= \bigg[ \frac{1}{B-1} \sum_{i=1}^B(\hat{\theta}_i - \hat{\theta}(\cdot))^2 \bigg]^{1/2}\\
q_1 &= [0.25 B] \ \ \ \ \hat{\theta}^{(q_1)} = \mbox{25}\% \mbox{ cutoff}\\
q_3 &= [0.75 B] \ \ \ \ \hat{\theta}^{(q_3)} = \mbox{75}\% \mbox{ cutoff}\\
\end{align}

If we could, we would completely characterize the sampling distribution (as a function of $\theta$) which would allow us to make inference on $\theta$ when we only had $\hat{\theta}$.

<div class="figure" style="text-align: center">
<img src="figs/BSlogic.png" alt="From Hesterberg et al., Chapter 16 of Introduction to the Practice of Statistics by  Moore, McCabe, and Craig" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-2)From Hesterberg et al., Chapter 16 of Introduction to the Practice of Statistics by  Moore, McCabe, and Craig</p>
</div>



### The Plug-in Principle

Recall
\begin{align}
F(x) &= P(X \leq x)\\
\hat{F}(x) &= S(x) = \frac{\# \{X_i \leq x\} }{n}
\end{align}
$\hat{F}(x)$ is a sufficient statistic for $F(x)$.  That is, all the information about $F$ that is in the data is contained in $\hat{F}(x)$.  Additionally, $\hat{F}(x)$ is the MLE of $F(x)$ (they are both probabilities, so it's a binomial argument).

Note that, in general, we are interested in a parameter, $\theta$.
\begin{align}
\theta = t(F) \ \ \ \ [\mbox{e.g., } \mu = \int x f(x) dx ]
\end{align}

The *plug-in estimate* of $\theta$ is:
\begin{align}
\hat{\theta} = t(\hat{F}) \ \ \ \ [\mbox{e.g., } \overline{X} = \frac{1}{n} \sum X_i ]
\end{align}

That is: *to estimate a parameter, use the statistic that is the corresponding quantity for the sample.*

\begin{align}
\mbox{Ideal Real World} & \mbox{Boostrap World}\\
F \rightarrow x &\Rightarrow \hat{F} \rightarrow x^*\\
\downarrow &  \downarrow\\
\hat{\theta}  & \hat{\theta}^*
\end{align}

The idea of boostrapping (and in fact, the bootstrap samples themselves), depends on the double arrow.  We must have a random sample: that is, $\hat{F}$ must do a good job of estimating $F$ in order for bootstrap concepts to be meaningful.

Note that you've seen the plug-in-principle before:
\begin{align}
\sqrt{\frac{p(1-p)}{n}} &\approx& \sqrt{\frac{\hat{p}(1-\hat{p})}{n}}\\
\end{align}
<!--
%\mbox{Fisher's Information: } I(\theta) &\approx& I(\hat{\theta})
-->

### The Bootstrap Idea

We can *resample* from the *sample* to represent samples from the actual population!  The *boostrap distribution* of a statistic, based on many resamples, represents the **sampling distribution** of the statistic based on many samples.  Is this okay??  What are we assuming?

1. As $n \rightarrow \infty$, $\hat{F}(x) \rightarrow F(x)$

2. As $B \rightarrow \infty$, $\hat{F}(\hat{\theta}^*) \rightarrow F(\hat{\theta})$  (with large $n$).  Or really, what we typically see if $\hat{F}(\hat{\theta}^* / \hat{\theta}) \rightarrow F(\hat{\theta} / \theta)$ or $\hat{F}(\hat{\theta}^* - \hat{\theta}) \rightarrow F(\hat{\theta} - \theta)$



### Bootstrap Procedure

1. Resample data **with replacement** from the original sample.
2. Calculate the statistic of interest for each resample.
3. Repeat 1. and 2. $B$ times.
4. Use the bootstrap distribution for inference.

















































