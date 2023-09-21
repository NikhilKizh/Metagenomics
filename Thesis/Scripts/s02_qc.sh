# !/bin/bash
# FastQC & MiltiQC
# Alexey Larionov 12Jun2023
# Nikhil Kizhakkepath 19Jun2023

# Crescent2 script
# Note: this script should be run on a compute node
# qsub s02_qc.sh

# PBS directives
#---------------

#PBS -N s02_qc
#PBS -l nodes=1:ncpus=4
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

# Start message
echo "FastQC & MultiQC"
date
echo ""

# Load required modules
module load FastQC/0.11.9-Java-11
module load MultiQC/1.12-foss-2021b
fastqc --version
multiqc --version

# Folders
base_folder="/mnt/beegfs/home/s394312/metagenomics/thesis/16S"
data_folder="${base_folder}/data" # should exist and contain fastq files

# Go to data folder
cd "${data_folder}"

# List of files in the data folder
fastq_files=$(ls *.fastq)

# Run FastQC for all fastq files
fastqc $fastq_files

# Run MultiQC in the current folder
multiqc .

# Completion message
echo "Done"
date

## Tidy up
## =========================
rm $PBS_O_WORKDIR/$PBS_JOBID
