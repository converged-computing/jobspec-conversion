#!/bin/bash
# batch_stats_gratings.sbatch
#
#SBATCH -p cox # run on cox gpu to use correct env 
#SBATCH -n 8 # one core
#SBATCH -N 1 # on one node
#SBATCH -t 0-12:00 # Running time of 3 hours
#SBATCH --mem-per-cpu=16384 #70656 # Memory request of 70 GB (inc to 98304)

# load modules
module load centos6/0.0.1-fasrc01
module load matlab/R2015b-fasrc01
module load Anaconda/5.0.1-fasrc01

# activate 2p-pipeline environment:
source activate /n/coxfs01/2p-pipeline/envs/pipeline

# grab filename from array exported from 'parent' shell:
#FILENAME="$1"
#echo "File: ${FILENAME}"

# run processing on raw data
python /n/coxfs01/2p-pipeline/repos/2p-pipeline/pipeline/python/classifications/get_dataset_stats.py -S gratings -t ${1} -m ${2} --response-test=${3} --response-thr=${4} --n-stds=${5} -n 8 --plot-rois -b ${6} -k ${7}
