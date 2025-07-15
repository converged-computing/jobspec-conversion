#!/bin/bash
#FLUX: --job-name=PVDD_pvdd0815_02_charbo_bs1_pvdd_model
#FLUX: -c=4
#FLUX: --priority=16

srun --mpi=pmi2 --kill-on-bad-exit=1 python train.py --config ./configs/PVDD_pvdd0815_02_charbo_bs1_pvdd_model.yaml --num_gpus 1 --save_path /mnt/lustrenew/share_data/yuyitong/logs/PVDD_pvdd0815_02_charbo_bs1_pvdd_model/ 
echo "Submit the PVDD_pvdd0815_02_charbo_bs1_pvdd_model job by run \'sbatch\'" 
