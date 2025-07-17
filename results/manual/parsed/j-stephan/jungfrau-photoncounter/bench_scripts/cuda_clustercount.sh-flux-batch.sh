#!/bin/bash
#FLUX: --job-name=ClusterCountGpu
#FLUX: -c=24
#FLUX: --exclusive
#FLUX: --queue=fwkt_v100
#FLUX: -t=36000
#FLUX: --urgency=16

export alpaka_DIR='/home/schenk24/workspace/alpaka/'
export CUDA_VISIBLE_DEVICES='0'
export GOMP_CPU_AFFINITY='0-11'
export OMP_PROC_BIND='true'

set -x
export alpaka_DIR=/home/schenk24/workspace/alpaka/
module load git gcc cuda cmake boost python
export CUDA_VISIBLE_DEVICES=0
export GOMP_CPU_AFFINITY=0-11
export OMP_PROC_BIND=true
cd ../build_cuda_1
./bench 0 100 12.4 2 1 0 0 ../../../data_pool/synthetic/pede.bin ../../../data_pool/px_101016/gainMaps_M022.bin ../../../data_pool/synthetic/random_clusters_overlapping/cluster_$SLURM_ARRAY_TASK_ID.bin clustercount$SLURM_ARRAY_TASK_ID
