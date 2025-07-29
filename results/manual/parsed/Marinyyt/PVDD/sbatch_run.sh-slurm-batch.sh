#!/bin/bash
#SBATCH --job-name=PVDD_pvdd0815_02_charbo_bs1_pvdd_model
#SBATCH --output=/mnt/lustrenew/share_data/yuyitong/logs/PVDD_pvdd0815_02_charbo_bs1_pvdd_model/%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --partition=Pixel

srun --mpi=pmi2 --kill-on-bad-exit=1 python train.py --config ./configs/PVDD_pvdd0815_02_charbo_bs1_pvdd_model.yaml --num_gpus 1 --save_path /mnt/lustrenew/share_data/yuyitong/logs/PVDD_pvdd0815_02_charbo_bs1_pvdd_model/ 
echo "Submit the PVDD_pvdd0815_02_charbo_bs1_pvdd_model job by run \'sbatch\'" 
