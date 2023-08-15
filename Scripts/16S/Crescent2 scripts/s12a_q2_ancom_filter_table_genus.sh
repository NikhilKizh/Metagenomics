# !/bin/bash
# QIIME2 - filter_feature_table
# Alexey Larionov 12Jun2023
# Nikhil Kizhakkepath 20Jun2023
# Requires environment with QIIME2 

# Crescent2 script
# Note: this script should be run on a compute node
# qsub s12a_q2_ancom_filter_table.sh

# PBS directives
#---------------

#PBS -N s12a_q2_ancom_filter_table_genus.sh
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
echo "QIIME2: filter_feature_table"
date
echo ""


# Folders
base_folder="/mnt/beegfs/home/s394312/metagenomics/thesis/16S"
results_folder="${base_folder}/results"



# filture_feature_table

qiime feature-table filter-features \
  --i-table "${results_folder}/s06b_rarefied_table.qza" \
  --p-min-frequency 10 \
  --p-min-samples 2 \
  --o-filtered-table "${results_folder}/s12a_rarefied_table.qza"

# adding pseudo_counts

qiime composition add-pseudocount \
  --i-table "${results_folder}/s12a_rarefied_table.qza" \
  --o-composition-table "${results_folder}/s12a_pcount_rarefied_table.qza"

#filtering to genus level

qiime taxa filter-table \
    --i-table ${results_folder}/s12a_pcount_rarefied_table.qza \
    --i-taxonomy ${results_folder}/s10_taxonomy.qza \
    --p-include D__ \
    --o-filtered-table s12a_pcount_genus_rarefied_table.qza



# Completion message
echo ""
echo "Done"
date
