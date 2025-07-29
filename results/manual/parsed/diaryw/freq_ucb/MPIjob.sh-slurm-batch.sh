#!/bin/bash
#SBATCH --account=def-weiqi
#SBATCH --output=R-%x.%j.out
#SBATCH --error=R-%x.%j.errn
#SBATCH --mail-user=zhangyanking00@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=100
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=03:00:00
#SBATCH --array=0-7

module load python/3.10
module load scipy-stack
srun python3 MPI.py --part=$SLURM_ARRAY_TASK_ID
