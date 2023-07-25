# beta-group_significance by treatment

qiime diversity beta-group-significance \
  --i-distance-matrix core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file metadata16S.tsv \
  --m-metadata-column Treatment  \
  --o-visualization core-metrics-results/beta-group-significance_Treatment.qzv \
  --p-pairwise
