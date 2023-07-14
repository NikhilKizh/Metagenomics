#!/bin/bash
# QIIME2 - Denoise
# Alexey Larionov, Nov2022
# Nikhil Kizhakkepath jun2023
# Requires environment with QIIME2 

# Crescent2 script ITS
# Note: this script should be run on a compute node
# qsub s06a_q2_rarefraction_plot.sh

# PBS directives
#---------------

#PBS -N s06a_q2_rarefaction_plot.sh
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

# Stop at runtime errors
set -e

# Load required module
module load QIIME2/2022.11
qiime --version

# Start message
echo "QIIME2: Denoise"
date
echo ""

# Folders
base_folder="/mnt/beegfs/home/s394312/metagenomics/thesis/ITS"
results_folder="${base_folder}/results"


# Alpha rarefaction
# Max-depth based on max non-chimeric reads in s04_stats_dada2.qzv
# Download csv from qiime2view to get exact numeric rarefaction thresholds
qiime diversity alpha-rarefaction \
--i-table "${results_folder}/s04_table_dada2.qza" \
--i-phylogeny "${results_folder}/s05_rooted_tree.qza" \
--p-max-depth 915 \
--m-metadata-file "samples.txt" \
--o-visualization "${results_folder}/s06a_alpha_rarefaction.qzv" 

# Completion message
echo ""
echo "Done"
date

