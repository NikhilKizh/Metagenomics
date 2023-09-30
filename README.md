**#Thesis Soil Metagenomics**


**#16S Amplicon Sequencing Pipeline**


This pipeline inputs raw illumina paired-end fastq sequences , checks for quality using fastqc/multiqc, trims adapter and primer sequences, performs denoising using DADA2 alogorithm, generates phylogenetic tree, perform taxonomic classification of features using pre trained Naive Bayes classifier from greengenes2 dtabase performs rarefaction, calculate alpha and beta diversity and statistically validate the results using PERMANOVA and ANCOM analysis.


**Prerequisites**

Paired-end illumina fastq files
[QIIME2](https://docs.qiime2.org/2023.7/install/)



