# Severity line graph (# of sector severity scores >= 3)
# Installing up-to-date repositories for MSNI calculations/graphs and survey weighting
remotes::install_github("caldwellst/msni19")
remotes::install_github("ellieallien/surveyweights")

# Loading in data frame and sampling frame
df <- readr::read_csv("data/msna_data.csv")
sampling_frame <- readr::read_csv("data/sampling_frame.csv")

# Building weighting function for data frame
weighting_function <- surveyweights::weighting_fun_from_samplingframe(sampling.frame = sampling_frame,
                                       data = df,
                                       sampling.frame.population.column ="population",
                                       sampling.frame.stratum.column = "LGA_pcode",
                                       data.stratum.column = "lga")

# Listing column names for living standard gap indices
lsg <- c("health_index", "foodsec_index", "protection_index",
         "shelter_index", "education_index", "wash_index")

# Making graph of % of households by # of indices that are >= 3
msni19::severity_lines(df,
                       lsg,
                       group = "group",
                       group_order = c("idp", "returnee", "non_displaced"),
                       group_labels = c("IDPs", "Returnees", "Non-displaced"),
                       weighting_function = weighting_function,
                       print_plot = T,
                       plot_name = "severity_lines",
                       path = "graphs")
