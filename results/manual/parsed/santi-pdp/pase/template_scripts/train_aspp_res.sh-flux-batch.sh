#!/bin/bash
#FLUX: --job-name=lovable-despacito-2073
#FLUX: --priority=16

nvidia-smi
python -u  train.py --batch_size 10 --epoch 50 --save_path /export/team-mic/zhong/test/aspp_res2d_rev_noise_half_gd \
       --num_workers 2 --warmup 10000000 --net_cfg cfg/workers.cfg \
       --fe_cfg cfg/PASE_aspp_res.cfg --do_eval --data_cfg /export/corpora/LibriSpeech_50h/librispeech_data_50h.cfg \
       --min_lr 0.0005 --fe_lr 0.0005 --data_root /export/corpora/LibriSpeech_50h/wav_sel \
       --dtrans_cfg cfg/distortions/half.cfg \
       --stats data/librispeech_50h_stats.pkl \
       --chunk_size 32000 \
       --random_scale True \
       --backprop_mode base\
       --lr_mode poly \
       --tensorboard True \
       --sup_exec ./sup_cmd.txt --sup_freq 10 --log_freq 100
