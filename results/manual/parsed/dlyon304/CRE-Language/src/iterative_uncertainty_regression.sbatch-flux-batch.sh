#!/bin/bash
#FLUX: --job-name=iter_reg
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
iterations=18
folder=Runs/$1
test_runs=100
datafile=Data/activity.parquet
for mode in Uncertainty Random
do
    i=0
    dirname=$folder/$mode/$fold
    mkdir -p $dirname
    while [ True ]
    do
        python3 src/iterative_uncertainty_regression.py $dirname $datafile $mode $i --fold $fold --FEATURE_KEY sequence --LABEL_KEY expression_log2 --num_test $test_runs --sampling_size 4000
        if [ $i -eq $iterations ]
        then
            break
        fi
        ((i++))
    done
done
