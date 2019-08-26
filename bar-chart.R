# All bar none

devtools::install_github("caldwellst/msni19", ref = "sunburst")

df <- readr::read_csv("msna_data.csv")

# MSNI graph

msni19::severity_bar_chart(df, index = "msni_nga", index_max = 5)
