# beta-group-significance Replicate
# metadata-column_Replicate

qiime diversity beta-group-significance \
  --i-distance-matrix core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file metadata16S.tsv \
  --m-metadata-column Replicate  \
  --o-visualization core-metrics-results/beta-group-significance_Replicate.qzv \
  --p-pairwise
