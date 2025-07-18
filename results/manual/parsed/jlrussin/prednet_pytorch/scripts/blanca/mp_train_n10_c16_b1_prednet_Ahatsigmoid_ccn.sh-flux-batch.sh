#!/bin/bash
#FLUX: --job-name=goodbye-signal-7388
#FLUX: -n=10
#FLUX: -c=16
#FLUX: -t=259200
#FLUX: --urgency=16

export HOME='`getent passwd $USER | cut -d':' -f6`'
export PYTHONUNBUFFERED='1'
export MKL_NUM_THREADS='16 OMP_NUM_THREADS=16'

export HOME=`getent passwd $USER | cut -d':' -f6`
export PYTHONUNBUFFERED=1
echo Running on $HOSTNAME
source /pl/active/ccnlab/conda/etc/profile.d/conda.sh
conda activate pytorch_mpi
export MKL_NUM_THREADS=16 OMP_NUM_THREADS=16
echo "MKL_NUM_THREADS: "
echo $MKL_NUM_THREADS
echo "OMP_NUM_THREADS: "
echo $OMP_NUM_THREADS
mpirun -n 10 --map-by node:PE=16 python main.py \
--seed 0 \
--dataset CCN \
--train_data_path /pl/active/ccnlab/ccn_images/wwi_emer_imgs_20fg_8tick_rot1/train/ \
--seq_len 8 \
--batch_size 1 \
--num_iters 15000 \
--model_type PredNet \
--Ahat_act sigmoid \
--use_satlu False \
--results_dir ../results/train_results \
--out_data_file mp_train_n10_c16_b1_prednet_Ahatsigmoid_ccn.json \
--checkpoint_path ../model_weights/mp_train_n10_c16_b1_prednet_Ahatsigmoid_ccn.pt \
--record_loss_every 200
