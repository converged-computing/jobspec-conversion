#!/bin/bash
#SBATCH --job-name=test-cpu
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=24

module load singularity
module unload mvapich2_ib
module load openmpi_ib
rm -f test-results-cpu.out
ibrun -n 1 singularity exec software.simg python3 serial-cpu.py
ibrun --npernode 1 singularity exec software.simg python3 mpi-cpu.py
ibrun --npernode 1 singularity exec software.simg /opt/osu-micro-benchmarks/libexec/osu-micro-benchmarks/mpi/pt2pt/osu_bibw >> test-results-cpu.out
