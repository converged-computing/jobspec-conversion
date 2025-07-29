#!/bin/bash
#SBATCH --job-name=distributed_training
#SBATCH --nodes=2
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:2
#SBATCH --mem-per-cpu=100mb
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=4,ntasks-per-socket=2

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
