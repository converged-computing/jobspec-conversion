#!/bin/bash
#SBATCH --job-name=Orkut16_lazy_lazy
#SBATCH --account=m1641
#SBATCH --output=output/orkut/Orkut16_lazy_lazy.o
#SBATCH --error=output/orkut/Orkut16_lazy_lazy.e
#SBATCH --mail-user=wade.cappa@wsu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=16
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --qos=debug
#SBATCH --constraint=ntasks-per-node=1,haswell,ntasks-per-node=1

export OMP_NUM_THREADS='32'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

export OMP_NUM_THREADS=32
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
mpirun -n 16 ./build/release/tools/mpi-greedi-im -i test-data/orkut_small.txt -w -k 16 -p -d IC -e 0.13 -o Orkut16_lazy_lazy.json --run-streaming=false
