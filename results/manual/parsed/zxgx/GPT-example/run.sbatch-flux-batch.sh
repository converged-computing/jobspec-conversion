#!/bin/bash
#FLUX: --job-name=doopy-hobbit-5509
#FLUX: -N=4
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --priority=16

module unload nvidia/cuda/10.0
module load nvidia/cuda/10.2
cd $SLURM_SUBMIT_DIR
HOST=$(scontrol show hostname $SLURM_NODELIST | head -n1)
srun python main.py --host $HOST --port 29500
