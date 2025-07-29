#!/bin/bash
#SBATCH --job-name=job
#SBATCH --output=job/%x_%j.out
#SBATCH --error=job/%x_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --time=00:30:00
#SBATCH --qos=debug
#SBATCH --constraint=ntasks-per-node=1

export LANG='C'

module load intel
module load R
export LANG=C
time mpirun R --vanilla -f testhybr.R
