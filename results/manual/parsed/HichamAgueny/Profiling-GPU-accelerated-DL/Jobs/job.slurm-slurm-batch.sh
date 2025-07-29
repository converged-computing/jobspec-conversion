#!/bin/bash
#FLUX: --job-name=pyt-profiler
#FLUX: --queue=accel
#FLUX: -t=600
#FLUX: --urgency=16

Mydir=/cluster/projects/nn9987k/PyTorchProfiler
MyContainer=${Mydir}/Container/pytorch_22.12-py3.sif
MyExp=${Mydir}/examples
singularity exec --nv -B ${MyExp} ${MyContainer} python3 ${MyExp}/resnet18_profiler_api_4batch.py
echo 
echo "--Job ID:" $SLURM_JOB_ID
echo "--total nbr of gpus" $SLURM_GPUS
echo "--nbr of gpus_per_node" $SLURM_GPUS_PER_NODE
