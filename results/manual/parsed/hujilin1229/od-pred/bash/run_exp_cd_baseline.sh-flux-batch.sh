#!/bin/bash
#FLUX: --job-name=dirty-car-3741
#FLUX: -c=24
#FLUX: -t=86400
#FLUX: --urgency=16

echo Running on "$(hostname)"
echo Available nodes: "$SLURM_NODELIST"
echo Slurm_submit_dir: "$SLURM_SUBMIT_DIR"
echo Start time: "$(date)"
python baseline_train_cd.py --test_every_n_epochs 10 --sample_rate 15 --data_format 'speed' --seq_len 3 --horizon 3 --num_gpus 2 --fill_mean=False --sparse_removal=False --base_line 'gp' &
wait
