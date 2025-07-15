#!/bin/bash
#FLUX: --job-name=pretrain_both_mr_50
#FLUX: --queue=n1s8-v100-1
#FLUX: -t=43200
#FLUX: --urgency=16

singularity exec \
    --nv --overlay /scratch/nv2099/overlay-50G-10M.ext3:ro \
    --bind /scratch/nv2099 --bind /scratch_tmp/nv2099 \
    /scratch/nv2099/cuda11.3.0-cudnn8-devel-ubuntu20.04.sif \
    /bin/bash -c "
    source /ext3/miniconda3/etc/profile.d/conda.sh;
    conda activate vit_mae;
    cd /home/nv2099/projects/vit_mae/mae;
    python -u main_pretrain.py --mask_ratio 0.5 --accum_iter 2 --batch_size 32 --loss_type both \
        --resume runs/scratch/pretrain_both_mr_50_77716/checkpoint-20.pth --output_dir runs/scratch/${SLURM_JOB_NAME}_${SLURM_JOB_ID};
    # python -u main_finetune.py --batch_size 20 --finetune runs/scratch/pretrain_both_77423/checkpoint-49.pth \
    #     --output_dir runs/scratch/${SLURM_JOB_NAME}_${SLURM_JOB_ID};
    "
