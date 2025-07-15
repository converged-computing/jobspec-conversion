#!/bin/bash
#FLUX: --job-name=hello-parrot-9416
#FLUX: -c=46
#FLUX: --exclusive
#FLUX: --priority=16

/bin/bash
conda activate hetero_mod
module load python/3.8.9
module load openmpi/4.1.0/gcc.7.3.1/rocm.4.2
srun --exclusive --nodes 1 --ntasks 1 python dataset_test.py
wait
