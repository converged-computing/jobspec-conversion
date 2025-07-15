#!/bin/bash
#FLUX: --job-name=pusheena-truffle-7623
#FLUX: -c=4
#FLUX: -t=86400
#FLUX: --urgency=16

echo Running on "$(hostname)"
echo Available nodes: "$SLURM_NODELIST"
echo Slurm_submit_dir: "$SLURM_SUBMIT_DIR"
echo Start time: "$(date)"
python mgrnn_train_hist.py --test_every_n_epochs 1 --sample_rate 15 --data_format 'speed' --seq_len 6 --horizon 3 \
--num_gpus 2 --fill_mean=False --sparse_removal=False --learning_rate 0.001 --lr_decay 0.8 --lr_decay_epoch 5 \
--batch_size 8 --loss_func 'L2Norm' --activate_func 'relu' --pool_type '_mpool' --drop_out 0.2 --use_curriculum_learning=True \
--sigma 12 --hopk 4 --optimizer 'adam' --is_restore=True \
--model_dir='./logs/mgrnn_L_h_3_32_8-32_4_lr_0.001_LrDecay0.8_LDE5_bs_8_d_0.2_sl_6_L2Norm_taxi_zone_speed_15_1028203017_False_sigma12_hopk4_adam_relu__mpool_0.0001/' \
--model_filename='models-0.0973-54324' &
wait
