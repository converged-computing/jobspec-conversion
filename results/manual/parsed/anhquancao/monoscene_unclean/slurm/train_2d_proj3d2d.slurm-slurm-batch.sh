#!/bin/bash
#SBATCH --job-name=mnist
#SBATCH --account=kvd@gpu
#SBATCH --output=monoscene_%j.out
#SBATCH --error=monoscene_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:4
#SBATCH --time=14:59:00
#SBATCH --constraint=ntasks-per-node=1

module purge
conda deactivate
module load pytorch-gpu/py3/1.7.1
python $WORK/code/xmuda-extend/xmuda/train_2d_proj3d2d.py batch_size=4 n_gpus=4 enable_log=true exp_prefix=MoreConv_add16 project_1_2=true project_1_4=true project_1_8=true project_1_16=false run=3 dataset=NYU project_scale=4 frustum_size=8 class_proportion_loss=true context_prior=null n_relations=8 optimize_iou=true MCA_ssc_loss=true CE_relation_loss=false corenet_proj=null lr=1e-4 weight_decay=1e-4
