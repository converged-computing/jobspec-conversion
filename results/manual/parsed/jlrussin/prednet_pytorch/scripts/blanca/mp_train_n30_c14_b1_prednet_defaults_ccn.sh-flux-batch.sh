#!/bin/bash
#FLUX: --job-name=placid-soup-6466
#FLUX: -N=30
#FLUX: -n=30
#FLUX: -c=14
#FLUX: -t=259200
#FLUX: --urgency=16

export HOME='`getent passwd $USER | cut -d':' -f6`'
export PYTHONUNBUFFERED='1'
export MKL_NUM_THREADS='14 OMP_NUM_THREADS=14'

export HOME=`getent passwd $USER | cut -d':' -f6`
export PYTHONUNBUFFERED=1
echo Running on $HOSTNAME
source /pl/active/ccnlab/conda/etc/profile.d/conda.sh
conda activate pytorch_mpi
export MKL_NUM_THREADS=14 OMP_NUM_THREADS=14
echo "MKL_NUM_THREADS: "
echo $MKL_NUM_THREADS
echo "OMP_NUM_THREADS: "
echo $OMP_NUM_THREADS
mpirun -n 30 --map-by node:PE=14 python main.py \
--seed 0 \
--dataset CCN \
--train_data_path /pl/active/ccnlab/ccn_images/wwi_emer_imgs_20fg_8tick_rot1/train/ \
--seq_len 8 \
--batch_size 1 \
--num_iters 10000 \
--model_type PredNet \
--results_dir ../results/train_results \
--out_data_file mp_train_n30_c14_b1_prednet_defaults_ccn.json \
--checkpoint_path ../model_weights/mp_train_n30_c14_b1_prednet_defaults_ccn.pt \
--record_loss_every 100
