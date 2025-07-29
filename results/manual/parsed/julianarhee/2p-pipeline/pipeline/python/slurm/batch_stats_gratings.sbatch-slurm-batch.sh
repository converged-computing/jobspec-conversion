#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=16384
#SBATCH --time=00:12:00

module load centos6/0.0.1-fasrc01
module load matlab/R2015b-fasrc01
module load Anaconda/5.0.1-fasrc01
source activate /n/coxfs01/2p-pipeline/envs/pipeline
python /n/coxfs01/2p-pipeline/repos/2p-pipeline/pipeline/python/classifications/get_dataset_stats.py -S gratings -t ${1} -m ${2} --response-test=${3} --response-thr=${4} --n-stds=${5} -n 8 --plot-rois -b ${6} -k ${7}
