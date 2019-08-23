# Test showing how to make sunburst graphs for NGA

devtools::install_github("caldwellst/msni19", ref = "sunburst")

df <- readr::read_csv("msna_data_test.csv")

# Test various sunburst plots

p <- msni19::sunburst_msni(df, msni = "msni_nga", fsl_lsg = "foodsec_index", health_lsg = "health_index", protection_lsg = "protection_index", shelter_lsg = "shelter_index",
              wash_lsg = "wash_index", capacity_gaps = "coping_gap_index", impact = "impact_index")

q <- msni19::sunburst_msni(df, msni = "msni_nga", fsl_lsg = "foodsec_index", health_lsg = "health_index", protection_lsg = "protection_index", shelter_lsg = "shelter_index",
                      wash_lsg = "wash_index", capacity_gaps = "coping_gap_index", impact = "impact_index", fsl_wash_branch = T)

r <- msni19::sunburst_msni(df, msni = "msni_nga", fsl_lsg = "foodsec_index", health_lsg = "health_index", protection_lsg = "protection_index", shelter_lsg = "shelter_index",
                           wash_lsg = "wash_index", capacity_gaps = "coping_gap_index", impact = "impact_index", msni_filter = c(4, 5))

s <- msni19::sunburst_msni(dplyr::filter(df, group == "non_displaced"), msni = "msni_nga", fsl_lsg = "foodsec_index", health_lsg = "health_index", protection_lsg = "protection_index", shelter_lsg = "shelter_index",
                           wash_lsg = "wash_index", capacity_gaps = "coping_gap_index", impact = "impact_index")

# Viewing the various plots to test

p # general sunburst for all HHs with MSNI >= 3 (default)
q # sunburst with additional branch for FSL / WASH
r # sunburst for households with MSNI >= 4
s # sunburst for non displaced households with MSNI >= 3 

# Saving the ones I want! In order to save this, then you need to have installed orca on your computer.
# Follow the instructions to install orca here: https://github.com/plotly/orca#installation

plotly::orca(p, "general_sunburst.pdf")
plotly::orca(q, "full_sunburst.pdf")
plotly::orca(r, "severe_msni_sunburst.pdf")
plotly::orca(r, "non_displaced_sunburst.pdf")
