# !/bin/bash
# QIIME2 - filter_feature_table
# Alexey Larionov 12Jun2023
# Nikhil Kizhakkepath 20Jun2023
# Requires environment with QIIME2 

# Crescent2 script
# Note: this script should be run on a compute node
# qsub s12a_q2_ancom_day_treatment.sh

# PBS directives
#---------------

#PBS -N s12a_q2_ancom_day_treatment.sh
#PBS -l nodes=1:ncpus=12
#PBS -l walltime=03:00:00
#PBS -q three_hour
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
echo "QIIME2: ancom_day_treatment"
date
echo ""


# Folders
base_folder="/mnt/beegfs/home/s394312/metagenomics/thesis/16S"
results_folder="${base_folder}/results"


# ancom_day_treatment

qiime composition ancom \
  --i-table "${results_folder}/s12a_filter_pseudo_table_abund_comp.qza" \
  --m-metadata-file samples.txt \
  --m-metadata-column Day \
  --o-visualization "${results_folder}/s12b_ancom_Day.qzv"

qiime composition ancom \
  --i-table "${results_folder}/s12a_filter_pseudo_table_abund_comp.qza" \
  --m-metadata-file samples.txt \
  --m-metadata-column Treatment \
  --o-visualization "${results_folder}/s12b_ancom_Treatment.qzv"



# Completion message
echo ""
echo "Done"
date
