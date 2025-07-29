#!/bin/bash
#SBATCH --job-name=bfs-p100
#SBATCH --output=bfs-p100-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:p100:2
#SBATCH --time=00:05:00

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
