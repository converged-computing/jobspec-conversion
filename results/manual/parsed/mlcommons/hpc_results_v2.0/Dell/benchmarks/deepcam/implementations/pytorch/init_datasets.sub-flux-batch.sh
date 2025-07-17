#!/bin/bash
#FLUX: --job-name=mlperf-hpc:deepcam
#FLUX: --urgency=16

export CONTAINER_IMAGE='mlperf-deepcam:v1.0'
export DATASET_INPUT_DIR='<hdf5-dataset-path>'
export DATASET_OUTPUT_DIR='<numpy-dataset-path>'
export RANKS_PER_NODE='1'

export CONTAINER_IMAGE=mlperf-deepcam:v1.0
export DATASET_INPUT_DIR=<hdf5-dataset-path>
export DATASET_OUTPUT_DIR=<numpy-dataset-path>
export RANKS_PER_NODE=1
readonly _cont_name="mlperf_deepcam_convert_dataset"
readonly _cont_mounts="${DATASET_INPUT_DIR}:/data_in:ro,${DATASET_OUTPUT_DIR}:/data_out:rw"
mkdir -p ${DATASET_OUTPUT_DIR}/train
mkdir -p ${DATASET_OUTPUT_DIR}/validation
cp ${DATASET_INPUT_DIR}/stats.h5 ${DATASET_OUTPUT_DIR}/
srun --ntasks="${SLURM_JOB_NUM_NODES}" --container-image="${CONTAINER_IMAGE}" --container-name=${_cont_name} true
srun --mpi=pmix --ntasks=$(( ${SLURM_JOB_NUM_NODES} * ${RANKS_PER_NODE} )) --ntasks-per-node=${RANKS_PER_NODE} \
     --container-name=${_cont_name} --container-mounts="${_cont_mounts}" \
     --container-workdir /workspace \
     python /opt/utils/convert_hdf52npy.py \
     --input_directory=/data_in/train \
     --output_directory=/data_out/train
srun --mpi=pmix --ntasks=$(( ${SLURM_JOB_NUM_NODES} * ${RANKS_PER_NODE} )) --ntasks-per-node=${RANKS_PER_NODE} \
     --container-name=${_cont_name} --container-mounts="${_cont_mounts}" \
     --container-workdir /workspace \
     python /opt/utils/convert_hdf52npy.py \
     --input_directory=/data_in/validation \
     --output_directory=/data_out/validation
