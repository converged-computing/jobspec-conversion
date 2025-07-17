#!/bin/bash
#FLUX: --job-name=food179
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
                            --train_batch_size 200  \
                            --test_batch_size 400   \
                            --num_epochs 400        \
                            --train_data_dir /data/cephfs/punim0784/comp90024_p2_food_179 \
                            --train_optimizer adabound   \
                            --model_type food179    \
                            --model_arc resnet101    \
                            --model_checkpoint_path checkpoints/food179_resnet101_adabound.pth \
                            >> logs/food179_resnet101_adabound.log
