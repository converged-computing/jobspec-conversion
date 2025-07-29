#!/bin/bash
#SBATCH --job-name=dropCount
#SBATCH --output=job_%j.out
#SBATCH --mail-user=big.jimmy@email.com
#SBATCH --mail-type=BEGIN,FAIL,END
#SBATCH --nodes=1
#SBATCH --ntasks=250
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=3G
#SBATCH --time=02:00:00
#SBATCH --partition=short
#SBATCH --constraint=xeon

ulimit -s unlimited
srun --mpi=pmix ./drop_count
module load python
python combineOutputs.py
