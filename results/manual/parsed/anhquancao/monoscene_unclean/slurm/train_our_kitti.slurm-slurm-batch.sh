#!/bin/bash
#SBATCH --job-name=ablate_kitti
#SBATCH --account=kvd@gpu
#SBATCH --output=ablate_kitti_%j.out
#SBATCH --error=ablate_kitti_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:4
#SBATCH --time=19:59:00
#SBATCH --constraint=ntasks-per-node=1

module purge
conda deactivate
module load pytorch-gpu/py3/1.7.1
python $WORK/code/xmuda-extend/xmuda/train_2d_proj3d2d.py batch_size=4 n_gpus=4 enable_log=true exp_prefix=ManualGroup16 project_scale=2 project_1_2=true project_1_4=true project_1_8=true project_1_16=false run=3 dataset=kitti project_scale=2 class_proportion_loss=true frustum_size=8 virtual_img=false context_prior=CRCP weight_decay=0 optimize_iou=true MCA_ssc_loss=true CE_relation_loss=true n_relations=16 corenet_proj=null
