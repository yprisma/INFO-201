# 8.  Build you own app

## Overview

RStudio's shiny framework provides a straightforward structure for
creating not just websites, but web applications. By providing R users
with the ability to generate web-based interfaces that communicate
with R servers, shiny enables developers to create dynamic platforms
for data exploration.

The purpose of this assignment is to provide you with the opportunity
to practice building a shiny application. Once you are comfortable
with the general skeleton of these applications, transforming your
analyses into interactive experiences will be nearly painless.

## The Data

For this assignment, you'll be using the cereal dataset, a common
dataset in the visualization world. The data was downloaded from
[cmu.edu](http://lib.stat.cmu.edu/DASL/Datafiles/Cereals.html)
into a tab
separated file. Each of the 77 rows of this data is a cereal type, and
the columns express different nutritional information of the cereal:

1. Name: Name of cereal
1. mfr: Manufacturer of cereal where A = American Home Food Products;
   G = General Mills; K = Kelloggs; N = Nabisco; P = Post; Q = Quaker
   Oats; R = Ralston Purina
1. type: cold or hot
1. calories: calories per serving
1. protein: grams of protein
1. fat: grams of fat
1. sodium: milligrams of sodium
1. fiber: grams of dietary fiber
1. carbo: grams of complex carbohydrates
1. sugars: grams of sugars
1. potass: milligrams of potassium
1. vitamins: vitamins and minerals - 0, 25, or 100, indicating the
   typical percentage of FDA recommended
1. shelf: display shelf (1, 2, or 3, counting from the floor)
1. weight: weight in ounces of one serving
1. cups: number of cups in one serving
1. rating: a rating of the cereals


## Assignment Structure

As with previous assignments,
[follow this link](https://classroom.github.com/a/vaINPyov) to create
your own private repository for this assignment (well, if you are
reading this readme you probably already did it).  This will
automatically create a private repository which you will submit to
Canvas as your assignment.  Note this is an individual assigment, so
you have to create your own repo.


### Complete the following steps:

For this assignment, you build your own shiny application. The
application should provide users with the ability to interact with a
visual representation of the cereal dataset. What the application
looks like is up to you, as long as it meets the following
requirements:

* There is a sidePanel in which you've created at least two widgets
  that change the visual output in your application, such as data
  displayed on the x or y axis of a scatterplot.
* One of your widgets must change the data that is being
  displayed. For example, the attribute being shown on the x or y
  axis. While changing the color of all markers (from, say, red to
  blue) would not meet this requirement, changing the data driving the
  color of each point would (i.e., color by hot/cold cereal or by
  manufacturer)
* You must create a visual representation of a dataset that reacts to
  the widgets in the sidePanel
* You must push your application up to the shinyapps.io server, making
  it publicly usable

For this application, use the multiple-file setup (i.e both ui.R and
server.R):

* A ui.R file, that drives the structure of the user interface
* A server.R file, that provides instructions to the R server
* You should also create a Readme.md file that contains a brief "user
  documentation" of your project: a brief description of the data, and
  explanation what are the widgets and panels doing.  This
  file should contain a link to your project.

The purpose of this project really is just to make sure you're
comfortable with the structure of a web application. Feel free to be
creative in your assignment, although a scatter-plot with 2 widgets
controlling the x variable and y variable is sufficient.

### sidePanel

In your sidePanel, you should create two widgets of your choice. As
stated above in the requirements, at least one of these widgets should
change the data being displayed.  Feel free to use whichever types of
widgets you want, as long as they update the visual representation of
the data.

### Visual representation

The mainPanel of your application should contain a visual
representation of the cereal dataset. The visualization can be made
with base R graphics, ggplot2, [plotly](https://plot.ly/r/), or
something [more interesting](https://github.com/juba/scatterD3).
While we don't expect you to create anything ground-breaking, we do
expect you to create a clear visualization with proper labels and
titles. And of course, the graphic needs to react to changing values
in the widgets.


## Submission

As with the previous assignment, you should add and commit your
changes using git, and push your assignment to GitHub. In your
README.md file, please include a link to your shiny hosted
application. You have to submit the URL of your repository to
canvas--this is your submission.


## Expectations

At this point in the quarter, we expect you to be following the best
practices we've incorporated into the class. This means:

* Proper use of libraries such as _dplyr_ for data wrangling
* Structuring your code so that if the data changes, you can easily
  update your entire application
* Clearly commenting and properly organizing your code
* Writing functions to encapsulate chunks of code that you use more
  than once
* Avoiding variables that are unnecessary for your analysis/report
* Creating appropriate labels for your visualizations


## LINK TO SHINYAPP.io
https://rgpeart.shinyapps.io/cereals/
