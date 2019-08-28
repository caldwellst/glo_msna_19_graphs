# Venn Diesel
# Installing up-to-date repositories for MSNI calculations/graphs and survey weighting
remotes::install_github("caldwellst/msni19")
remotes::install_github("caldwellst/surveyweights", ref = "dependencies")

# Loading in data frame and sampling frame
df <- readr::read_csv("data/msna_data.csv")
sampling_frame <- readr::read_csv("data/sampling_frame.csv")

# Building weighting function for data frame
weighting_function <- surveyweights::weighting_fun_from_samplingframe(sampling.frame = sampling_frame,
                                                                      data = df,
                                                                      sampling.frame.population.column ="population",
                                                                      sampling.frame.stratum.column = "LGA_pcode",
                                                                      data.stratum.column = "lga")

# venn diagram of households with any LSG >= 3 (REACH red) and those with capacity gaps >= 3 (REACH light grey)

msni19::venn_msni(df, fsl_lsg = "foodsec_index", health_lsg = "health_index", protection_lsg = "protection_index", shelter_lsg = "shelter_index",
          wash_lsg = "wash_index", education_lsg = "education_index", capacity_gaps = "coping_gap_index",
          weighting_function = weighting_function,
          print_plot = T,
          path = "graphs")
