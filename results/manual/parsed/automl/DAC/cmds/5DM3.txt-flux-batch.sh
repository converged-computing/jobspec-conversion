#!/bin/bash
#FLUX: --job-name=quirky-nalgas-4968
#FLUX: --priority=16

source activate dac
steps=1000000
evali=10
cfreq=5000
experi="5D3M"
expdir="experiments/sigmoidm_DDQN_1_50_${experi}/${SLURM_ARRAY_TASK_ID}"
cmd="dac/train/train_chainer_agent_on_toy.py --eval-n-runs 10 --eval-interval ${evali} --checkpoint_frequency ${cfreq} --outdir ${expdir} --seed ${SLURM_ARRAY_TASK_ID} --scenario ${experi}"
if [ $SLURM_ARRAY_TASK_ID -le 25 ]; then
    python $cmd 
    exit $?
fi
