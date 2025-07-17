#!/bin/bash
#FLUX: --job-name=train
#FLUX: --queue=gpu
#FLUX: -t=28800
#FLUX: --urgency=16

export PARAMETER_SET='42'

set -e # Good Idea to stop operation on first error.
source /sw/batch/init.sh
module unload env
module load /sw/BASE/env/2017Q1-gcc-openmpi /sw/BASE/env/cuda-8.0.44_system-gcc
echo "Hello World! I am $(hostname -s) greeting you!"
echo "Also, my current TMPDIR: $TMPDIR"
echo "nvidia-smi:"
srun bash -c 'nvidia-smi'
export PARAMETER_SET=42
srun bash -c 'echo "process $SLURM_PROCID \
(out of $SLURM_NPROCS total) on $(hostname -s) \
parameter set $PARAMETER_SET"'
srun bash -c 'CUDA_VISIBLE_DEVICES=$SLURM_PROCID LD_LIBRARY_PATH=/sw/compiler/cuda-8.0.44/lib64:$HOME/cuda/lib64/ \
python3 $WORK/VoiceClassification/train.py --steps 100 --samples 3000'
