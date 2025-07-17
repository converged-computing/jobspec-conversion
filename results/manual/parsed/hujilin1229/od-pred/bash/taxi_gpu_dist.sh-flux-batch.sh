#!/bin/bash
#FLUX: --job-name=cowy-lentil-8222
#FLUX: -N=3
#FLUX: -c=12
#FLUX: -t=86400
#FLUX: --urgency=16

echo Running on "$(hostname)"
echo Available nodes: "$SLURM_NODELIST"
echo Slurm_submit_dir: "$SLURM_SUBMIT_DIR"
echo Start time: "$(date)"
module load intel/2018.05
module load openmpi/3.0.2
HOROVOD_TIMELINE=/work/aauhpc/jilin/code/svn_code/od_prediction/horovod_timeline/taxizone6.json srun -N 3 -n 6 -x NCCL_DEBUG=INFO -x LD_LIBRARY_PATH -x HOROVOD_TIMELINE python mgrnn_horovod_train.py --batch_size 4 --test_every_n_epochs 10 --sample_rate 15 --zone 'taxi_zone' --fill_mean True --learning_rate 0.001 --lr_decay 0.8 --lr_decay_epoch 10 & 
wait
