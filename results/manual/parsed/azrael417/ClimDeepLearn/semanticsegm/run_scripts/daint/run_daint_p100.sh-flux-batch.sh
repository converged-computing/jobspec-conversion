#!/bin/bash
#FLUX: --job-name=joyous-latke-1237
#FLUX: --priority=16

export OMP_NUM_THREADS='12'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'
export CRAY_CUDA_MPS='0'
export MPICH_RDMA_ENABLED_CUDA='1'

module unload PrgEnv-cray
module load PrgEnv-gnu
module load gcc/5.3.0
module load cudatoolkit/8.0.61_2.4.3-6.0.4.0_3.1__gb475d12
source activate tensorflow-py27
export OMP_NUM_THREADS=12
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
export CRAY_CUDA_MPS=0
export MPICH_RDMA_ENABLED_CUDA=1
datadir=/scratch/snx3000/tkurth/data/segm_h5_v3_new_split
scratchdir=/dev/shm/$(whoami)
numfiles_train=200
numfiles_validation=20
run_dir=${WORK}/data/deeplab/runs/run_nnodes${SLURM_NNODES}_j${SLURM_JOBID}
mkdir -p ${run_dir}
cp stage_in_parallel.sh ${run_dir}/
cp ../../utils/parallel_stagein.py ${run_dir}/
cp ../../utils/graph_flops.py ${run_dir}/
cp ../../utils/climseg_helpers.py ${run_dir}/
cp ../../deeplab-tf/deeplab-tf.py ${run_dir}/
cd ${run_dir}
srun -N ${SLURM_NNODES} -n ${SLURM_NNODES} -c 24 ./stage_in_parallel.sh ${datadir} ${scratchdir} ${numfiles_train} ${numfiles_validation}
srun -N ${SLURM_NNODES} -n ${SLURM_NNODES} -c 24 -u python ./deeplab-tf.py --datadir_train ${scratchdir}/train/data --datadir_validation ${scratchdir}/validation/data --chkpt_dir checkpoint.fp32.lag1 --epochs 4 --fs local --loss weighted --cluster_loss_weight 0.0 --optimizer opt_type=LARC-Adam,learning_rate=0.001,gradient_lag=0 --model=resnet_v2_50 --scale_factor 0.1 --batch 1 --decoder=deconv1x |& tee out.fp32.lag1.${SLURM_JOBID}
