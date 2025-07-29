#!/bin/bash
#SBATCH --job-name=valgrind3
#SBATCH --output=log/valgrind3.%j.out
#SBATCH --error=log/valgrind3.%j.err
#SBATCH --mail-user=%u@uga.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:K40:1
#SBATCH --mem=4gb
#SBATCH --time=00:30:00
#SBATCH --partition=gpu_p

cd $SLURM_SUBMIT_DIR
ml CUDA/10.0.130
ml GCCcore/6.4.0
valgrind --error-exitcode=1 --tool=memcheck --errors-for-leak-kinds=definite --leak-check=full --show-leak-kinds=all bin/SFM -d /work/demlab/sfm/SSRLCV-Sample-Data/everest1024/3view -s /work/demlab/sfm/SSRLCV-Sample-Data/seeds/seed_spongebob.png
