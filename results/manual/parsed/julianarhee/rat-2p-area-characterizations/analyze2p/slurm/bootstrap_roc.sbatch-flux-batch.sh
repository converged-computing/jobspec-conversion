#!/bin/bash
#FLUX: --job-name=roc
#FLUX: -n=4
#FLUX: --queue=shared
#FLUX: -t=120
#FLUX: --urgency=16

module load centos6/0.0.1-fasrc01
module load Anaconda/5.0.1-fasrc01
source activate /n/coxfs01/2p-pipeline/envs/rat2p #pipeline
echo ${1}
echo ${2}
echo ${3}
python /n/coxfs01/2p-pipeline/repos/rat-2p-area-characterizations/analyze2p/bootstrap_roc.py -k ${1} -E ${2} -t ${3} -n 4 --plot 
