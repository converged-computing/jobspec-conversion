#!/bin/bash
#SBATCH --job-name=test_job
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=test
#SBATCH --constraint=ntasks-per-node=1

module load CUDA
module load apps/matlab/2017a
cd $SLURM_SUBMIT_DIR
echo $SLURM_SUBMIT_DIR
cd /mnt/storage/home/csprh/code/HAB/extractData/postProcess
matlab -nodisplay -nosplash -r cubeAnalysis_1
