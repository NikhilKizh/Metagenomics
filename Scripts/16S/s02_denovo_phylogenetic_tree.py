# generating de-novo phylogenetic tree

qiime phylogeny align-to-tree-mafft-fasttree \
  --i-sequences 16S_rep_seqs_dada2.qza \
  --o-alignment 16S_aligned-rep-seqs.qza \
  --o-masked-alignment 16S_masked-aligned-rep-seqs.qza \
  --o-tree 16S_unrooted-tree.qza \
  --o-rooted-tree 16S_rooted-tree.qza
