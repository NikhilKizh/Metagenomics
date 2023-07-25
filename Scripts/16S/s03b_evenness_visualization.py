# evenness visualization

qiime diversity alpha-group-significance \
  --i-alpha-diversity core-metrics-results/evenness_vector.qza \
  --m-metadata-file metadata16S.tsv \
  --o-visualization core-metrics-results/evenness-group-significance.qzv
