#!/bin/bash
#SBATCH --job-name=com4521_run_debug
#SBATCH --account=dcs-res
#SBATCH --output=com4521_run_output.out
#SBATCH --error=com4521_run_error.err
#SBATCH --mail-user=me@somedomain.com
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=1G
#SBATCH --time=00:10:00

module load CUDAcore/11.1.1
module load gcccuda/2019b
./bin/debug/assignment OPENMP SD 12 100
