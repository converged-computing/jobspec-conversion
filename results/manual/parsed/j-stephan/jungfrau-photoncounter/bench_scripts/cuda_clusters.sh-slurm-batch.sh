#!/bin/bash
#SBATCH --job-name=cuda_clusters
#SBATCH --account=fwkt_v100
#SBATCH --output=log.ob.slurm-%A_%a.out
#SBATCH --error=err.ob.slurm-%A_%a.out
#SBATCH --mail-user=j.schenke@hzdr.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --gres=gpu:4
#SBATCH --mem=150000
#SBATCH --time=10:00:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=1

export alpaka_DIR='/home/schenk24/workspace/alpaka/install/'
export GOMP_CPU_AFFINITY='0-11'
export OMP_PROC_BIND='true'
export CUDA_VISIBLE_DEVICES='0,1,2,3'

set -x
export alpaka_DIR=/home/schenk24/workspace/alpaka/install/
module load git cuda gcc cmake boost python
export GOMP_CPU_AFFINITY=0-11
export OMP_PROC_BIND=true
unset CUDA_VISIBLE_DEVICES
export CUDA_VISIBLE_DEVICES=0
cd ../build_cuda_1
./bench 0 100 12.4 2 1 0 0 ../../../data_pool/px_101016/allpede_250us_1243__B_000000.dat ../../../data_pool/px_101016/gainMaps_M022.bin ../../../data_pool/px_101016/Insu_6_tr_1_45d_250us__B_000000.dat cuda1 /bigdata/hplsim/production/jungfrau-photoncounter/reference/cluster_energy.bin /bigdata/hplsim/production/jungfrau-photoncounter/reference/bin/photon.bin /bigdata/hplsim/production/jungfrau-photoncounter/reference/maxValues.bin /bigdata/hplsim/production/jungfrau-photoncounter/reference/sum.bin /bigdata/hplsim/production/jungfrau-photoncounter/reference/clusters.bin
unset CUDA_VISIBLE_DEVICES
export CUDA_VISIBLE_DEVICES=0,2
cd ../build_cuda_2
./bench 0 100 12.4 2 1 0 0 ../../../data_pool/px_101016/allpede_250us_1243__B_000000.dat ../../../data_pool/px_101016/gainMaps_M022.bin ../../../data_pool/px_101016/Insu_6_tr_1_45d_250us__B_000000.dat cuda2 /bigdata/hplsim/production/jungfrau-photoncounter/reference/cluster_energy.bin /bigdata/hplsim/production/jungfrau-photoncounter/reference/bin/photon.bin /bigdata/hplsim/production/jungfrau-photoncounter/reference/maxValues.bin /bigdata/hplsim/production/jungfrau-photoncounter/reference/sum.bin /bigdata/hplsim/production/jungfrau-photoncounter/reference/clusters.bin
unset CUDA_VISIBLE_DEVICES
export CUDA_VISIBLE_DEVICES=0,1,2
cd ../build_cuda_3
./bench 0 100 12.4 2 1 0 0 ../../../data_pool/px_101016/allpede_250us_1243__B_000000.dat ../../../data_pool/px_101016/gainMaps_M022.bin ../../../data_pool/px_101016/Insu_6_tr_1_45d_250us__B_000000.dat cuda2 /bigdata/hplsim/production/jungfrau-photoncounter/reference/cluster_energy.bin /bigdata/hplsim/production/jungfrau-photoncounter/reference/bin/photon.bin /bigdata/hplsim/production/jungfrau-photoncounter/reference/maxValues.bin /bigdata/hplsim/production/jungfrau-photoncounter/reference/sum.bin /bigdata/hplsim/production/jungfrau-photoncounter/reference/clusters.bin
unset CUDA_VISIBLE_DEVICES
export CUDA_VISIBLE_DEVICES=0,1,2,3
cd ../build_cuda_4
./bench 0 100 12.4 2 1 0 0 ../../../data_pool/px_101016/allpede_250us_1243__B_000000.dat ../../../data_pool/px_101016/gainMaps_M022.bin ../../../data_pool/px_101016/Insu_6_tr_1_45d_250us__B_000000.dat cuda4 /bigdata/hplsim/production/jungfrau-photoncounter/reference/cluster_energy.bin /bigdata/hplsim/production/jungfrau-photoncounter/reference/bin/photon.bin /bigdata/hplsim/production/jungfrau-photoncounter/reference/maxValues.bin /bigdata/hplsim/production/jungfrau-photoncounter/reference/sum.bin /bigdata/hplsim/production/jungfrau-photoncounter/reference/clusters.bin
