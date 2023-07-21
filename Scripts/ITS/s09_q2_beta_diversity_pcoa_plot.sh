# !/bin/bash
# QIIME2 - beta_diversity_pcoa_plot.sh
# Alexey Larionov 12Jun2023
# Nikhil Kizhakkepath 20Jun2023
# Requires environment with QIIME2 

# Crescent2 script
# Note: this script should be run on a compute node
# qsub s09_q2_beta_diversity_pcoa_plot.sh

# PBS directives
#---------------

#PBS -N s09_q2_beta_diversity_pcoa_plot.sh
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
echo "QIIME2: beta_diversity_pcoa_plot"
date
echo ""


# Folders
base_folder="/mnt/beegfs/home/s394312/metagenomics/thesis/ITS"
results_folder="${base_folder}/results"
diversity_metrics_folder="${results_folder}/s07_diversity_metrics"

# Use the weighted unifrac distances (custom-axes parameter can be used to specific any colum$
qiime emperor plot \
--i-pcoa "${diversity_metrics_folder}/weighted_unifrac_pcoa_results.qza" \
--m-metadata-file "samples.txt" \
--o-visualization "${results_folder}/s09_beta_weighted_unifrac_emperor_pcoa.qzv"

# Use the bray curtis distances (custom-axes parameter can be used to specific any column fro$
qiime emperor plot \
--i-pcoa "${diversity_metrics_folder}/bray_curtis_pcoa_results.qza" \
--m-metadata-file "samples.txt" \
--o-visualization "${results_folder}/s09_beta_bray_curtis_emperor_pcoa.qzv"

# Completion message
echo ""
echo "Done"
date
