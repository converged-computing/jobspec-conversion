#!/bin/bash
#FLUX: --job-name=paralleltest
#FLUX: -N=2
#FLUX: --queue=premium
#FLUX: -t=36000
#FLUX: --urgency=16

export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'
export OMP_NUM_THREADS='$NTH'

module load PrgEnv-gnu
CORES_PER_NODE=128
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
if [[ $(uname -s) == 'Darwin' ]]; then
    export GPTUNEROOT=/Users/liuyangzhuan/Desktop/GPTune/
    export MPIRUN="$GPTUNEROOT/openmpi-4.1.5/bin/mpirun"
else
    export MPIRUN=mpirun
fi
NTH=1
THREADS_PER_RANK=`expr $NTH \* 2`								 
export OMP_NUM_THREADS=$NTH
tol=1e-2
nmpi=1
wavelen=0.03125
zdist=1.0
ppw=4.0
nmin_leaf_t=16
nmin_leaf_m=4096
lrlevel=0
srun -n ${nmpi} -c $THREADS_PER_RANK --cpu_bind=cores ../build/EXAMPLE/frankben_t -quant --tst 3 --wavelen ${wavelen} --zdist ${zdist} --ppw ${ppw} -option --xyzsort 1 --nmin_leaf ${nmin_leaf_t} --lrlevel ${lrlevel} --verbosity 1 --tol_comp $tol --sample_para 0.8 --sample_para_outer 0.8 --fastsample_tensor 2 | tee a.out_tensor_3d_green_wavelen${wavelen}_zdist${zdist}_tol${tol}_mpi${nmpi}_omp${NTH}_nmin_leaf_t${nmin_leaf_t}_ppw${ppw}_lrlevel${lrlevel}
