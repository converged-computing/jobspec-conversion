#!/bin/bash
#FLUX: --job-name=fuzzy-arm-6365
#FLUX: --priority=16

python fcgrnn_train_cd.py --test_every_n_epochs 10 --sample_rate 15 --data_format 'speed' \
--seq_len 3 --horizon 3 --num_gpus 2 --fill_mean=False --sparse_removal=False --learning_rate 0.001 --lr_decay 0.8 \
--lr_decay_epoch 5 --batch_size 8 --loss_func 'L2Norm' --activate_func 'tanh' --pool_type '_mpool' --drop_out 0.4 \
--use_curriculum_learning=True --sigma 9 --hopk 4 --optimizer 'adam' --fc_method='od' --trace_ratio 0.00001 \
--is_restore=True --model_dir='./logs/fcrnn_L_h_3_FC2-FC2_lr_0.001_bs_8_d_0.2_sl_3_L2Norm_polygon_speed_15_1105211013_od_1e-05' \
--model_filename='models-0.1263-14427' &
wait
