# Bar chart for indices
# Installing up-to-date repositories for MSNI calculations/graphs and survey weighting
remotes::install_github("caldwellst/msni19")
remotes::install_github("caldwellst/surveyweights", ref = "dependencies")
if (!require("processx")) install.packages("processx")

# Loading in data frame and sampling frame
df <- readr::read_csv("data/msna_data.csv")
sampling_frame <- readr::read_csv("data/sampling_frame.csv")

# Building weighting function for data frame
weighting_function <- surveyweights::weighting_fun_from_samplingframe(sampling.frame = sampling_frame,
                                                                      data = df,
                                                                      sampling.frame.population.column ="population",
                                                                      sampling.frame.stratum.column = "LGA_pcode",
                                                                      data.stratum.column = "lga")

# MSNI graph

msni19::severity_bar_chart(df,
                           group = "group",
                           group_order = c("idp", "returnee", "non_displaced"),
                           group_labels = c("IDPs", "Returnees", "Non-displaced"),
                           index = "msni_nga", 
                           index_max = 4,
                           weighting_function = weighting_function,
                           print_plot = T,
                           plot_name = "msni_bar",
                           path = "graphs")

# FSL graph

msni19::severity_bar_chart(df,
                           group = "group",
                           group_order = c("idp", "returnee", "non_displaced"),
                           group_labels = c("IDPs", "Returnees", "Non-displaced"),
                           index = "foodsec_index", 
                           index_max = 4,
                           index_type = "lsg",
                           weighting_function = weighting_function,
                           print_plot = T,
                           plot_name = "fsl_bar",
                           path = "graphs")
# Impact graph

msni19::severity_bar_chart(df,
                           group = "group",
                           group_order = c("idp", "returnee", "non_displaced"),
                           group_labels = c("IDPs", "Returnees", "Non-displaced"),
                           index = "foodsec_index", 
                           index_max = 4,
                           index_type = "lsg",
                           weighting_function = weighting_function,
                           print_plot = T,
                           plot_name = "impact_bar",
                           path = "graphs")
