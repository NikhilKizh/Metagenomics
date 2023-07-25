# Emperor-plot_Day
# custom-axes_Day

qiime emperor plot \
  --i-pcoa core-metrics-results/unweighted_unifrac_pcoa_results.qza \
  --m-metadata-file metadata16S.tsv \
  --p-custom-axes Day \
  --o-visualization core-metrics-results/unweighted-unifrac-emperor-Day.qzv
