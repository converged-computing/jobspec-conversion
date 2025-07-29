#!/bin/bash
#SBATCH --output=python_job_slurm.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=500M
#SBATCH --time=00:10:00
#SBATCH --constraint=skylake

module load Intel IntelMPI Python numpy
python vectorization.py
