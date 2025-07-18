#!/bin/bash
#FLUX: --job-name=nsfw
#FLUX: -c=12
#FLUX: --queue=gpgpu
#FLUX: -t=172800
#FLUX: --urgency=16

if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi
cd /data/cephfs/punim0784/COMP90024-2019S1-Team7/machine_learning
module load Python/3.5.2-intel-2017.u2-GCC-5.4.0-CUDA9
nvidia-smi
python3 -u coconut_train.py --cuda  \
                            --start_from_begining   \
                            --train_batch_size 60  \
                            --test_batch_size 140   \
                            --num_epochs 400        \
                            --train_data_dir /data/cephfs/punim0784/comp90024_p2_nsfw \
                            --train_optimizer sgd   \
                            --model_type nsfw    \
                            --model_arc resnet101    \
                            --model_checkpoint_path checkpoints/nsfw_resnet101_sgd_v2.pth \
                            >> logs/nsfw_resnet101_sgd_v2.log
