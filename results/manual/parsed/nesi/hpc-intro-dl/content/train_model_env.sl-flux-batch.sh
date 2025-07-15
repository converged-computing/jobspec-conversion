#!/bin/bash
#FLUX: --job-name=blank-poodle-5352
#FLUX: -c=2
#FLUX: --queue=hgx
#FLUX: -t=600
#FLUX: --priority=16

nvidia-smi
echo "CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES}"
module purge
module load TensorFlow/2.13.0-gimkl-2022a-Python-3.11.3
python train_model.py "${SLURM_JOB_ID}_${SLURM_JOB_NAME}"
