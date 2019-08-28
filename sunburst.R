# Test showing how to make sunburst graphs for NGA
# In order to save the sunburst graphs, then you need to have installed orca on your computer.
# Follow the instructions to install orca here: https://github.com/plotly/orca#installation

remotes::install_github("caldwellst/msni19", ref = "sunburst")
if (!require("processx")) install.packages("processx")

df <- readr::read_csv("msna_data.csv")

# Test various sunburst plots

msni19::sunburst_msni(df, msni = "msni_nga", fsl_lsg = "foodsec_index", health_lsg = "health_index", protection_lsg = "protection_index", shelter_lsg = "shelter_index",
                      wash_lsg = "wash_index", capacity_gaps = "coping_gap_index", impact = "impact_index",
                      print_plot = T,
                      plot_name = "general_sunburst",
                      path = "graphs")

msni19::sunburst_msni(df, msni = "msni_nga", fsl_lsg = "foodsec_index", health_lsg = "health_index", protection_lsg = "protection_index", shelter_lsg = "shelter_index",
                      wash_lsg = "wash_index", capacity_gaps = "coping_gap_index", impact = "impact_index", fsl_wash_branch = T,
                      print_plot = T,
                      plot_name = "full_sunburst",
                      path = "graphs")

msni19::sunburst_msni(df, msni = "msni_nga", fsl_lsg = "foodsec_index", health_lsg = "health_index", protection_lsg = "protection_index", shelter_lsg = "shelter_index",
                      wash_lsg = "wash_index", capacity_gaps = "coping_gap_index", impact = "impact_index", msni_filter = c(4, 5),
                      print_plot = T,
                      plot_name = "severe_msni_sunburst",
                      path = "graphs")

msni19::sunburst_msni(dplyr::filter(df, group == "non_displaced"), msni = "msni_nga", fsl_lsg = "foodsec_index", health_lsg = "health_index", protection_lsg = "protection_index", shelter_lsg = "shelter_index",
                      wash_lsg = "wash_index", capacity_gaps = "coping_gap_index", impact = "impact_index",
                      print_plot = T,
                      plot_name = "non_displaced_sunburst",
                      path = "graphs")
