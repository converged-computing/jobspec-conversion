#!/bin/bash
#SBATCH --job-name=___
#SBATCH --account=research
#SBATCH --output=output_log_files/Inv_Conv_logQ%j.out
#SBATCH --mail-user=sandeep.nagar@research.iiit.ac.in
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=30
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:3
#SBATCH --mem-per-cpu=3000
#SBATCH --time=4-00:00:00
#SBATCH --qos=medium

module load cudnn/7-cuda-10.0
mpiexec -n 3 python3 train_1.py --num_epochs 300 --num_channels 256 --num_steps 32 --warm_up 500000 --batch_size 8
