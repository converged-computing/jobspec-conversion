#!/bin/bash
#FLUX: --job-name=HPO_CUDA
#FLUX: -N=2
#FLUX: --priority=16

module load cuda
rm $(pwd)/db/first_julia_nn.db
for i in {1..64}
do
    srun python main.py root=$(pwd) action=run_study &
    if [$i = 1]; then
        sleep 1
    fi
done
wait
