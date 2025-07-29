#!/bin/bash
#SBATCH --job-name=ring_shift_blocking
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=00:40:00
#SBATCH --constraint=ntasks-per-node=64

module purge
module load intel/2020a
module load CMake/3.16.4
cd $SLURM_SUBMIT_DIR                    ### change to the directory where your code is located
chmod +x ./scripts/run_ringshift.sh
./scripts/run_ringshift.sh "results/part3_ringshift.csv"
scontrol show job $SLURM_JOB_ID         ### write job information to output file
