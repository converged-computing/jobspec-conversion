#!/bin/bash
#SBATCH --job-name=ofa_mini_audio_caption_stage_1_ofa_mini_pretrain_bart_allresnet_ep10
#SBATCH --account=gda2204
#SBATCH --output=/lus/home/NAT/gda2204/mshukor/logs/slurm/ofa_mini_audio_caption_stage_1_ofa_mini_pretrain_bart_allresnet_ep10.out
#SBATCH --mail-user=mustafa.shukor@isir.upmc.fr
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=8
#SBATCH --time=01:00:00
#SBATCH --exclusive
#SBATCH --constraint=MI250

cd /lus/home/NAT/gda2204/mshukor/code/ofa_ours/run_scripts
source /lus/home/NAT/gda2204/mshukor/.bashrc
conda activate main
rm core-python3*
srun -l -N 1 -n 1 -c 128 --gpus=8 bash caption/audio/ofa_mini_audio_caption_stage_1_ofa_mini_pretrain_bart_allresnet_ep10.sh
