#!/bin/bash
#FLUX: --job-name=phat-frito-1220
#FLUX: -c=8
#FLUX: -t=172740
#FLUX: --priority=16

module purge;
singularity exec --nv \
            --overlay /scratch/ntl2689/pytorch-example/my_pytorch.ext3:ro \
            /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif \
            /bin/bash -c "source /ext3/env.sh; chmod u+x download_coco.sh; ./download_coco.sh; python /scratch/ntl2689/pytorch-example/cseg/train_net.py --num-gpu 1 --config-file /scratch/ntl2689/pytorch-example/cseg/configs/ovseg_swinB_vitL_bs32_coco.yaml MODEL.CLIP_ADAPTER.CLIP_ENSEMBLE_WEIGHT 0.0 OUTPUT_DIR ./output_e0_ft"
