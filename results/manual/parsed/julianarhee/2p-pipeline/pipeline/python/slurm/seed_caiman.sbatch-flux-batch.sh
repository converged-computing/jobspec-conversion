#!/bin/bash
#FLUX: --job-name=blank-lemon-7248
#FLUX: --urgency=16

module load centos6/0.0.1-fasrc01
module load matlab/R2015b-fasrc01
module load Anaconda/5.0.1-fasrc01
source activate /n/coxfs01/2p-pipeline/envs/pipeline
echo ${1}
echo ${2}
echo ${3}
echo ${4}
echo ${5}
echo ${6}
echo ${7}
python /n/coxfs01/2p-pipeline/repos/2p-pipeline/pipeline/python/rois/caiman_steps.py --slurm -i ${1} -S ${2} -A ${3} -R ${4} -t ${5} -d ${6} --gSig=${7} --border=4 --psth -p corrected -r ${8} -C ${9} -H ${10} -o ${11} --seed
