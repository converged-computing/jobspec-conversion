#!/bin/bash
#SBATCH --job-name=cnn-cifar100
#SBATCH --account=def-ttt
#SBATCH --output=%x_%A-%a_%n-%t.out
#SBATCH --mail-user=sr925041@dal.ca
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32G
#SBATCH --time=02:00:00

                                    # %x=job-name, %A=job ID, %a=array value, %n=node rank, %t=task rank, %N=hostname
                                    # Note: You must manually create output directory "logs" before launching job.
GPUS_PER_NODE=1
module load python/3.10.2
srun python ./cnn-cifar100.py \
        --gpus $GPUS_PER_NODE \
        --name "cnn-cifar100"
