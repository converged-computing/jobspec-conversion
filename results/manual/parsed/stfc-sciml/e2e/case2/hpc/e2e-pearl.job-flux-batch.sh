#!/bin/bash
#FLUX: --job-name=PEARLIntelE2E
#FLUX: --urgency=16

export SINGULARITYENV_PYTHONPATH='/work'

module load CUDA/10.1.243
module load OpenMPI/4.1.0-GCC-9.3.0
echo "Running on hosts: $SLURM_NODELIST"
echo "Running on $SLURM_NNODES nodes."
echo "Running $SLURM_NTASKS tasks."
TRAIN_DATA=/work/data/one-day
TRAIN_DATA_HDF=/work/data/hdf/one-day
OUTPUT_DIR=/work/results/run_$SLURM_JOB_ID
INFERENCE_DATA=/work/data/ssts
SST_FILE=/work/data/ssts/sst_matchups.h5
MODEL_FILE=$OUTPUT_DIR/model.h5
export SINGULARITYENV_PYTHONPATH=/work
mpirun -q \
	--mca btl_openib_allow_ib 1 \
	--mca btl_openib_if_include mlx5_0:1 \
	-x NCCL_DEBUG=INFO \
	-x LD_LIBRARY_PATH \
	-x PATH \
        -x HOROVOD_TIMELINE=$OUTPUT_DIR/timeline_train.json \
        -x NCCL_SOCKET_IFNAME=^lo,docker0 \
       singularity exec --nv -B ~/work/intel-e2e-benchmark/case2:/work hvd-mpi4.1.0.simg \
		python /work/e2e_benchmark/command.py train $TRAIN_DATA_HDF $OUTPUT_DIR --epochs 30
mpirun -q \
	--mca btl_openib_allow_ib 1 \
	--mca btl_openib_if_include mlx5_0:1 \
       -x NCCL_DEBUG=INFO \
       -x LD_LIBRARY_PATH \
       -x PATH \
       -x HOROVOD_TIMELINE=$OUTPUT_DIR/timeline_infer.json \
       -x NCCL_SOCKET_IFNAME=^lo,docker0 \
       singularity exec --nv -B ~/work/intel-e2e-benchmark/case2:/work hvd-mpi4.1.0.simg \
		python /work/e2e_benchmark/command.py inference $INFERENCE_DATA $OUTPUT_DIR
