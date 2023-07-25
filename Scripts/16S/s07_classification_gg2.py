# Taxonomy_Using_greengene2_database
# greengene2_database_Link :https://data.qiime2.org/classifiers/greengenes/gg_2022_10_backbone.v4.nb.qza

qiime feature-classifier classify-sklearn \
  --i-classifier gg_2022_10_backbone.v4.nb.qza \
  --i-reads 16S_rep_seqs_dada2.qza \
  --o-classification 16S_gg2_taxonomy.qza
