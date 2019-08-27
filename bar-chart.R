# All bar none

devtools::install_github("caldwellst/msni19", ref = "sunburst")

df <- readr::read_csv("msna_data.csv")

# MSNI graph

msni19::severity_bar_chart(df,
                           group = "group",
                           group_order = c("idp", "returnee", "non_displaced"),
                           group_labels = c("IDPs", "Returnees", "Non-displaced"),
                           index = "msni_nga", 
                           index_max = 4,
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
                           print_plot = T,
                           plot_name = "impact_bar",
                           path = "graphs")
