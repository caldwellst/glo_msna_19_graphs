# Spider / radar graphs

remotes::install_github("caldwellst/msni19", ref = "sunburst")

df <- readr::read_csv("msna_data.csv")

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
                                   "Emergency Shelter\nand NFI",
                                   "Food Security and\nAgriculture",
                                   "Health",
                                   "Protection",
                                   "WASH"),
                    group = "group",
                    group_labels = c("IDPs", "Non-displaced", "Returnees"),
                    print_plot = T,
                    plot_name = "radar.pdf",
                    path = "graphs")

# Radar graph w/ impact index mimicking Nutrition as an example
# Change the labels as necessary to get them to fit in a standard plot
# You can also adjust the label and legend text size as needed, and move the location of the legend

nutrition <- msni19::radar_graph(df, 
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
                                 group_labels = c("IDPs", "Non-displaced", "Returnees"),
                                 legend_position = "left",
                                 print_plot = T,
                                 plot_name = "nutrition_radar.pdf",
                                 path = "graphs")
