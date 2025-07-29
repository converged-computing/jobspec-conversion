#!/bin/bash
#FLUX: --job-name=building_friendster_LT
#FLUX: --queue=preempt
#FLUX: -t=86400
#FLUX: --urgency=16

export OMP_NUM_THREADS='128'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

module use /global/common/software/m3169/perlmutter/modulefiles
export OMP_NUM_THREADS=128
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
module load gcc/11.2.0
module load cmake/3.24.3
module load cray-mpich
module load cray-libsci
srun -n 1 ~/ripples/build/release/tools/dump-graph -i /global/cfs/cdirs/m1641/network-data/test_data/com-friendster.ungraph.txt --distribution uniform -d LT -o /global/homes/w/wadecap/friendster_LT_binary.txt --scale-factor 0.1 --dump-binary
