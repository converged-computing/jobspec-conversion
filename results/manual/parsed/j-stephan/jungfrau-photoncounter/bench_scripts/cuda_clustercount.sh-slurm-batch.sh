#!/bin/bash
#SBATCH --job-name=ClusterCountGpu
#SBATCH --account=fwkt_v100
#SBATCH --output=log.ob.slurm-%A_%a.out
#SBATCH --error=err.ob.slurm-%A_%a.out
#SBATCH --mail-user=j.schenke@hzdr.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --gres=gpu:2
#SBATCH --mem=200000
#SBATCH --time=10:00:00
#SBATCH --partition=fwkt_v100
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0-8

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
