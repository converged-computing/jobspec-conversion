#!/bin/bash
#FLUX: --job-name=cyl3_5
#FLUX: -N=8
#FLUX: -t=174600
#FLUX: --urgency=16

 module load mpi/mvapich2-2.3a_intel
 module load python/3.5.2
 module load cuda/10.0.130
 module load cudnn/7.4
 module load tensorflow/1.13.1_cpu_py3
 python3 -u server.py -env CFD -fil None >& python.log &
 srun -n 64 --mpi=pmi2 ./nektarF -z128 -deal -chk -r0 -S -V cyl.rea >& nektar.log &
 wait
