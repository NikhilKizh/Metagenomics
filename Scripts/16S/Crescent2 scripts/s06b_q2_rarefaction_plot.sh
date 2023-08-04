# !/bin/bash
# QIIME2 - apply_rarefaction
# Alexey Larionov, Nov2022
# Nikhil Kizhakkepath jun2023
# Requires environment with QIIME2 

# Crescent2 script
# Note: this script should be run on a compute node
# qsub s06b_q2_rarefraction_plot.sh

# PBS directives
#---------------

#PBS -N s06b_q2_rarefraction_plot.sh

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
echo "QIIME2: brarefaction"
date
echo ""

# Folders
base_folder="/mnt/beegfs/home/s394312/metagenomics/thesis/16S"
results_folder="${base_folder}/results"

# Rarefaction
# The sampling-depth is subjectively selected basing on the Rarefaction plot
qiime feature-table rarefy \
--i-table "${results_folder}/s04_table_dada2.qza" \
--p-sampling-depth 36000 \
--o-rarefied-table "${results_folder}/s06b_rarefied_table.qza"

# Completion message
echo ""
echo "Done"
date
