# Venn Diesel

remotes::install_github("caldwellst/msni19", ref = "sunburst")


df <- readr::read_csv("msna_data.csv")

# venn diagram of households with any LSG >= 3 (REACH red) and those with capacity gaps >= 3 (REACH light grey)

msni19::venn_msni(df, fsl_lsg = "foodsec_index", health_lsg = "health_index", protection_lsg = "protection_index", shelter_lsg = "shelter_index",
          wash_lsg = "wash_index", education_lsg = "education_index", capacity_gaps = "coping_gap_index",
          print_plot = T,
          path = "graphs")
