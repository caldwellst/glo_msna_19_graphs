# Radar / spider graphs
# Installing up-to-date repositories for MSNI calculations/graphs and survey weighting
remotes::install_github("caldwellst/msni19")
remotes::install_github("caldwellst/surveyweights", ref = "dependencies")
library(hypegrammaR)

# Loading in data frame and sampling frame
df <- readr::read_csv("data/msna_data.csv")
sampling_frame <- readr::read_csv("data/sampling_frame.csv")

# Building weighting function for data frame
weighting_function <- hypegrammaR::map_to_weighting(sampling.frame = sampling_frame,
                                                                      data = df,
                                                                      sampling.frame.population.column ="population",
                                                                      sampling.frame.stratum.column = "LGA_pcode",
                                                                      data.stratum.column = "lga")

# Radar graph w/o nutrition since not included Nigeria
# Play around with print_plot = F to get the graph looking good before printing to PDF
msni19::radar_graph(df, 
                    lsg = c("education_index", 
                            "shelter_index", 
                            "foodsec_index", 
                            "health_index", 
                            "protection_index",
                            "wash_index"),
                    lsg_labels = c("Education in\nEmergency",
                                   "Emergency\nShelter\nand NFI",
                                   "Food Security and\nAgriculture",
                                   "Health",
                                   "Protection",
                                   "WASH"),
                    group = "group",
                    group_labels = c("IDPs", "Non-displaced", "Returnees"),
                    weighting_function = weighting_function,
                    print_plot = T,
                    plot_name = "radar",
                    path = "graphs")

# Radar graph w/ impact index mimicking Nutrition as an example
# Change the labels as necessary to get them to fit in a standard plot
# You can also adjust the label and legend text size as needed, and move the location of the legend

msni19::radar_graph(df, 
                    lsg = c("education_index", 
                            "shelter_index", 
                            "foodsec_index", 
                            "health_index", 
                            "protection_index",
                            "wash_index",
                            "impact_index"),
                    lsg_labels = c("Education in\nEmergency",
                                   "Emergency Shelter\n& NFI",
                                   "Food Security\n& Agriculture",
                                   "Health",
                                   "Protection",
                                   "WASH",
                                   "Nutrition"),
                    group = "group",
                    group_order = c("returnee", "idp", "non_displaced"),
                    group_labels = c("Returnees", "IDPs", "Non-displaced"),
                    weighting_function = weighting_function,
                    legend_position = "left",
                    print_plot = T,
                    plot_name = "nutrition_radar",
                    path = "graphs")
