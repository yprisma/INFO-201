# Exercise 2: writing and executing functions (II)

# Write a function `CompareLength` that takes in 2 vectors, and returns the sentence:
# "The difference in lengths is N"

CompareLength <- function(v1, v2) {
  N <- length(v1) - length(v2)
  return(cat("The difference in lengths is: ", N))
}

# Pass two vectors of different length to your `CompareLength` function

CompareLength(c(2, 4, 7), c(1, 3, 5))

# Write a function `DescribeDifference` that will return one of the following statements:
# "Your first vector is longer by N elements"
# "Your second vector is longer by N elements"

DescribeDifference <- function(v1, v2) {
  N <- abs(length(v1) - length(v2))
  if(length(v1) > length(v2)) {
    return(cat("Your first vector is longer by", N, "element(s)"))
  }else {
    return(cat("Your second vector is longer by ", N, "element(s)"))
  }
}

# Pass two vectors to your `DescribeDifference` function

DescribeDifference(c(1, 2, 3, 4), c(1, 2, 3))

### Bonus ###

# Rewrite your `DescribeDifference` function to tell you the name of the vector which is longer
DescribeDifference2 <- function(v1, v2) {
  N <- abs(length(v1) - length(v2))
  if(length(v1) > length(v2)) {
    return(cat("Your first vector is longer than the second"))
  }else if(length(v1) < length(v2)) {
    return(cat("Your second vector is longer than the first"))
  }else {
    return(cat("Both vectors are of equal length!"))
  }
}

DescribeDifference2(c(1, 2, 3, 4), c(1, 2, 3))
DescribeDifference2(c(1, 2, 3, 4, 5), c(2, 3, 4, 5, 5, 3, 5))
DescribeDifference2(c(0), c(0))
