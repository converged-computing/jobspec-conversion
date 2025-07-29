#!/bin/bash
#SBATCH --job-name=metalearning_CIFAR_FS_MetaOptNet_RR
#SBATCH --account=cs704
#SBATCH --output=/common/home/projectgrps/CS704/CS704G1/MetaOptNet/sbatch_logs/CIFAR_FS_MetaOptNet_RR/%u.%j.out
#SBATCH --mail-user=allynezhang.2021@scis.smu.edu.sg,kevano.2020@business.smu.edu.sg
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=16GB
#SBATCH --time=1-00:00:00
#SBATCH --qos=cs704qos

module purge
module load Anaconda3/2022.05
eval "$(conda shell.bash hook)"
conda activate metalearning
srun whichgpu
srun python train.py --save-path "./experiments/CIFAR_FS_MetaOptNet_RR" --train-shot 5 --head Ridge --network ResNet --dataset CIFAR_FS
