

# Misc {#misc}




## 11/26/19 Agenda {#Nov26}
1. API / authenticating 
2. parallel computing
3. cloud computing
4. `reticulate` (Python in R!)
5. SQL

## API

What is an API? (Application Programming Interface)

Think of an API as a restaurant menu.  The menu provides a list of what the restaurant has to offer, and you order off the menu by choosing the dish that you want.  After you order, the restaurant figures out how to bring the food from the kitchen to your table in the way that you've specified. 

An API is an intermediary that allows two applications to talk to one another.  It is not the database or the server, instead it is the *code* that allows communication.

<img src="figs/api_xkcd.png" width="65%" style="display: block; margin: auto 0 auto auto;" />

#### Examples of APIs {-}

* When you use an app on your phone, the app connects to the internet and sends information to a server somewhere.  The server retrieves the data, interprets is, does what it does, and sends it back to you.  The application which takes the data from the server and presents it to you in a readable way is an API.

* Let's say you are booking a flight on United.  You choose all the details, you interact with the airline's website.  BUT INSTEAD, what if you are interacting with a software like Expedia?  Then Expedia has to talk to United's API to get all the information about available flights, costs, seats, etc.

* If you've ever been to a third party site and clicked on "Share on Facebook" or "Share on Twitter" your third party site is communicating with the Facebook API or the Twitter API.

* You sign up to go to a concert, and StubHub asks whether you want to add the concert to your Google calendar.  StubHub needs to talk to Google via Google's API.

* What if you want some Twitter data?  How might you get it?  Well, you could email Twitter and ask someone for it.  **Instead** Twitter provides information about how their data is stored, and allows you to query their data in an automated way.


## Parallel Computing

## Cloud Computing

## `reticulate`

### Connect to Python within RStudio {-}

For many statisticians, the go-to software language is R.  However, there is no doubt that Python is a very important language in data science.  Why not do both??


```r
library(tidyverse)
library(reticulate)
use_virtualenv("r-reticulate")
reticulate::import("statsmodels")
```

```
## Module(statsmodels)
```

#### I can run Python inside R?? {-}

<img src="figs/pychunk1.png" width="65%" style="display: block; margin: auto auto auto 0;" />
<img src="figs/pychunk2.png" width="65%" style="display: block; margin: auto 0 auto auto;" />


* `pandas` for data wrangling.  
* In R, the chunk is specified to be a Python chunk (RStudio is now running Python). 


````
```{python}
import pandas
flights = pandas.read_csv("flights.csv")
flights = flights[flights["dest"] == "ORD"]
flights = flights[['carrier', 'dep_delay', 'arr_delay']]
flights = flights.dropna()
```
````

A view of the Python chunk which is actually run:


```python
import pandas
flights = pandas.read_csv("flights.csv")
flights = flights[flights["dest"] == "ORD"]
flights = flights[['carrier', 'dep_delay', 'arr_delay']]
flights = flights.dropna()
```



#### Learn about the dataset {-}

````
```{python}
flights.shape
flights.head(3)
flights.describe()
```
````



```python
flights.shape
```

```
## (12590, 3)
```

```python
flights.head(3)
```

```
##    carrier  dep_delay  arr_delay
## 4       UA       -4.0       12.0
## 5       AA       -2.0        8.0
## 22      AA       -1.0       14.0
```

```python
flights.describe()
```

```
##           dep_delay     arr_delay
## count  12590.000000  12590.000000
## mean      11.709770      2.917951
## std       39.409704     44.885155
## min      -20.000000    -62.000000
## 25%       -6.000000    -22.000000
## 50%       -2.000000    -10.000000
## 75%        9.000000     10.000000
## max      466.000000    448.000000
```


#### Computations using `pandas` {-}


````
```{python}
flights = pandas.read_csv("flights.csv")
flights = flights[['carrier', 'dep_delay', 'arr_delay']]
flights.groupby("carrier").mean()
```
````


```python
flights = pandas.read_csv("flights.csv")
flights = flights[['carrier', 'dep_delay', 'arr_delay']]
flights.groupby("carrier").mean()
```

```
##          dep_delay  arr_delay
## carrier                      
## AA        8.586016   0.364291
## AS        5.804775  -9.930889
## DL        9.264505   1.644341
## UA       12.106073   3.558011
## US        3.782418   2.129595
```



#### From Python chunk to R chunk {-}

* `py$x` accesses an `x` variable created within Python from R
* `r.x` accesses an `x` variable created within R from Python



```r
library(ggplot2)
ggplot(py$flights, 
       aes(x=carrier, 
           y=arr_delay)) + 
  geom_point() + 
  geom_jitter()
```

<img src="10-misc_files/figure-html/unnamed-chunk-9-1.png" width="480" style="display: block; margin: auto;" />


#### From R chunk to Python chunk {-}


```r
data(diamonds)
head(diamonds)
```

```
## # A tibble: 6 x 10
##   carat cut       color clarity depth table price     x     y     z
##   <dbl> <ord>     <ord> <ord>   <dbl> <dbl> <int> <dbl> <dbl> <dbl>
## 1 0.23  Ideal     E     SI2      61.5    55   326  3.95  3.98  2.43
## 2 0.21  Premium   E     SI1      59.8    61   326  3.89  3.84  2.31
## 3 0.23  Good      E     VS1      56.9    65   327  4.05  4.07  2.31
## 4 0.290 Premium   I     VS2      62.4    58   334  4.2   4.23  2.63
## 5 0.31  Good      J     SI2      63.3    58   335  4.34  4.35  2.75
## 6 0.24  Very Good J     VVS2     62.8    57   336  3.94  3.96  2.48
```


####  Python chunks {-}

Note that we're calling Python code on an R object.


```python
print(r.diamonds.describe())
```

```
##               carat         depth  ...             y             z
## count  53940.000000  53940.000000  ...  53940.000000  53940.000000
## mean       0.797940     61.749405  ...      5.734526      3.538734
## std        0.474011      1.432621  ...      1.142135      0.705699
## min        0.200000     43.000000  ...      0.000000      0.000000
## 25%        0.400000     61.000000  ...      4.720000      2.910000
## 50%        0.700000     61.800000  ...      5.710000      3.530000
## 75%        1.040000     62.500000  ...      6.540000      4.040000
## max        5.010000     79.000000  ...     58.900000     31.800000
## 
## [8 rows x 7 columns]
```



```python
import statsmodels.formula.api as smf
model = smf.ols('price ~ carat', data = r.diamonds).fit()
print(model.summary())
```

```
##                             OLS Regression Results                            
## ==============================================================================
## Dep. Variable:                  price   R-squared:                       0.849
## Model:                            OLS   Adj. R-squared:                  0.849
## Method:                 Least Squares   F-statistic:                 3.041e+05
## Date:                Sat, 23 Nov 2019   Prob (F-statistic):               0.00
## Time:                        21:38:21   Log-Likelihood:            -4.7273e+05
## No. Observations:               53940   AIC:                         9.455e+05
## Df Residuals:                   53938   BIC:                         9.455e+05
## Df Model:                           1                                         
## Covariance Type:            nonrobust                                         
## ==============================================================================
##                  coef    std err          t      P>|t|      [0.025      0.975]
## ------------------------------------------------------------------------------
## Intercept  -2256.3606     13.055   -172.830      0.000   -2281.949   -2230.772
## carat       7756.4256     14.067    551.408      0.000    7728.855    7783.996
## ==============================================================================
## Omnibus:                    14025.341   Durbin-Watson:                   0.986
## Prob(Omnibus):                  0.000   Jarque-Bera (JB):           153030.525
## Skew:                           0.939   Prob(JB):                         0.00
## Kurtosis:                      11.035   Cond. No.                         3.65
## ==============================================================================
## 
## Warnings:
## [1] Standard Errors assume that the covariance matrix of the errors is correctly specified.
```


#### Running just Python {-}

<img src="figs/PyScript.png" width="120%" style="display: block; margin: auto;" />


#### Full disclosure {-}

Reticulate is not always trivial to set up.  Indeed, I've had trouble figuring out which Python version is talking to R and where different module versions live.


#### Learn more {-}

- [RStudio R Interface to Python](https://rstudio.github.io/reticulate/)

https://rstudio.github.io/reticulate/  

- [RStudio blog on Reticulated Python](https://blog.rstudio.com/2018/10/09/rstudio-1-2-preview-reticulated-python/)  

https://blog.rstudio.com/2018/10/09/rstudio-1-2-preview-reticulated-python







## SQL



## 12/10/19 Agenda {#Dec10}
1. Regular Expressions

## Regular Expressions {#regexpr}

