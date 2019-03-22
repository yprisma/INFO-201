# Exercise 1: Creating and Indexing Vectors

# Create a vector `first.ten` that has the values 10 through 20 in it (using the : operator)

first.ten <- 10:20

# Create a vector `next.ten` that has the values 21 through 30 in it (using the seq operator)

next.ten <- seq(21, 30)

# Create a vector `all.numbers` by combining the vectors `first.ten` and `next.ten`

all.numbers <- c(first.ten, next.ten)

# Create a variable `eleventh` that is equal to the 11th element in your vector `all.numbers`

eleventh <- all.numbers[11]

# Create a vector `some.numbers` that is equal to the second through the 5th elements of `all.numbers`

some.numbers <- all.numbers[2:5]

# Create a variable `len` that is equal to the length of your vector `all.numbers`

len <- length(all.numbers)

### Bonus ###

# Create a vector `odd` that holds the odd numbers from 1 to 100

numbers <- 1:100
odd <- numbers[numbers %% 2 == 1]

# Using the `all` and `%%` operators, confirm that all of the numbers in your `odd` vector are odd

all(odd %% 2 == 1)
