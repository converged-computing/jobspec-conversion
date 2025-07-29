#!/bin/bash
#SBATCH --job-name=ShalCNN
#SBATCH --account=general-gpu
#SBATCH --output=ShallCNN-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:GeForce GTX 1080 Ti:1
#SBATCH --mem=10G
#SBATCH --time=2-00:00:00
#SBATCH --qos=normal

export GPUARRAY_FORCE_CUDA_DRIVER_LOAD=''
export HDF5_USE_FILE_LOCKING='FALSE'

module load cuda/cuda-9.0.176
module load cudnn/cudnn-7.1.4-cuda-9.0.176
export GPUARRAY_FORCE_CUDA_DRIVER_LOAD=""
export HDF5_USE_FILE_LOCKING=FALSE
source /storage/htc/bdm/zhiye/DNCON4/env/dncon4_virenv/bin/activate
python train_v3_all_data.py /storage/htc/bdm/farhan/DNCON2_features_homodimers/feat /storage/htc/bdm/farhan/DNCON2_features_homodimers/Y-Labels ../training_lists/same/
