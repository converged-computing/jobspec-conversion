#!/bin/bash
#FLUX: --job-name=memorization
#FLUX: -N=64
#FLUX: -c=6
#FLUX: --exclusive
#FLUX: --queue=g40
#FLUX: --urgency=16

export GIT_DISCOVERY_ACROSS_FILESYSTEM='0'

module load openmpi
module load cuda/11.3
export GIT_DISCOVERY_ACROSS_FILESYSTEM=0
TRAIN_PATH=/fsx/orz/pythia/memorization
source /fsx/orz/memorization/bin/activate
MODELS=(70m-deduped-v0 160m-deduped-v0 410m-deduped-v0 1b-deduped-v0 1.4b-deduped-v0 2.8b-deduped-v0 6.9b-deduped-v0 12b-deduped-v0 70m-v0 160m-v0 410m-v0 1b-v0 1.4b-v0 2.8b-v0 6.9b-v0 12b-v0)
CHECKPOINTS=(143000 123000 103000 83000 63000 43000 23000)
echo $TRAIN_PATH
for model in ${MODELS[@]}
do
for checkpoint in ${CHECKPOINTS[@]}
    do
    export MODEL=$model
    export CHECKPOINT=$checkpoint
    srun -n $SLURM_NPROCS /fsx/orz/memorization/bin/python3 $TRAIN_PATH/eval_memorization.py
done
done
wait
