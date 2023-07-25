# Taxonomy_barplot_greengene2

qiime taxa barplot \
  --i-table 16S_table_dada2.qza \
  --i-taxonomy 16S_gg2_taxonomy.qza  \
  --m-metadata-file metadata16S.tsv \
  --o-visualization 16S_gg2_taxa-bar-plots.qzv
