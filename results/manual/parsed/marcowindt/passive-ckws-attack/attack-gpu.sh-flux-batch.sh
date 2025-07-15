#!/bin/bash
#FLUX: --job-name=ckws_adapted_refined_score_attack_GPU
#FLUX: -c=16
#FLUX: --queue=gpu_p100
#FLUX: --urgency=16

export TF_FORCE_GPU_ALLOW_GROWTH='true'

module load nvidia/cuda-11.0
module load nvidia/cuda-11.0_cudnn-8.1
module load nvidia/cuda-11.0_tensorrt-7.2
module load nvidia/cuda-11.0_nccl-2.8
module load nvidia/nvtop
export TF_FORCE_GPU_ALLOW_GROWTH=true
srun python3 -m ckws_adapted_score_attack.generate_results
