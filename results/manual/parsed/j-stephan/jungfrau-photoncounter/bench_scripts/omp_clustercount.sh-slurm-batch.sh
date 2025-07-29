#!/bin/bash
#SBATCH --job-name=ClusterCountCpu
#SBATCH --output=log.intel_clustercount.slurm-%A_%a.out
#SBATCH --error=err.intel_clustercount.slurm-%A_%a.out
#SBATCH --mail-user=j.schenke@hzdr.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=80
#SBATCH --mem=200000
#SBATCH --time=23:00:00
#SBATCH --partition=defq
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0-8

export alpaka_DIR='/home/schenk24/workspace/alpaka/'
export KMP_AFFINITY='verbose,compact'

set -x
export alpaka_DIR=/home/schenk24/workspace/alpaka/
module load git intel cmake boost python
export KMP_AFFINITY="verbose,compact"
cd ../build_omp
./bench 0 100 12.4 2 1 0 0 ../../../data_pool/synthetic/pede.bin ../../../data_pool/px_101016/gainMaps_M022.bin ../../../data_pool/synthetic/random_clusters_overlapping/cluster_$SLURM_ARRAY_TASK_ID.bin clustercount$SLURM_ARRAY_TASK_ID
