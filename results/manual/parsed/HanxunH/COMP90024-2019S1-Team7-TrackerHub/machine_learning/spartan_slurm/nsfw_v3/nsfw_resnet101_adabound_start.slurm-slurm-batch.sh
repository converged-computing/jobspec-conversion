#!/bin/bash
#SBATCH --job-name=nsfw
#SBATCH --account=punim0784
#SBATCH --mail-user=hanxunh@student.unimelb.edu.au
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:p100:4
#SBATCH --mem=32G
#SBATCH --time=2-00:00:00

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
                            --train_data_dir /data/cephfs/punim0784/comp90024_p2_nsfw_v3 \
                            --train_optimizer adabound   \
                            --model_type nsfw    \
                            --model_arc resnet101    \
                            --model_checkpoint_path checkpoints/nsfw_resnet101_adabound_v3.pth \
                            >> logs/nsfw_resnet101_adabound_v3.log
