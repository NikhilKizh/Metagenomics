# !/bin/bash
# QIIME2 - filter_feature_table
# Alexey Larionov 12Jun2023
# Nikhil Kizhakkepath 20Jun2023
# Requires environment with QIIME2 

# Crescent2 script
# Note: this script should be run on a compute node
# qsub s12b_q2_ancom_nofilter.sh

# PBS directives
#---------------

#PBS -N s12b_q2_ancom_nofilter.sh
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

## ANCOM DAY 1 Day Treatment


# taxa_genus_level

qiime taxa collapse \
  --i-table ${results_folder}/s06b_rarefied_table.qza \
  --i-taxonomy ${results_folder}/s10_taxonomy.qza \
  --p-level 6 \
  --o-collapsed-table ${results_folder}/s12b_q2_rarefied_table_d1_d28_genus.qza

# adding psuedocount
qiime composition add-pseudocount \
  --i-table ${results_folder}/s12b_q2_rarefied_table_d1_d28_genus.qza \
  --o-composition-table ${results_folder}/s12b_q2_rarefied_ancom_d1_d28.qza

# ancom analysis day 1 Day

qiime composition ancom \
  --i-table ${results_folder}/s12b_q2_rarefied_ancom_d1_d28.qza \
  --m-metadata-file samples.txt \
  --m-metadata-column Day \
  --o-visualization ${results_folder}/s12b_q2_ancom_Day.qzv

# ancom analysis day1 treatment

qiime composition ancom \
  --i-table ${results_folder}/s12b_q2_rarefied_ancom_d1_d28.qza \
  --m-metadata-file samples.txt \
  --m-metadata-column Treatment \
  --o-visualization ${results_folder}/s12b_q2_ancom_d1_d28_Treatment.qzv

# Completion message
echo "Done"
date
