#!/bin/bash
#SBATCH --account=def-hsajjad
#SBATCH --output=produce_data_slurm.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=192000M
#SBATCH --time=2-00:23:00
#SBATCH --constraint=ntasks-per-node=32

module load python/3.10.2 cuda nccl
module load gcc/9.3.0 arrow
sh ./produce_dataset.sh
