#!/bin/bash
#SBATCH --job-name=bfs-k80
#SBATCH --output=bfs-k80-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:k80:4
#SBATCH --time=00:05:00
#SBATCH --partition=GPU-shared

module use /home/tisaac/opt/modulesfiles
module load petsc/cse6230-double
if [ ! -f Makefile.cuda ]; then
  echo "MMMA_CUDA = 1" > Makefile.cuda
fi
make test_bfs
git rev-parse HEAD
git diff-files
pwd; hostname; date
./test_bfs
date
