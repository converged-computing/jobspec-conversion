#!/bin/bash
#SBATCH --job-name=HPO_CUDA
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --constraint=ntasks-per-node=32

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
