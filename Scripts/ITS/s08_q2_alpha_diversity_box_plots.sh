# !/bin/bash
# QIIME2 - alpha_diversity_box_plots
# Alexey Larionov 12Jun2023
# Nikhil Kizhakkepath 20Jun2023
# Requires environment with QIIME2 

# Crescent2 script
# Note: this script should be run on a compute node
# qsub s08_q2_alpha_diversity_box_plots.sh

# PBS directives
#---------------

#PBS -N s08_q2_alpha_diversity_box_plots.sh
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
echo "QIIME2: phylogenetic_tree"
date
echo ""


# Folders
base_folder="/mnt/beegfs/home/s394312/metagenomics/thesis/ITS"
results_folder="${base_folder}/results"
diversity_metrics_folder="${results_folder}/s07_diversity_metrics"

# Visualize relationships between alpha diversity and study metadata
# (uses some files created at the previous step)
qiime diversity alpha-group-significance \
--i-alpha-diversity "${diversity_metrics_folder}/faith_pd_vector.qza" \
--m-metadata-file "samples.txt" \
--o-visualization "${results_folder}/s08_alpha_faith_pd_per_group.qzv"

qiime diversity alpha-group-significance \
--i-alpha-diversity "${diversity_metrics_folder}/evenness_vector.qza" \
--m-metadata-file "samples.txt" \
--o-visualization "${results_folder}/s08_alpha_evenness_per_group.qzv"

qiime diversity alpha-group-significance \
--i-alpha-diversity "${diversity_metrics_folder}/shannon_vector.qza" \
--m-metadata-file "samples.txt" \
--o-visualization "${results_folder}/s08_alpha_shannon_per_group.qzv"

# Completion message
echo ""
echo "Done"
date
