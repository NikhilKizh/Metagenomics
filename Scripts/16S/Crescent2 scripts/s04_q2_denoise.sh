# !/bin/bash
# QIIME2 - Denoise
# Alexey Larionov, Nov2022
# Nikhil Kizhakkepath jun2023
# Requires environment with QIIME2 

# Crescent2 script 16S
# Note: this script should be run on a compute node
# qsub s04_q2_denoise.sh

# PBS directives
#---------------

#PBS -N s04_q2_denoise
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
base_folder="/mnt/beegfs/home/s394312/metagenomics/thesis/16S"
results_folder="${base_folder}/results"

# Denoise (default --p-n-reads-learn 1000000)
# In this example we do not aditionally trim data by quality (both trunc-len = 0)
# because the data quality is good from the beginning to the end of the reads.  
# Setting the number of threads to 0 requests all cores available on PC. 
# This is OK when you use a personal laptop, but should be changed for HPC.  
qiime dada2 denoise-paired \
--i-demultiplexed-seqs "${results_folder}/s03_pe_dmx_trim.qza" \
--p-trunc-len-f 186 \
--p-trunc-len-r 203 \
--p-n-threads 12 \
--o-table "${results_folder}/s04_table_dada2.qza" \
--o-denoising-stats "${results_folder}/s04_stats_dada2.qza" \
--o-representative-sequences "${results_folder}/s04_rep_seqs_dada2.qza" \
--verbose

# Summarise feature table
qiime feature-table summarize \
--i-table "${results_folder}/s04_table_dada2.qza" \
--o-visualization "${results_folder}/s04_table_dada2.qzv"

# Visualise statistics
qiime metadata tabulate \
--m-input-file "${results_folder}/s04_stats_dada2.qza" \
--o-visualization "${results_folder}/s04_stats_dada2.qzv"

# Tabulate representative sequences
qiime feature-table tabulate-seqs \
--i-data "${results_folder}/s04_rep_seqs_dada2.qza" \
--o-visualization "${results_folder}/s04_rep_seqs_dada2.qzv"

# Completion message
echo ""
echo "Done"
date
