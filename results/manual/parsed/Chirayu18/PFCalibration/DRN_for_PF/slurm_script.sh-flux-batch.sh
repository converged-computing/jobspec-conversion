#!/bin/bash
#FLUX: --job-name=ratio_full
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0,1,2,3  ## this line is to use 4 GPU nodes'

module load cdac/spack/0.17
source /home/apps/spack/share/spack/setup-env.sh
spack load python@3.8.2
source /home/apps/iiser/pytorch-venv/bin/activate
export CUDA_VISIBLE_DEVICES=0,1,2,3  ## this line is to use 4 GPU nodes
echo '-========================================================='
cd /home/bkansal/work/Bhumika/The_DRN_for_HGCAL/
./train /home/bkansal/work/Bhumika/The_DRN_for_HGCAL/Trained_eta2pt75_target_ratioflip_epoch100 /home/bkansal/work/Bhumika/The_DRN_for_HGCAL/pickle_eta2pt75 --idx_name all --nosemi --target ratioflip  --valid_batch_size 400 --train_batch_size 400 --acc_rate 2 --max_lr 0.0001 --n_epochs 100 --lr_sched Const  --in_layers 3 --mp_layers 2 --out_layers 2 --agg_layers 2 &>> /home/bkansal/work/Bhumika/The_DRN_for_HGCAL/Trained_eta2pt75_target_ratioflip_epoch100/training.log
