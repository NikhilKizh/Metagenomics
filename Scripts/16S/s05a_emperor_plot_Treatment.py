# Emperor-plot_Treatment
# custom-axes_Treatment

qiime emperor plot \
  --i-pcoa core-metrics-results/unweighted_unifrac_pcoa_results.qza \
  --m-metadata-file metadata16S.tsv \
  --p-custom-axes Treatment \
  --o-visualization core-metrics-results/unweighted-unifrac-emperor-Treatment.qzv
