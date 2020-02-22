# R functions {#rfunc}




To help us navigate / remember when to use what, the following sections consolidate some of the R functions used in class and on assignments.

## Applets

* The main source of in-class applets has come from @iscam and can be found: http://www.rossmanchance.com/iscam3/files.html

* In Math 58B we also use the RR/OR applet by Ken Kleinman at: https://kenkleinman.shinyapps.io/odds-tool/

## Wrangling

Data wrangling is used when working to change data in one format to another.  We have regularly used the pipe function (`%>%`) to layer commands.  Data wranging will be an even bigger part of the data analysis pipeline when we start to work with continuous variables (e.g., height).

The pipe syntax (`%>%`) takes a data frame (or data table) and sends it to the argument of a function.  The mapping goes to the first available argument in the function.  For example:

`x %>% f(y)` is the same as `f(x, y)`

` y %>% f(x, ., z)` is the same as `f(x,y,z)`


* A great source of help is the data wrangling cheatsheet here: https://rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf

* **Data verbs take data tables as input and give data tables as output (that's how we can use the chaining syntax!).**  The functions below are from the R package `dplyr`, and they will be used to do much of the data wrangling.  Below is a list of verbs which will be helpful in wrangling many different types of data.  

    * `sample_n()` take a random row(s)
    * `head()`  grab the first few rows
    * `tail()` grab the last few rows
    * `filter()`  removes unwanted *cases*
    *  `arrange()` reorders the cases
    *  `select()` removes unwanted *variables*   (and `rename()`)
    *  `distinct()` returns the unique values in a table
    * `mutate()` transforms the variable (and `transmute()` like mutate, returns only new variables)
    *  `group_by()` tells R that SUCCESSIVE functions keep in mind that there are groups of items.  So `group_by()` only makes sense with verbs later on (like `summarize()`).
    *  `summarize()`  collapses a data frame to a single row.  Some functions that are used within `summarize()` include:
       * `min(), max(), mean(), sum(), sd(), median()`, and `IQR()`
       * `n()`: number of observations in the current group
       * `n_distinct(x)`: count the number of unique values in the varaible (column) called `x`
       * `first_value(x), last_value(x)` and `nth_value(x, n)`: work similarly to `x[1], x[length(x)]`, and `x[n]` 


## Plotting

The R package `ggplot2` will be used for all visualizations.  Remember that the layers of a plot are put together with the `+` symbol (instead of the `%>%` command).


* A great source of help is the data visualization cheatsheet here: https://rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf

* Each plot starts with `ggplot(data)` and then adds layers.  The minimal additional layer is a `geom_XXX()` layer which describes the geometry of the plot.

* Some things to notice:

    * when layering graph pieces, use `+`.  (When layering data wrangling, use `%>%`.)
    * `geom_XXX` will put the `XXX`-type-of-plot onto the graph.
    * `aes` is the function which takes the **data columns** and puts them onto the graph.  `aes` is used only with data columns and you *always* need it if you are working with data variables.
    * A full set of types of plots is given here: https://rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf (and in many other places online).


## Statistical Inference

The main simulation tools we have used for creating null distributions come from the R package `infer`. 

<ul>
<li>There are many examples available on the `infer` vignette page: https://infer-dev.netlify.com/index.html</li>

<li>Typically, the following steps are followed:

<ul>
<li>calculate the test statistic</li>

```
teststat <- data %>%
   specify(variable information) %>%
   calculate(the form of the statistic)
```

<li>create the null values of the statistic</li>

```
nullstats <- data %>%
   specify(variable information) %>%
   hypothesize(give information about the type of null hypothesis) %>%
   generate(repeat the process, provide info about the process) %>%
   calculate(the form of the statistic)
```

<li>visualize the null sampling distribution (of the statistic)</li>

```
nullstats %>%
   visualize()
```

<li>visualize the null sampling distribution with the observed statistic overlaid</li>

```
nullstats %>%
   visualize() +
   shade_p_value(specify where the observed statistics is)
```

<li>calculate the p-value</li>

```
nullstats %>%
   get_p_value(specify the observed statistic and the direction of the test)
```

</ul>


