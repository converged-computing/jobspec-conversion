#!/bin/bash
#FLUX: --job-name=test-cpu
#FLUX: --queue=skx-normal
#FLUX: --urgency=16

module load tacc-singularity
module load mvapich2
rm -f test-results-cpu.out
singularity exec software.simg python3 serial-cpu.py
ibrun -n 2 singularity exec software.simg python3 mpi-cpu.py
ibrun -n 2 singularity exec software.simg /opt/osu-micro-benchmarks/libexec/osu-micro-benchmarks/mpi/pt2pt/osu_bibw >> test-results-cpu.out
