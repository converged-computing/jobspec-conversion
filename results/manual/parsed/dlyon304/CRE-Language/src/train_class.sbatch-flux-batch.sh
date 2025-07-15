#!/bin/bash
#FLUX: --job-name=delicious-despacito-3877
#FLUX: -c=4
#FLUX: -t=0
#FLUX: --urgency=16

eval $(spack env activate --sh tensorflow)
if [ -z ${SLURM_ARRAY_TASK_ID} ] ; then
    fold=1
    runname=${SLURM_JOB_ID}
else
    fold=${SLURM_ARRAY_TASK_ID}
    runname=${SLURM_ARRAY_JOB_ID}
fi
script=src/train_class.py
dirname=Runs/$1/${fold}
mkdir -p $dirname
cp $script Runs/$1/
datafile=Data/ATAC/ATAC.csv
python3 src/train_class.py $dirname $datafile --num_classes 2 --fold ${fold} --FEATURE_KEY sequence --LABEL_KEY open
