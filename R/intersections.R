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
                            print_plot = T,
                            plot_name = "intersection",
                            path = "graphs")
