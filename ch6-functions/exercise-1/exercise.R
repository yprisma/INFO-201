## Exercise 1: writing and executing functions

## Write a function `AddThree` that adds 3 to an input value

AddThree <- function(inputValue) {
   return(inputValue + 3)
}

## Create a variable `ten` by passing 7 to your `AddThree` function

ten <- AddThree(7)

## Write a function `FeetToMeters` that converts from feet to meters
## 
## Note: if you come with metric background, you may want to do the following three questions
## in the opposite way: create function 'metersToFeet' and compute you height in feet below

FeetToMeters <- function(feet) {
  return(feet * .3048)
}

metersToFeet <- function(meters) {
  return(meters * 3.28084)
}

## Create a variable `height.in.feet` that is your height in feet

height.in.feet <- 5.75

## Create a variable `height.in.meters` by passing `height.in.feet` to your `FeetToMeters` function

height.in.meters <- FeetToMeters(height.in.feet)
