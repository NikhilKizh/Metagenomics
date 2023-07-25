# faith-pd visualisation

qiime diversity alpha-group-significance \
  --i-alpha-diversity core-metrics-results/faith_pd_vector.qza \
  --m-metadata-file metadata16S.tsv \
  --o-visualization core-metrics-results/faith-pd-group-significance.qzv
