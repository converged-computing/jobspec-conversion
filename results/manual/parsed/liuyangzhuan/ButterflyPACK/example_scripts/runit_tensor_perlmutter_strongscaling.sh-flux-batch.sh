#!/bin/bash
#FLUX: --job-name=stanky-parsnip-4793
#FLUX: --urgency=16

export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'
export OMP_NUM_THREADS='$NTH'

module load PrgEnv-gnu
module unload cray-libsci
CORES_PER_NODE=128
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
if [[ $(uname -s) == 'Darwin' ]]; then
    export GPTUNEROOT=/Users/liuyangzhuan/Desktop/GPTune/
    export MPIRUN="$GPTUNEROOT/openmpi-4.1.5/bin/mpirun"
else
    export MPIRUN=mpirun
fi
NTH=16
THREADS_PER_RANK=`expr $NTH \* 2`								 
export OMP_NUM_THREADS=$NTH
tol=1e-5
nmpi=128
ndim_FIO=3
use_zfp=1
for N_FIO in 256
do
srun -n ${nmpi} -c $THREADS_PER_RANK --cpu_bind=cores ../build/EXAMPLE/frankben_t -quant --tst 10 --ndim_FIO ${ndim_FIO} --N_FIO ${N_FIO} -option --nmin_leaf 2  --xyzsort 0 --use_zfp ${use_zfp} --lrlevel 100 --verbosity 1 --tol_comp $tol --pat_comp 3 --sample_para 0.8 --sample_para_outer 0.8 --fastsample_tensor 2 | tee a.out_tensor_DFT_ndim_FIO${ndim_FIO}_N_FIO${N_FIO}_tol${tol}_mpi${nmpi}_omp${NTH}_use_zfp${use_zfp}
done
