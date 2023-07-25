# Emperor-plot_Replicate
# custom-axes_Replicate

qiime emperor plot \
  --i-pcoa core-metrics-results/unweighted_unifrac_pcoa_results.qza \
  --m-metadata-file metadata16S.tsv \
  --p-custom-axes Replicate \
  --o-visualization core-metrics-results/unweighted-unifrac-emperor-Replicate.qzv
