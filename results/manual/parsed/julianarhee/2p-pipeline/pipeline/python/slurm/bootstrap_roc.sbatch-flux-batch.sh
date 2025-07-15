#!/bin/bash
#FLUX: --job-name=expressive-frito-4918
#FLUX: --urgency=16

module load centos6/0.0.1-fasrc01
module load matlab/R2015b-fasrc01
module load Anaconda/5.0.1-fasrc01
source activate /n/coxfs01/2p-pipeline/envs/pipeline
echo ${1}
echo ${2}
echo ${3}
echo ${4}
python /n/coxfs01/2p-pipeline/repos/2p-pipeline/pipeline/python/classifications/bootstrap_roc.py --slurm -i ${1} -S ${2} -A ${3} -E ${4} -t ${5} -n 8 --plot 
