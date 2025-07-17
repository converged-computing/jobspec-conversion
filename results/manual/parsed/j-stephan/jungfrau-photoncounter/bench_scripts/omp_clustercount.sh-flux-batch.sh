#!/bin/bash
#FLUX: --job-name=ClusterCountCpu
#FLUX: -c=80
#FLUX: --exclusive
#FLUX: --queue=defq
#FLUX: -t=82800
#FLUX: --urgency=16

export alpaka_DIR='/home/schenk24/workspace/alpaka/'
export KMP_AFFINITY='verbose,compact'

set -x
export alpaka_DIR=/home/schenk24/workspace/alpaka/
module load git intel cmake boost python
export KMP_AFFINITY="verbose,compact"
cd ../build_omp
./bench 0 100 12.4 2 1 0 0 ../../../data_pool/synthetic/pede.bin ../../../data_pool/px_101016/gainMaps_M022.bin ../../../data_pool/synthetic/random_clusters_overlapping/cluster_$SLURM_ARRAY_TASK_ID.bin clustercount$SLURM_ARRAY_TASK_ID
