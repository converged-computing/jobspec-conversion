#!/bin/bash
#FLUX: --job-name=aspp
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=432000
#FLUX: --urgency=16

nvidia-smi
python -u train.py --batch_size 12 --epoch 200 \
	--num_workers 3 --save_path /export/team-mic/zhong/test/Resnet50_SINC_4 \
	--warmup 10000000 --net_cfg cfg/workers_overlap_gap.cfg \
       --fe_cfg cfg/Resnet50.cfg --do_eval --data_cfg /export/corpora/LibriSpeech_50h/librispeech_data_50h.cfg \
       --min_lr 0.0005 --fe_lr 0.001 --data_root /export/corpora/LibriSpeech_50h/wav_sel \
       --dtrans_cfg cfg/distortions/overlap.cfg \
       --stats data/librispeech_50h_stats.pkl \
       --chunk_size 32000 \
       --random_scale True \
       --backprop_mode base\
       --lr_mode poly \
       --tensorboard True \
       --sup_exec ./sup_cmd.txt --sup_freq 10 --log_freq 100
