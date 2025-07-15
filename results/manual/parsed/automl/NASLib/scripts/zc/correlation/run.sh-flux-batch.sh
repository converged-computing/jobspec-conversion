#!/bin/bash
#FLUX: --job-name=THE_JOB_NAME
#FLUX: --urgency=16

echo "Workingdir: $PWD";
echo "Started at $(date)";
echo "Running job $SLURM_JOB_NAME using $SLURM_JOB_CPUS_PER_NODE cpus per node with given JID $SLURM_JOB_ID on queue $SLURM_JOB_PARTITION";
searchspace=$1
dataset=$2
predictor=$3
start_seed=$4
experiment=$5
if [ -z "$searchspace" ]
then
    echo "Search space argument not provided"
    exit 1
fi
if [ -z "$dataset" ]
then
    echo "Dataset argument not provided"
    exit 1
fi
if [ -z "$predictor" ]
then
    echo "Predictor argument not provided"
    exit 1
fi
if [ -z "$start_seed" ]
then
    echo "Start seed not provided"
    exit 1
fi
if [ -z "$experiment" ]
then
    echo "experiment not provided"
    exit 1
fi
start=`date +%s`
test_id=0
seed=$(($start_seed + ${test_id}))
python naslib/runners/zc/runner.py --config-file naslib/configs/${experiment}/${predictor}/${searchspace}-${start_seed}/${dataset}/config_${seed}.yaml
end=`date +%s`
runtime=$((end-start))
echo Runtime: $runtime
