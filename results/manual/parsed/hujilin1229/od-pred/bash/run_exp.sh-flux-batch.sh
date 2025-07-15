#!/bin/bash
#FLUX: --job-name=joyous-cherry-4193
#FLUX: -c=24
#FLUX: -t=86400
#FLUX: --urgency=16

echo Running on "$(hostname)"
echo Available nodes: "$SLURM_NODELIST"
echo Slurm_submit_dir: "$SLURM_SUBMIT_DIR"
echo Start time: "$(date)"
module load intel/2018.05
module load openmpi/3.0.2
srun -n 1 --exclusive python mgrnn_train_hist.py --test_every_n_epochs 1 --sample_rate 15 --data_format 'speed' \
--seq_len 3 --horizon 3 --num_gpus 2 --fill_mean=False --sparse_removal=False --learning_rate 0.001 --lr_decay 0.8 \
--lr_decay_epoch 5 --batch_size 8 --loss_func 'L2Norm' --activate_func 'relu' --pool_type '_mpool' --drop_out 0.2 \
--use_curriculum_learning=True --sigma 6 --hopk 2 --optimizer 'adam' &
wait
