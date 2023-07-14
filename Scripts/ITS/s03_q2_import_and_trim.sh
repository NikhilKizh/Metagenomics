#!/bin/bash
# QIIME2 - Import and trim 16S
# Alexey Larionov 12Jun2023
# nikhil.kizhakkepath.312@cranfield.ac.uk
# Requires environment with QIIME2 
# Requires file file "source_files.txt" (update the provided example!)

# Crescent2 script
# Note: this script should be run on a compute node
# qsub s03_import_and_trim.sh

# PBS directives
#---------------

#PBS -N s03_q2_import_and_trim
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

# Load required module
module load QIIME2/2022.11
qiime --version

# Start message
echo "QIIME2: Import and Trim"
date
echo ""

# Folders
base_folder="/mnt/beegfs/home/s394312/metagenomics/thesis/ITS"
results_folder="${base_folder}/results"

# Importing data to QIIME2. For more details: see qiime tools import --help
# Note that file "source_files.txt" should be prepared before you run this script!
qiime tools import \
--type "SampleData[PairedEndSequencesWithQuality]" \
--input-path "source_files.txt" \
--input-format "PairedEndFastqManifestPhred33V2" \
--output-path "${results_folder}/s03_pe_dmx.qza"

# Trim primers (https://docs.qiime2.org/2022.8/plugins/available/cutadapt/)
# This example shows the case when fragments are longer than reads 
# (e.g. ~300bp PCR products sequenced with 150PE Illumina sequencing)
# You should use different approach when reads are longer than PCR fragments
# (e.g. ~300bp PCR productd sequenced with 500PE Illumina sequencing)
qiime cutadapt trim-paired \
--p-front-f ^GTGARTCATCGAATCTTTG \
--p-front-r ^TCCTCCGCTTATTGATATGC \
--p-match-read-wildcards \
--i-demultiplexed-sequences "${results_folder}/s03_pe_dmx.qza" \
--o-trimmed-sequences "${results_folder}/s03_pe_dmx_trim.qza"