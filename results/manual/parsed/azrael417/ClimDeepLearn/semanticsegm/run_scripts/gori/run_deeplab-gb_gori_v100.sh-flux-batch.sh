#!/bin/bash
#FLUX: --job-name=purple-rabbit-1842
#FLUX: --exclusive
#FLUX: --urgency=16

export OMP_NUM_THREADS='$(( 40 / ${rankspernode} ))'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'
export HDF5_USE_FILE_LOCKING='FALSE'

module load cuda
module load nccl
module load python3/3.6-anaconda-4.4
source activate thorstendl-gori-py3-tf 
rankspernode=1
export OMP_NUM_THREADS=$(( 40 / ${rankspernode} ))
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
export HDF5_USE_FILE_LOCKING=FALSE
sruncmd="srun -u --mpi=pmi2 -N ${SLURM_NNODES} -n $(( ${SLURM_NNODES} * ${rankspernode} )) -c $(( 80 / ${rankspernode} )) --cpu_bind=sockets"
run_dir=/project/projectdirs/mpccc/tkurth/DataScience/gb2018/runs/deeplab-old/run1_ngpus1
mkdir -p ${run_dir}
rm -rf ${run_dir}/*
cp ../../deeplab-tf/deeplab-gb-tf.py ${run_dir}/
cp ../../utils/common_helpers.py ${run_dir}/
cp ../../utils/data_helpers.py ${run_dir}/
cp ../../utils/graph_flops.py ${run_dir}/
cd ${run_dir}
datadir=/project/projectdirs/mpccc/tkurth/DataScience/gb2018/data/segm_h5_v3_new_split_maeve
${sruncmd} python -u deeplab-gb-tf.py --fs local --datadir_train ${datadir}/train --datadir_validation ${datadir}/validation --cluster_loss_weight 0.0 --scale_factor=0.1 --decoder="deconv1x"  --optimizer opt_type=LARC-Adam,learning_rate=0.0001,gradient_lag=0 --epochs 20 --dtype float16 --batch 2
