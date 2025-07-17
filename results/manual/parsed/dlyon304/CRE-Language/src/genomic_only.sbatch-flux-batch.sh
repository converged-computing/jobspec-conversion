#!/bin/bash
#FLUX: --job-name=reg_gen
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=0
#FLUX: --urgency=16

eval $(spack env activate --sh tensorflow-gpu)
if [ -z ${SLURM_ARRAY_TASK_ID} ] ; then
    fold=1
    runname=${SLURM_JOB_ID}
else
    fold=${SLURM_ARRAY_TASK_ID}
    runname=${SLURM_ARRAY_JOB_ID}
fi
dirname=Runs/$1_${runname}/${fold}
mkdir -p $dirname
datafile=Data/genomic.csv
python3 src/genomic_only.py $dirname $datafile --fold ${fold} --FEATURE_KEY sequence --LABEL_KEY expression_log2
