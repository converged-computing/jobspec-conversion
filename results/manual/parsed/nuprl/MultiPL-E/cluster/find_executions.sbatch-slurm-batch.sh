#!/bin/bash
#SBATCH --job-name=find_executions
#SBATCH --nodes=1
#SBATCH --ntasks=200
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=1G
#SBATCH --time=00:10:00

module load gnu-parallel
parallel="parallel -j $SLURM_NTASKS"
$parallel "srun -N1 -n1 python3 find_executions.py --host $1 --container /dataset" ::: $1/* > executions.txt
