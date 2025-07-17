#!/bin/bash
#FLUX: --job-name=hairy-banana-2375
#FLUX: -N=4
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

module unload nvidia/cuda/10.0
module load nvidia/cuda/10.2
cd $SLURM_SUBMIT_DIR
HOST=$(scontrol show hostname $SLURM_NODELIST | head -n1)
srun python main.py --host $HOST --port 29500
