#!/bin/bash
#SBATCH --job-name=lnopt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --gres=4
#SBATCH --time=7-00:00:00
#SBATCH --constraint=a100

cd ~/denoiser_recon/
module load python/3.10 cuda cudnn nccl
source recon/bin/activate
MTD=Denoiser
LST=MSE
DCR=0.90
BSZ=64
NEP=16
LNR=0.0005
AVG=true
python3 linear.py --recon_method $MTD --loss_type $LST --decay_rate $DCR \
                  --n_sample $NSP --data_path $DST --model_path $MDP \
                  --lr $LNR --batch_size $BSZ --n_epoch $NEP --avg $AVG
