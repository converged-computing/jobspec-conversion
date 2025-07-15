#!/bin/bash
#FLUX: --job-name=eccentric-milkshake-6996
#FLUX: -n=8
#FLUX: --priority=16

export DVS_MAXNODES='24_'
export MPICH_MPIIO_DVS_MAXNODES='24'

module load PrgEnv-gnu/8.5.0
module load craype-accel-nvidia80
module load cray-mpich/8.1.28
module load cudatoolkit/12.0
module load nccl/2.18.3-cu12
export DVS_MAXNODES=24_
export MPICH_MPIIO_DVS_MAXNODES=24
echo "srun -u -n 8 --gpus 8 ./rt_gk_sheath_2x2v_p1 -g -M -c 1 -d 8"
srun -u -n 8 --gpus 8 ./rt_gk_sheath_2x2v_p1 -g -M -c 1 -d 8
