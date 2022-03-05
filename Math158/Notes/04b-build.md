# Model Building {#build}




When we get there, use the function `bestregsubsets()`.

> Is this the best model to explain variation in tips?


**Note:**  when a single dataset is used to build and fit the model, we penalize the fitting (think $R^2_{adj}$).  When different data are used, i.e., with CV, there is no need to use a metric with penalization.

## Another model summary^[Thanks to Mine Çentinkaya-Rundel for the majority of the content in this section  Mine's course is at https://mine-cr.com/teaching/sta210/.]








```r
anova(tip_fit$fit) %>%
  tidy() %>%
  kable(digits = 2)
```



|term      |  df| sumsq|  meansq| statistic| p.value|
|:---------|---:|-----:|-------:|---------:|-------:|
|Party     |   1|  1189| 1188.64|    285.71|    0.00|
|Age       |   2|    38|   19.01|      4.57|    0.01|
|Residuals | 165|   686|    4.16|        NA|      NA|

# Analysis of variance (ANOVA)

## Analysis of variance (ANOVA)

-   **Main Idea:** Decompose the total variation on the outcome into:
    -   the variation that can be explained by the each of the variables in the model

    -   the variation that **can't** be explained by the model (left in the residuals)
-   If the variation that can be explained by the variables in the model is greater than the variation in the residuals, this signals that the model might be "valuable" (at least one of the $\beta$s not equal to 0)

## ANOVA output


```r
anova(tip_fit$fit) %>%
  tidy() %>%
  kable(digits = 2)
```



|term      |  df| sumsq|  meansq| statistic| p.value|
|:---------|---:|-----:|-------:|---------:|-------:|
|Party     |   1|  1189| 1188.64|    285.71|    0.00|
|Age       |   2|    38|   19.01|      4.57|    0.01|
|Residuals | 165|   686|    4.16|        NA|      NA|

## ANOVA output, with totals


|term      |  df| sumsq|meansq  |statistic |p.value |
|:---------|---:|-----:|:-------|:---------|:-------|
|Party     |   1|  1189|1188.64 |285.71    |0       |
|Age       |   2|    38|19.01   |4.57      |0.01    |
|Residuals | 165|   686|4.16    |          |        |
|Total     | 168|  1913|        |          |        |

## Sum of squares

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> term </th>
   <th style="text-align:right;"> df </th>
   <th style="text-align:right;"> sumsq </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Party </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;background-color: #D9E3E4 !important;"> 1189 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Age </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;background-color: #D9E3E4 !important;"> 38 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Residuals </td>
   <td style="text-align:right;"> 165 </td>
   <td style="text-align:right;background-color: #D9E3E4 !important;"> 686 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Total </td>
   <td style="text-align:right;"> 168 </td>
   <td style="text-align:right;background-color: #D9E3E4 !important;"> 1913 </td>
  </tr>
</tbody>
</table>


-   $SS_{Total}$: Total sum of squares, variability of outcome, $\sum_{i = 1}^n (y_i - \bar{y})^2$
-   $SS_{Error}$: Residual sum of squares, variability of residuals, $\sum_{i = 1}^n (y_i - \hat{y})^2$
-   $SS_{Model} = SS_{Total} - SS_{Error}$: Variability explained by the model



## Testing Sets of Coefficients {#sec:nestF}

## Model Selection

## Other ways for comparing models

## Getting the Variables Right

## One Model Building Strategy

### Thoughts on Model Selection...

Question: Did females receive lower starting salaries than males?  [From **The Statistical Sleuth** by Ramsey and Schafer]

model:  y = log(salary), x's: seniority, age, experience, education, sex.

In the Sleuth, they first find a good model using only seniority, age, experience and education (including considerations of interactions/quadratics). Once they find a suitable model (Model 1), they then add the sex variable to this model to determine if it is significant. (H0: Model 1 vs HA: Model 1 + sex)  In other regression texts, the models considered would include the sex variable from the beginning, and work from there, but always keeping the sex variable in.  What are the pluses/minuses of these approaches?

**Response**  It seems possible, and even likely, that sex would be associated with some of these other variables, so depending how the model selection that starts with sex included were done, it would be entirely possible to choose a model that includes sex but not one or more of the other variables, and in which sex is significant. If however, those other variables were included, sex might not explain a significant amount of variation beyond those others. Whereas the model selection that doesn't start with sex would be more likely to include those associated covariates to start with.  
One nice aspect of both methods in that they both end up with sex in the model; one difficulty is when a model selection procedure ends up removing the variable of interest and people then claim that the variable of interest doesn't matter.  However, it is often advantageous to avoid model selection as much as possible. Each model answers a different question, and so ideally it would be good to decide ahead of time what the question of interest is.  
In this case there are two questions of interest; are there differences at all (univariate model), and are there differences after accounting for the covariates (multivariate model)? If the differences get smaller after adjusting for the covariates, then that leads to the very interesting question of why that is, and whether those differences are also part of the sex discrimination. Consider the explanation that the wage gap between men and women is due to men in higher-paying jobs, when really, that's part of the problem, that jobs that have more women in them pay less. :( The point, though, is that one model may not be sufficient for a particular situation, and looking for one "best" model can be misleading.


