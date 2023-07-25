# faith-pd visualisation

qiime diversity alpha-group-significance \
  --i-alpha-diversity core-metrics-results/faith_pd_vector.qza \
  --m-metadata-file 16Smetadata.tsv \
  --o-visualization core-metrics-results/faith-pd-group-significance.qzv
