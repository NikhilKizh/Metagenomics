# beta-group-significance_Day
# metadata-column Day

qiime diversity beta-group-significance \
  --i-distance-matrix core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file metadata16S.tsv \
  --m-metadata-column Day  \
  --o-visualization core-metrics-results/beta-group-significance_Day.qzv \
  --p-pairwise
