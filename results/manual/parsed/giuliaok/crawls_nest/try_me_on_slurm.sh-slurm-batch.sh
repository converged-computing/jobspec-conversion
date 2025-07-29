#!/bin/bash
#SBATCH --job-name=postcode_finder
#SBATCH --account=geog029585
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=256G
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=1

cd "${SLURM_SUBMIT_DIR}"
echo Running on host "$(hostname)"
echo Time is "$(date)"
echo Start Time is "$(date)"
echo Directory is "$(pwd)"
echo Slurm job ID is "${SLURM_JOBID}"
echo This jobs runs on the following machines:
echo "${SLURM_JOB_NODELIST}"
source activate cc_project
python debugging_2024.py
echo End Time is"$(date)"
