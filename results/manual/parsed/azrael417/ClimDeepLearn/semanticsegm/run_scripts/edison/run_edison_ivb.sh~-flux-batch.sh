#!/bin/bash
#FLUX: --job-name=eccentric-diablo-0074
#FLUX: --urgency=16

export OMP_NUM_THREADS='12'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'
export CRAY_CUDA_MPS='0'
export MPICH_RDMA_ENABLED_CUDA='1'

module unload PrgEnv-cray
module load PrgEnv-gnu
module load gcc/5.3.0
module load cudatoolkit/8.0.61_2.4.3-6.0.4.0_3.1__gb475d12
module load cray-hdf5/1.10.0.3
source activate tensorflow-hp
export OMP_NUM_THREADS=12
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
export CRAY_CUDA_MPS=0
export MPICH_RDMA_ENABLED_CUDA=1
datadir=/scratch/snx3000/tkurth/data/tiramisu/segm_h5_v3_reformat
scratchdir=/dev/shm/$(whoami)/tiramisu
numfiles=500
rundir=${WORK}/data/tiramisu/runs/scaling_2018-03-25/run_nnodes${SLURM_NNODES}_j${SLURM_JOBID}
mkdir -p ${rundir}
cp ../../tiramisu-tf/tiramisu_helpers.py ${rundir}/
cp ../../tiramisu-tf/mascarpone-tiramisu-tf-singlefile.py ${rundir}/
cp ./parallel_stagein.sh ${rundir}/
cp ../../tiramisu-tf/parallel_stagein.py ${rundir}/
cd ${rundir}
srun -N ${SLURM_NNODES} -n ${SLURM_NNODES} -c 24 ./parallel_stagein.sh ${datadir} ${scratchdir} ${numfiles}
srun -N ${SLURM_NNODES} -n ${SLURM_NNODES} -c 24 -u python -u ./mascarpone-tiramisu-tf-singlefile.py --fs local --datadir ${scratchdir} --blocks 2 2 2 4 5 --growth 32 --cluster_loss_weight 0.01 --filter-sz 5 --lr 1e-4 --optimizer="LARC-Adam" |& tee out.${SLURM_JOBID}
