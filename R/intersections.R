# Intersection graph
# Based on the great work of Eliora for the 2018 MSNAs!
# Installing up-to-date repositories for MSNI calculations/graphs and survey weighting
remotes::install_github("caldwellst/msni19")
remotes::install_github("ellieallien/surveyweights")
remotes::install_github("caldwellst/setviz")

# Loading in data frame and sampling frame
df <- readr::read_csv("data/msna_data.csv")
sampling_frame <- readr::read_csv("data/sampling_frame.csv")


# Building weighting function for data frame
weighting_function <- surveyweights::weighting_fun_from_samplingframe(sampling.frame = sampling_frame,
                                                                      data = df,
                                                                      sampling.frame.population.column ="population",
                                                                      sampling.frame.stratum.column = "LGA_pcode",
                                                                      data.stratum.column = "lga")
# Make that sweet graph of intersections
# Due to issues with printing the intersections plot, I recommend you try finding the scales
# that work best for you.

p <- msni19::index_intersections(df,
                            lsg =  c("education_index", "foodsec_index", "protection_index",
                                   "wash_index", "shelter_index", "health_index"),
                            lsg_labels = c("Education",
                                           "Shelter",
                                           "Food",
                                           "Health",
                                           "Protection",
                                           "WASH"),
                            weighting_function = weighting_function,
                            exclude_unique = F,
                            mutually_exclusive_sets = F,
                            round_to_1_percent = T,
                            print_plot = F)

# We print by using the base options for R
pdf("graphs/intersection.pdf", width = 5, height = 4)
p
dev.off()

# There is an error in the UpSetR package that means the last y axis label can be cut off
# The solution for now will need to be manually adjusting in the InDesign or PDF
# Or you can zoom in so close that number 0 disappears completely if it happens to you
