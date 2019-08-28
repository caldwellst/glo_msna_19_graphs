# Severity line graph (# of sector severity scores >= 3)

remotes::install_github("caldwellst/msni19", ref = "sunburst")

df <- readr::read_csv("msna_data.csv")

lsg <- c("health_index", "foodsec_index", "protection_index",
         "shelter_index", "education_index", "wash_index")

msni19::severity_lines(df,
                       lsg,
                       group = "group",
                       group_order = c("idp", "returnee", "non_displaced"),
                       group_labels = c("IDPs", "Returnees", "Non-displaced"),
                       print_plot = T,
                       plot_name = "severity_lines",
                       path = "graphs")
