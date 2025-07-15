#!/bin/bash
#FLUX: --job-name=Emotions-CPU
#FLUX: --queue=high
#FLUX: --priority=16

module load CUDA/10.0.130
module load PyTorch/1.4.0-foss-2017a-Python-3.6.4-CUDA-10.0.130
pip3 install -r requirements.txt --upgrade --user &> /dev/null
if [ -z "$CONFIG_PATH" ]
then
  echo "\$CONFIG_PATH is not set -- exiting early"
  exit 1
fi
NUM_WORKERS="${SLURM_ARRAY_TASK_COUNT:-1}"
NUM_EXPERIMENTS="$(ls -1 "$CONFIG_PATH" | grep .json | wc -l)"
EXPERIMENT_INDEX=${SLURM_ARRAY_TASK_ID:-1}
while [ $EXPERIMENT_INDEX -le $NUM_EXPERIMENTS ]
do
  ./bin/runExperiment.sh $CONFIG_PATH $EXPERIMENT_INDEX || true
  EXPERIMENT_INDEX=$(($EXPERIMENT_INDEX + $NUM_WORKERS))
done
