# !/bin/bash
# QIIME2 - taxonomy_barplot
# Alexey Larionov 12Jun2023
# Nikhil Kizhakkepath 20Jun2023
# Requires environment with QIIME2 

# Crescent2 script
# Note: this script should be run on a compute node
# qsub s10_q2_taxonomy_barplot.sh

# PBS directives
#---------------

#PBS -N s10_q2_taxonomy_barplot
#PBS -l nodes=1:ncpus=12
#PBS -l walltime=01:00:00
#PBS -q one_hour
#PBS -m abe
#PBS -M nikhil.kizhakkepath.312@cranfield.ac.uk

#===============
#PBS -j oe
#PBS -v "CUDA_VISIBLE_DEVICES="
#PBS -W sandbox=PRIVATE
#PBS -k n
ln -s $PWD $PBS_O_WORKDIR/$PBS_JOBID
## Change to working directory
cd $PBS_O_WORKDIR
## Calculate number of CPUs and GPUs
export cpus=`cat $PBS_NODEFILE | wc -l`
## Load production modules
module use /apps/modules/all
## =============

# Stop at runtime errors
set -e

# Load required module
module load QIIME2/2022.11
qiime --version

# Start message
echo "QIIME2: taxonomy_barplot"
date
echo ""


# Folders
base_folder="/mnt/beegfs/home/s394312/metagenomics/thesis/16S"
results_folder="${base_folder}/results"
resources_folder="${base_folder}/resources"

# Assign taxonomy to sequences
qiime feature-classifier classify-sklearn \
--i-classifier "${resources_folder}/2022.10.backbone.v4.nb.qza" \
--i-reads "${results_folder}/s04_rep_seqs_dada2.qza" \
--o-classification "${results_folder}/s10_taxonomy.qza"

# Show taxonimies assigned to each ASV
qiime metadata tabulate \
--m-input-file "${results_folder}/s10_taxonomy.qza" \
--o-visualization "${results_folder}/s10_taxonomy.qzv"

# Make taxonomy barplot
qiime taxa barplot \
--i-table "${results_folder}/s06b_rarefied_table.qza" \
--i-taxonomy "${results_folder}/s10_taxonomy.qza" \
--m-metadata-file "samples.txt" \
--o-visualization "${results_folder}/s10_taxa_bar_plot.qzv"

# Completion message
echo ""
echo "Done"
date
