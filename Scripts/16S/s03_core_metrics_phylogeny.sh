# core metrics calculation: Phylogeny
# sampling depth 44300

qiime diversity core-metrics-phylogenetic \
  --i-phylogeny 16S_rooted-tree.qza \ 
  --i-table 16S_table_dada2.qza \
  --p-sampling-depth 44300 \
  --m-metadata-file 16Smetadata.tsv \ 
  --output-dir core-metrics-results
