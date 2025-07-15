#!/bin/bash
#FLUX: --job-name=anxious-banana-0604
#FLUX: --urgency=16

mkdir -p return
module load anaconda gcc/6.5.0 cuda/10.2.89 matlab/r2019b
source activate PFDTD
srun python testBench.py
mv ./*.log ./return/
mv ./*.hdf5 ./return/
mv ./*.out ./return/
