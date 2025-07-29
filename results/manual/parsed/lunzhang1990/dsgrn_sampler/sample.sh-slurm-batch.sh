#!/bin/bash
#SBATCH --output=testslurm%N.%j.out
#SBATCH --error=slurm_script.%N.%j.err
#SBATCH --mail-user=chamberlian1990@gmail.com
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32G
#SBATCH --time=3-06:00:00
#SBATCH --partition=main

cd $PWD
module load python/3.5.2   intel/17.0.4
srun python3 sampleRun.py 64 1 
