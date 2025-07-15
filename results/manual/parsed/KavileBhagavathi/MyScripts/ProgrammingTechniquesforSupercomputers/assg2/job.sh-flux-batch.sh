#!/bin/bash
#FLUX: --job-name=streamtriad_daxpy_benchmarking
#FLUX: -t=3600
#FLUX: --urgency=16

unset SLURM_EXPORT_ENV
module purge
module load intel
icx -O3 -xHost -fno-alias assignment2_VectorTriad.c time.c -o vectortriad 
icx -O3 -xHost -fno-alias assignment2_DAXPY.c time.c -o daxpy
icx -O3 -xHost -fno-alias scan.c time.c
echo "Running benchmarks"
    #srun --cpu-freq=2400000-2400000 ./a.out
srun --cpu-freq=2200000-2200000 ./vectortriad
srun --cpu-freq=2200000-2200000 ./daxpy
