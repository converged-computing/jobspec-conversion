#!/bin/bash
#SBATCH --output=train-cseg-e5-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:rtx8000:1
#SBATCH --mem=128GB
#SBATCH --time=1-23:59:00
#SBATCH --constraint=ntasks-per-node=1

module purge;
singularity exec --nv \
            --overlay /scratch/ntl2689/pytorch-example/my_pytorch.ext3:ro \
            /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif \
            /bin/bash -c "source /ext3/env.sh; chmod u+x download_coco.sh; ./download_coco.sh; python /scratch/ntl2689/pytorch-example/cseg/train_net.py --num-gpu 1 --config-file /scratch/ntl2689/pytorch-example/cseg/configs/ovseg_swinB_vitL_bs32_coco.yaml MODEL.CLIP_ADAPTER.CLIP_ENSEMBLE_WEIGHT 0.5 OUTPUT_DIR ./output_e5"
