# diversity_alpha_rarefaction_plots
# pmax_depth = median =86000

qiime diversity alpha-rarefaction \
  --i-table 16S_table_dada2.qza \
  --i-phylogeny 16S_rooted-tree.qza \
  --p-max-depth 86000 \
  --m-metadata-file metadata16S.tsv \
  --o-visualization 16S_alpha-rarefaction.qzv
