#!/bin/bash
#FLUX: --job-name=astute-chip-0025
#FLUX: -c=2
#FLUX: --urgency=16

export SINGULARITYENV_PYTHONPATH='/work'

module load OpenMPI/4.0.0-GCC-8.2.0-2.31.1
echo "Running on hosts: $SLURM_NODELIST"
echo "Running on $SLURM_NNODES nodes."
echo "Running $SLURM_NTASKS tasks."
IMAGE=hvd-scarf.simg
WORKDIR=~/data/scarf688/projects/intel-e2e-benchmark/case2
TRAIN_DATA=/work/data/one-day
TRAIN_DATA_HDF=/work/data/hdf/one-day
TEST_DATA=/work/data/ssts
OUTPUT_DIR=/work/results/run_$SLURM_JOB_ID
SST_FILE=/work/data/ssts/sst_matchups.h5
MODEL_FILE=$OUTPUT_DIR/model.h5
export SINGULARITYENV_PYTHONPATH=/work
mpirun -bind-to none -map-by slot \
       -x NCCL_DEBUG=INFO \
       -x LD_LIBRARY_PATH \
       -x PATH \
       -x HOROVOD_TIMELINE=$OUTPUT_DIR/timeline_train.json \
        singularity run --nv -B $WORKDIR:/work $IMAGE \
            python /work/e2e_benchmark/command.py train $TRAIN_DATA_HDF $OUTPUT_DIR --epochs 30 --no-cache
mpirun -bind-to none \
       -map-by slot \
       -x NCCL_DEBUG=INFO \
       -x LD_LIBRARY_PATH \
       -x PATH \
       -x HOROVOD_TIMELINE=$OUTPUT_DIR/timeline_infer.json \
        singularity run --nv -B $WORKDIR:/work $IMAGE \
                python /work/e2e_benchmark/command.py inference $TEST_DATA $OUTPUT_DIR
