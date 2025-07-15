#!/bin/bash
#FLUX: --job-name=creamy-peanut-7538
#FLUX: --urgency=16

echo "Start: `date`"
echo "UUID GPU List - original"
nvidia-smi -L # 실제 할당받은 gpu
UUIDLIST=$(nvidia-smi -L | cut -d '(' -f 2 | awk '{print$2}' | tr -d ")" | paste -s -d, -)
GPULIST=\"device=${UUIDLIST}\"
docker build -t nnunet_batch1 .
docker stop nnunet_batch_run_1
docker rm nnunet_batch_run_1
docker run --rm --name nnunet_batch_run_1 --shm-size 16G --gpus ${GPULIST} -v /home2/ych000/data/nnUNet_PATCH/nnUNet_trained_models:/data/nnUNet/nnUNet_trained_models -v /home2/ych000/data/nnUNet_PATCH/nnUNet_preprocessed:/data/nnUNet/nnUNet_preprocessed -v /home2/ych000/data/nnUNet_PATCH/nnUNet_raw_data_base:/data/nnUNet/nnUNet_raw_data_base nnunet_batch1
