# Exercise-1
In this exercise, you'll practice **collaborating** with another person to write and use functions across multiple files. You should follow these steps:

1. **Person 1** should fork the repository
2. Person 1 (who forked the repository) should add **person 2** as a **collaborator** on GitHub (so they can both work on the project).
3. Both people should clone _the same repository_ to their machine
4. **Person 1** should write a function to build a scatterplot as described in `scripts/BuildScatter.R`.
5. **Person 2** should use the `source` function to _load_ the `BuildScatter.R` script into `exercise.R`. They should then build a scatterplot using the function that Person 1 wrote.

Hint: the function that you write will take in as parameters the data you want to display on the axes. To extract the data from the dataframe you're using, base R syntax is straightforward:

```r
# Set variable of interest, and use it to extract data
var.of.interest <- 'Petal.Length'
vector.of.interest <- iris[, var.of.interest]
```

