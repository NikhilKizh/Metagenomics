# !/bin/bash
# QIIME2 - taxonomy_barplot
# Alexey Larionov 12Jun2023
# Nikhil Kizhakkepath 20Jun2023
# Requires environment with QIIME2 

# Crescent2 script
# Note: this script should be run on a compute node
# qsub s11a_beta_group_permannova_Treatment.sh

# PBS directives
#---------------

#PBS -N s11a_beta_group_permannova_Treatment
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
echo "QIIME2: permannova"
date
echo ""


# Folders
base_folder="/mnt/beegfs/home/s394312/metagenomics/thesis/16S"
results_folder="${base_folder}/results"
ls -la ${results_folder}/s07_diversity_metrics/unweighted_unifrac_distance_matrix.qza
ls -la samples.txt
ls -la ${results_folder}/s07_diversity_metrics/weighted_unifrac_distance_matrix.qza


# betagroup significance permannova unweighted_weighted_day1_day28_Treatment

qiime diversity beta-group-significance \
     --i-distance-matrix ${results_folder}/s11c_unweighted_unifrac_distance_matrix_day1.qza \
     --m-metadata-file samplesone.txt \
     --m-metadata-column Treatment \
     --o-visualization $results_folder/s11a_unweighted-unifrac-Treatment_d1-significance.qzv \
     --p-pairwise

qiime diversity beta-group-significance \
     --i-distance-matrix ${results_folder}/s11c_weighted_unifrac_distance_matrix_day1.qza \
     --m-metadata-file samplesone.txt \
     --m-metadata-column Treatment \
     --o-visualization $results_folder/s11a_weighted-unifrac-Treatment_d1-significance.qzv \
     --p-pairwise

qiime diversity beta-group-significance \
     --i-distance-matrix ${results_folder}/s11c_unweighted_unifrac_distance_matrix_day28.qza \
     --m-metadata-file samplestwentyeight.txt \
     --m-metadata-column Treatment \
     --o-visualization $results_folder/s11a_unweighted-unifrac-Treatment_d28_significance.qzv \
     --p-pairwise

qiime diversity beta-group-significance \
     --i-distance-matrix ${results_folder}/s11c_weighted_unifrac_distance_matrix_day28.qza \
     --m-metadata-file samplestwentyeight.txt \
     --m-metadata-column Treatment \
     --o-visualization $results_folder/s11a_weighted-unifrac-Treatment_d28_significance.qzv \
     --p-pairwise

# Completion message
echo ""
echo "Done"
date
