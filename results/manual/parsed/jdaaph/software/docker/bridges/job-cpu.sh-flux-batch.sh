#!/bin/bash
#FLUX: --job-name=test-cpu
#FLUX: -N=2
#FLUX: -n=2
#FLUX: -c=28
#FLUX: --queue=RM-small
#FLUX: --urgency=16

source /etc/profile.d/modules.sh
module load singularity/2.6.0
module unload intel
module load mpi/gcc_openmpi
rm -f test-results-cpu.out
mpirun -n 1 singularity exec software.simg python3 serial-cpu.py
mpirun singularity exec software.simg python3 mpi-cpu.py
mpirun singularity exec software.simg /opt/osu-micro-benchmarks/libexec/osu-micro-benchmarks/mpi/pt2pt/osu_bibw >> test-results-cpu.out
