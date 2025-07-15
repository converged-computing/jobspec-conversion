#!/bin/bash
#FLUX: --job-name=salted-caramel-1919
#FLUX: --priority=16

export OMP_NUM_THREADS='64'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

module use /global/common/software/m3169/perlmutter/modulefiles
export OMP_NUM_THREADS=64
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
module load gcc/11.2.0
module load cmake/3.24.3
module load cray-mpich
module load cray-libsci
srun -n 512 ./build/release/tools/mpi-imm -i /global/cfs/cdirs/m1641/network-data/Binaries/friendster_IC_binary.txt -w -k 100 -p -d IC -e 0.13 -o /global/homes/w/wadecap/results/jobs/friendster/diimm_512_IC_friendster.json --reload-binary --DIiMM=true -u
