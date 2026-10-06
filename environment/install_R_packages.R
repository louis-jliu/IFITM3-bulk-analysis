# Install the R packages used by the analysis scripts.
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install(c("DESeq2", "fgsea"), update = FALSE, ask = FALSE)
install.packages(c("dplyr", "ggplot2", "ggrepel", "rmeta"))
