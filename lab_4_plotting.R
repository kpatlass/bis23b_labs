# lab 4: R script
## making a plot

if (!require(ggplot2, quietly = TRUE)) {
  install.packages("ggplot2")}

library(ggplot2)

if (!require(tidyverse, quietly = TRUE)) {
  install.packages("tidyverse")}

library(tidyverse)


source("bis23b_scripts-main/contig_length_function.R")

readFastaAndGetLengths("megahit_out/final.contigs.fa")

getwd()

contig_len_df <- readFastaAndGetLengths("megahit_out/final.contigs.fa")

# Sort data frame by decreasing length, using order() function
contig_len_df_decreasing <- contig_len_df[order(-contig_len_df$Length), ]

# Plot using ggplot2
contigs_plot <- contig_len_df_decreasing %>% 
    filter(Length>1000) %>% 
  ggplot(aes(x = reorder(Contig, Length), y = Length)) +
  geom_col() +
  labs(x = "Contig", y = "Length (bp)", title = "Contig Length Distribution") +
  theme_minimal() +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) # Hide x-axis labels for clarity
contigs_plot 

ggsave("contig_len_1k.png", plot=contigs_plot, width=6, height=4, dpi = 300)