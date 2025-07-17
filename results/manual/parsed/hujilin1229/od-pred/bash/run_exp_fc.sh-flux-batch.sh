#!/bin/bash
#FLUX: --job-name=gloopy-fudge-3745
#FLUX: -c=12
#FLUX: -t=86400
#FLUX: --urgency=16

echo Running on "$(hostname)"
echo Available nodes: "$SLURM_NODELIST"
echo Slurm_submit_dir: "$SLURM_SUBMIT_DIR"
echo Start time: "$(date)"
module load intel/2018.05
module load openmpi/3.0.2
python fcgrnn_train.py --test_every_n_epochs 10 --sample_rate 15 --data_format 'speed' \
--seq_len 6 --horizon 3 --num_gpus 2 --fill_mean=False --sparse_removal=False --learning_rate 0.001 --lr_decay 0.8 \
--lr_decay_epoch 5 --batch_size 8 --loss_func 'L2Norm' --drop_out 0.2 --use_curriculum_learning=True --sigma 9 \
--hopk 2 --optimizer 'adam' --fc_method='od' --trace_ratio 0.00001 &
wait
