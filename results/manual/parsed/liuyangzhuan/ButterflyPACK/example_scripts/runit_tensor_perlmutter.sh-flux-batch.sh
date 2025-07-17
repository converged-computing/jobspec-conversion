#!/bin/bash
#FLUX: --job-name=tensorbf
#FLUX: -N=16
#FLUX: --queue=regular
#FLUX: -t=36000
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
NTH=8
THREADS_PER_RANK=`expr $NTH \* 2`								 
export OMP_NUM_THREADS=$NTH
tol=1e-2
nmpi=64
zdist=0.001
ppw=4.0
nmin_leaf_t=4
nmin_leaf_m=64
use_zfp=1
for wavelen in 0.0625 
do
srun -n ${nmpi} -c $THREADS_PER_RANK --cpu_bind=cores ../build/EXAMPLE/frankben -quant --tst 3 --wavelen ${wavelen} --zdist ${zdist} --ppw ${ppw} -option --xyzsort 1 --nmin_leaf ${nmin_leaf_m} --lrlevel 100 --verbosity 1 --tol_comp $tol --sample_para 2.0 --knn 10 --sample_para_outer 2.0  | tee a.out_matrix_3d_green_wavelen${wavelen}_zdist${zdist}_tol${tol}_mpi${nmpi}_omp${NTH}_nmin_leaf_m${nmin_leaf_m}_ppw${ppw}
done
NTH=8
THREADS_PER_RANK=`expr $NTH \* 2`								 
export OMP_NUM_THREADS=$NTH
tol=1e-3
nmpi=256
use_zfp=1
for N_FIO in 64 128 256 512
do
srun -n ${nmpi} -c $THREADS_PER_RANK --cpu_bind=cores ../build/EXAMPLE/frankben_t -quant --tst 9 --N_FIO ${N_FIO} -option --nmin_leaf 2  --xyzsort 1 --use_zfp ${use_zfp} --lrlevel 100 --verbosity 1 --tol_comp $tol --pat_comp 3 --sample_para 0.6 --sample_para_outer 0.6 --fastsample_tensor 2 | tee a.out_tensor_Radon3D_sphere_N_FIO${N_FIO}_tol${tol}_mpi${nmpi}_omp${NTH}_use_zfp${use_zfp}_fastsample_tensor2
done
