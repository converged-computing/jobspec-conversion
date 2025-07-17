#!/bin/bash
#FLUX: --job-name=M1
#FLUX: -c=16
#FLUX: -t=1800
#FLUX: --urgency=16

module purge
singularity exec --nv \
            --overlay /scratch/yp2285/ws_nerf/overlay-50G-10M.ext3:ro \
            /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif \
            /bin/bash -c "source /ext3/env.sh; python /scratch/yp2285/ws_nerf/detectron2/src/main.py --config-file /scratch/yp2285/ws_nerf/detectron2/projects/MViTv2/configs/cascade_mask_rcnn_mvitv2_b_in21k_3x.py --input_data images --output_path results --eval-only --opts train.init_checkpoint=/scratch/yp2285/ws_nerf/detectron2/checkpoints/model_final_be5168.pkl"
