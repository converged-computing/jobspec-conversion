#!/bin/bash
#SBATCH --job-name=ofa_mini_video_vqa_pretrain_bart_allresnet_pretraintext_onlylinear
#SBATCH --account=gda2204
#SBATCH --output=/lus/home/NAT/gda2204/mshukor/logs/slurm/ofa_mini_video_vqa_pretrain_bart_allresnet_pretraintext_onlylinear_lr1e4.out
#SBATCH --mail-user=mustafa.shukor@isir.upmc.fr
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=2
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --gres=16
#SBATCH --time=1-00:00:00
#SBATCH --exclusive
#SBATCH --constraint=MI250

cd /lus/home/NAT/gda2204/mshukor/code/ofa_ours/run_scripts
source /lus/home/NAT/gda2204/mshukor/.bashrc
conda activate main
rm core-python3*
srun -l -N 2 -n 2 -c 128 --gpus=16 bash vqa/video/ofa_mini_video_vqa_pretrain_bart_allresnet_pretraintext_onlylinear.sh
