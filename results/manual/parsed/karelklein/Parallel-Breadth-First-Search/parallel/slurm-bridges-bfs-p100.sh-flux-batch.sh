#!/bin/bash
#FLUX: --job-name=hello-buttface-6798
#FLUX: --urgency=16

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
