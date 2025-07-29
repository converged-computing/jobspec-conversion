#!/bin/bash
#SBATCH --account=bioinf
#SBATCH --output=logs/snakemake_submit.out
#SBATCH --error=logs/snakemake_submit.err
#SBATCH --mail-user=ajt200@cam.ac.uk
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=120G
#SBATCH --time=4-03:00:00
#SBATCH --no-requeue

echo "Number of CPUs used: $SLURM_CPUS_PER_TASK"
echo "This job is running on:"
hostname
./condor_submit.sh
