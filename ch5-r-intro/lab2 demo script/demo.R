## this is my introduction!
name <- "Anni Yan"
age <- 21
favorite_color <- "green"
love_rainy_weather <- FALSE
love_my_students <- TRUE

Anni_in_50_years <- function(age){
  age <- age + 50
  cat("Anni is", age, "years old in 50 years :(")
  return (age)
}

new_age <- Anni_in_50_years(age)

print(age)

print(new_age)

if (favorite_color == "pink"){
  cat(name, "likes pink")
} else if (love_rainy_weather){
  cat(name, "loves Seattle weather")
} else {
  cat(name, "actually likes", favorite_color, "better and loves rainy weather is", love_rainy_weather)
}

ice.cream_size <- 1:3
ice.cream_price <- seq(1, 6)
ice.cream_flavor <- c("chocolate", "vanilla", "strawberry", "key lime pie")
print(ice.cream_size)
ice.cream_prize_increase <- c(1, 2)
new_price <- ice.cream_price + ice.cream_prize_increase
new_flavor <- c("maple walnut", "butter pecan")
new_ice_cream_flavor <- c(ice.cream_flavor, new_flavor)
