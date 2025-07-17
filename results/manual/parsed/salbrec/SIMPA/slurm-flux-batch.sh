#!/bin/bash
#FLUX: --job-name=SIMPA
#FLUX: -N=4
#FLUX: -n=160
#FLUX: --queue=<PARTITION>
#FLUX: -t=5400
#FLUX: --urgency=16

module load mpi/OpenMPI/3.1.4-GCC-8.3.0
srun --unbuffered -n 160 --mpi=pmi2 python SIMPA.py --bed ./scExamples/H3K4me3_hg38_5kb/BC8791969.bed --targets H3K4me3
