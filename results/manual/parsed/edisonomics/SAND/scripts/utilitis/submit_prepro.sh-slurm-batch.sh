#!/bin/bash
#SBATCH --job-name=fid_prepro
#SBATCH --output=fid_prepro.%j.out
#SBATCH --error=fid_prepro.%j.err
#SBATCH --mail-user=Your@email
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=45
#SBATCH --mem=120gb
#SBATCH --time=6-06:00:00

cd $SLURM_SUBMIT_DIR
module load  matlab/R2020b
mkdir temp_prepro
mkdir -p ./temp_prepro/$SLURM_JOB_ID
time matlab -nodisplay < data_preprocess.m > matlab_${PBS_JOBID}.out
