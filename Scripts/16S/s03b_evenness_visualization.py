# evenness visualization

qiime diversity alpha-group-significance \
  --i-alpha-diversity core-metrics-results/evenness_vector.qza \
  --m-metadata-file 16Smetadata.tsv \
  --o-visualization core-metrics-results/evenness-group-significance.qzv
