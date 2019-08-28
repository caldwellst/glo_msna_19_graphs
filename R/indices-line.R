# Bar chart for indices
# Installing up-to-date repositories for MSNI calculations/graphs and survey weighting
remotes::install_github("caldwellst/msni19")
remotes::install_github("caldwellst/surveyweights", ref = "dependencies")
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

severity_bar_chart <- function(df,
                               group = "group",
                               group_order = NULL,
                               group_labels = NULL,
                               index = "msni",
                               index_max = 4,
                               index_type = "msni",
                               weighting_function = NULL,
                               bar_graph = T,
                               print_plot = F,
                               plot_name = "severity_bar_chart",
                               path = NULL) {
  
  df <- df %>%
    group_by(!!sym(group)) %>%
    filter(!is.na(!!sym(index)))
  
  if (is.null(weighting_function)) {
    df$weights <- rep(1, nrow(df))
  } else {
    df$weights <- weighting_function(df)
  }
  
  data <- df %>% summarize(index_1 = 100 * sum((!!sym(index) == 1) * weights) / sum(weights),
                           index_2 = 100 * sum((!!sym(index) == 2) * weights) / sum(weights),
                           index_3 = 100 * sum((!!sym(index) == 3) * weights) / sum(weights),
                           index_4 = 100 * sum((!!sym(index) == 4) * weights) / sum(weights),
                           index_4_plus = sum((!!sym(index) > 4) * weights) / sum(weights)) %>%
    gather("score", "percent", -!!sym(group))
  
  if (!is.null(group_order)) {
    data <- mutate(data, !!sym(group) := factor(!!sym(group), levels = group_order))
  }
  
  index_fill <- c("#F7ACAC", "#FACDCD", "#A7A9AC", "#58585A")
  if (index_type == "msni") {
    index_labels <- c("Extreme (4)", "Severe (3)", "Stress (2)", "Minimal (1)")
  } else {
    index_labels <- c("Extreme", "Severe", "Stress", "Minimal")
  }
  
  
  if (index_max == 5) {
    index_fill <- c("#EE5A59", index_fill)
    if (index_type == "msni") {
      index_labels <- c("Extreme+ (4+)", index_labels)
    } else {
      index_labels <- c("Catastrophic", index_labels)
    }
    
  } else {
    data <- filter(data, score != "index_4_plus")
  }
  print(data)
  
  if (bar_graph == T) {
    p <- ggplot(data = data, aes(x = !!sym(group), y = percent)) + 
      geom_bar(aes(fill = forcats::fct_rev(score)), stat = "identity") +
      labs(fill = "", x = "", y = "") + theme_minimal() +
      scale_fill_manual(values = index_fill,
                        labels = index_labels) +
      scale_y_continuous(labels = scales::percent_format(accuracy = 1, scale = 1))
    if (!is.null(group_labels)) {
      p <- p + scale_x_discrete(labels = group_labels)
    }
    
    p <- p + coord_flip()
  } else if (bar_graph == F) {
    p <- ggplot(data = data, aes(x = score, y = percent, group = !!sym(group))) +
      geom_line(aes(color = !!sym(group)), size = 1.3) +
      geom_point(aes(color = !!sym(group))) +
      theme_minimal() +
      theme(legend.title = element_blank()) +
      scale_y_continuous("", labels = function(x) scales::percent(x, accuracy = 1, scale = 1)) +
      scale_x_discrete("", labels = rev(index_labels))
    
    if (!is.null(group_labels)) {
      p <- p + scale_color_manual(labels = group_labels,
                                  values = c("#EE5859",
                                             "#58585A",
                                             "#D1D3D4",
                                             "#D2CBB8",
                                             "#A9C5A1",
                                             "#FFF67A",
                                             "#F69E61",
                                             "#95A0A9",
                                             "#56B3CD"))
    } else {
      p <- p + scale_color_manual(values = c("#EE5859",
                                             "#58585A",
                                             "#D1D3D4",
                                             "#D2CBB8",
                                             "#A9C5A1",
                                             "#FFF67A",
                                             "#F69E61",
                                             "#95A0A9",
                                             "#56B3CD"))
    }
  }
  
  
  
  if (print_plot) {
    ggsave(paste0(plot_name, ".pdf"), plot = p, path = path, height = length(unique(df[[group]])))
  }
  
  p
}

# MSNI graph

severity_bar_chart(df,
                           group = "group",
                           group_order = c("idp", "returnee", "non_displaced"),
                           group_labels = c("IDPs", "Returnees", "Non-displaced"),
                           index = "msni_nga", 
                           index_max = 4,
                           weighting_function = weighting_function,
                           print_plot = T,
                           plot_name = "msni_bar",
                           path = "graphs",
                   bar_graph = F)

# FSL graph

msni19::severity_bar_chart(df,
                           group = "group",
                           group_order = c("idp", "returnee", "non_displaced"),
                           group_labels = c("IDPs", "Returnees", "Non-displaced"),
                           index = "foodsec_index", 
                           index_max = 4,
                           index_type = "lsg",
                           weighting_function = weighting_function,
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
                           weighting_function = weighting_function,
                           print_plot = T,
                           plot_name = "impact_bar",
                           path = "graphs")
