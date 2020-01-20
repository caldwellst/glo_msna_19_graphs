# Test showing how to make sunburst graphs for NGA
# In order to save the sunburst graphs, then you need to have installed orca on your computer.
# Follow the instructions to install orca here: https://github.com/plotly/orca#installation

# Installing up-to-date repositories for MSNI calculations/graphs and survey weighting
remotes::install_github("caldwellst/msni19")
remotes::install_github("ellieallien/surveyweights")
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
# Test various sunburst plots

# 1 level
msni19::sunburst_msni(df, msni = "msni_nga", fsl_lsg = "foodsec_index", health_lsg = "health_index", protection_lsg = "protection_index", shelter_lsg = "shelter_index",
                      wash_lsg = "wash_index", capacity_gaps = "coping_gap_index", impact = "impact_index",
                      weighting_function = weighting_function,
                      print_plot = T,
                      plot_name = "general_sunburst",
                      path = "graphs")

# Add the FSL branch
msni19::sunburst_msni(df, msni = "msni_nga", fsl_lsg = "foodsec_index", health_lsg = "health_index", protection_lsg = "protection_index", shelter_lsg = "shelter_index",
                      wash_lsg = "wash_index", capacity_gaps = "coping_gap_index", impact = "impact_index", 
                      fsl_wash_branch = T,
                      weighting_function = weighting_function,
                      print_plot = T,
                      plot_name = "full_sunburst",
                      path = "graphs")

# Only for households with MSNI >= 4
msni19::sunburst_msni(df, msni = "msni_nga", fsl_lsg = "foodsec_index", health_lsg = "health_index", protection_lsg = "protection_index", shelter_lsg = "shelter_index",
                      wash_lsg = "wash_index", capacity_gaps = "coping_gap_index", impact = "impact_index", msni_filter = c(4, 5),
                      weighting_function = weighting_function,
                      print_plot = T,
                      plot_name = "severe_msni_sunburst",
                      path = "graphs")

# Only for non-displaced households
msni19::sunburst_msni(dplyr::filter(df, group == "non_displaced"), msni = "msni_nga", fsl_lsg = "foodsec_index", health_lsg = "health_index", protection_lsg = "protection_index", shelter_lsg = "shelter_index",
                      wash_lsg = "wash_index", capacity_gaps = "coping_gap_index", impact = "impact_index",
                      weighting_function = weighting_function,
                      print_plot = T,
                      plot_name = "non_displaced_sunburst",
                      path = "graphs")


# Do it in French!
msni19::sunburst_msni(df, msni = "msni_nga", fsl_lsg = "foodsec_index", health_lsg = "health_index", protection_lsg = "protection_index", shelter_lsg = "shelter_index",
                      wash_lsg = "wash_index", capacity_gaps = "coping_gap_index", impact = "impact_index", 
                      fsl_wash_branch = T,
                      weighting_function = weighting_function,
                      print_plot = T,
                      plot_name = "french_sunburst",
                      path = "graphs",
                      language = "fr")

