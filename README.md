# MSNA 2019 Factsheet Graphs

## Intro

Hello! It looks like you're interested in making graphs for your 2019 MSNI factsheets. Since we both share the same passion, I'm here to help you on this beautiful journey. In this repository you will find working examples of all the graphs you need for these factsheets, using data from Nigeria as an example. The R code to generate the graphs is all in the `R` folder, with the data inputs in `data`, and visualization outputs in `graphs`.

I hope that these examples help you to replicate these visualizations for your country in an easy and pain free manner! Follow below the setup to ensure this process is as painless as possible.

## Setup

The graphing relies almost entirely on the [msni19](https://github.com/caldwellst/msni19) package, without needing much else beyond the installation of other packages. You can install the latest version of this by running: `remotes::install_github("caldwellst/msni19")`

The exception to this is saving the sunburst graphs, since they rely on the plotly library. In order to save these graphs, you need to have the orca command line utility installed. Please follow the instructions [here](https://github.com/plotly/orca#installation). This includes following the instructions to add orca to your PATH. You will also need the `processx` R library installed. This is recommended in the `msni19` package but not required, so won't install automatically. Go ahead and run `install.packages("processx")` if you expect to be creating sunburst graphs.

## Graphing!

The functions for graphing in `msni19` are designed to be used to create plots in the R graphic console, and also to save plots to PDF when they're ready. All functions take the argument `print_plot` which can be either `TRUE` or `FALSE`. If `FALSE`, it will only return a plot that you can save to a variable in R or view in the R console. If `TRUE`, it will create a plot object as before, but also print the generated plot with whatever name and location you specify. In this way, you can test different types of graphs with `print_plot = FALSE` until you are satisfied with the graph, and then only once have to run with `print_plot = TRUE`. Similarly, you could manually save the plot using any methods available for that object in R (`ggsave()`, `pdf()`, or `orca()`.

You should be ready to start graphing on your own now. If you seem to fail in replicating a certain graph, check the documentation for the specific msni19 function (`?msni19::function_name`), and see if that clears it up. However, if you still have trouble, please reach out to me here or on Skype (caldwellst or the MSNA 19 R group).

