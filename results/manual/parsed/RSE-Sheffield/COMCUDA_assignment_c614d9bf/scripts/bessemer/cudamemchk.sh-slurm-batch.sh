#!/bin/bash
#SBATCH --job-name=com4521_cudamemchk
#SBATCH --account=dcs-res
#SBATCH --output=com4521_profile_output.out
#SBATCH --error=com4521_profile_error.err
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
compute-sanitizer --print-limit 1 "./bin/release/assignment" CUDA SD 12 100
