#!/bin/bash
#FLUX: --job-name=test-cpu
#FLUX: -N=2
#FLUX: --queue=debug
#FLUX: -t=600
#FLUX: --urgency=16

module load singularity
module unload mvapich2_ib
module load openmpi_ib
rm -f test-results-cpu.out
ibrun -n 1 singularity exec software.simg python3 serial-cpu.py
ibrun --npernode 1 singularity exec software.simg python3 mpi-cpu.py
ibrun --npernode 1 singularity exec software.simg /opt/osu-micro-benchmarks/libexec/osu-micro-benchmarks/mpi/pt2pt/osu_bibw >> test-results-cpu.out
