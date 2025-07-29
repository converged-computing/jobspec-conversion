#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=160
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --exclusive

module load parallel
srun="srun --exclusive -N1 -n1 -c2"
parallel="parallel -j $SLURM_NTASKS --joblog log/parallel.log --resume"
$parallel "$srun ./hadisd.sh {1} &> log/{.}.log" :::: hadisd2012.files
