#!/bin/bash
#FLUX: --job-name=distributed_training
#FLUX: -N=2
#FLUX: -n=8
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

module load cuda/11.0
module load cudnn/8.0.2
training="train.py" 
if [ -f "$training" ];
then
    echo "running"
    # in the example I based this off of, they used mpi (message passing interface) + srun is used for slurm
    srun --mpi=pmix_v3 python3 "$training"
    echo "done"
else
    echo "does not exist"
fi
