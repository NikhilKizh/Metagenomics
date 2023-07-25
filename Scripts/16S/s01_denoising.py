#Thesis
#Nikhil_Kizhakkepath
#Dr_Alexey_Larionov
#Soil_Metagenomics

# Trimming, Chimera removal and Denoising with Qiime2
# trim and trunc parameters reference : https://www.youtube.com/watch?v=181bMy9YB9I&list=PLbVDKwGpb3XmvnTrU40zHRT7NZWWVNUpt&index=13

#!/usr/bin/env qiime2

qiime dada2 denoise-paired \
  --i-demultiplexed-seqs s03_pe_dmx_trim.qza \
  --p-trim-left-f 0 \
  --p-trim-left-r 0 \ 
  --p-trunc-len-f 186 \
  --p-trunc-len-r 203 \
  --o-representative-sequences 16S_rep_seqs_dada2.qza \
  --o-table 16S_table_dada2.qza \
  --o-denoising-stats 16S_stats_dada2.qza


