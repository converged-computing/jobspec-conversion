#!/bin/bash
#FLUX: --job-name=blank-salad-2651
#FLUX: -c=6
#FLUX: -t=86400
#FLUX: --urgency=16

python fcgrnn_train.py --test_every_n_epochs 10 --sample_rate 15 --data_format 'speed' --seq_len 6 \
 --horizon 3 --num_gpus 2 --fill_mean=False --sparse_removal=False --learning_rate 0.001 --lr_decay 0.8 --lr_decay_epoch 5 \
 --batch_size 8 --loss_func 'L2' --activate_func 'tanh' --pool_type '_mpool' --drop_out 0.0 --use_curriculum_learning=True \
 --sigma 9 --hopk 2 --optimizer 'adam' --fc_method='direct' --trace_ratio 0.1 --is_restore=True \
 --model_dir='./logs/fcrnn_L_h_3_FC3-FC3_lr_0.001_bs_8_d_0.0_sl_6_L2_taxi_zone_speed_15_1029180954_direct_0.0' --model_filename='models-0.0876-26156' &
python fcgrnn_train.py --test_every_n_epochs 10 --sample_rate 15 --data_format 'speed' --seq_len 3 \
 --horizon 3 --num_gpus 2 --fill_mean=False --sparse_removal=False --learning_rate 0.001 --lr_decay 0.8 --lr_decay_epoch 5 \
 --batch_size 8 --loss_func 'L2' --activate_func 'tanh' --pool_type '_mpool' --drop_out 0.0 --use_curriculum_learning=True \
 --sigma 9 --hopk 2 --optimizer 'adam' --fc_method='direct' --trace_ratio 0.1 --is_restore=True \
 --model_dir='./logs/fcrnn_L_h_3_FC3-FC3_lr_0.001_bs_8_d_0.2_sl_3_L2Norm_taxi_zone_speed_15_1105211120_direct_0.0/' \
 --model_filename='models-0.0977-90574' &
wait
