# visualizing feature table metadata

qiime feature-table summarize \
  --i-table 16S_table_dada2.qza \
  --o-visualization 16S_table_dada2.qzv \
  --m-sample-metadata-file 16Smetadata.tsv
