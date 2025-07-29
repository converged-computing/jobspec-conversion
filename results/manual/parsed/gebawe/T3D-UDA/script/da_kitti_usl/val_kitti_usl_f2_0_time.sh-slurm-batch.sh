#!/bin/bash
#SBATCH --output=/home/gebreawe/Model_logs/Segmentation/T-UDA/logs/val_uda_kitti_usl_f2_0_time_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --gres=gpu:1
#SBATCH --mem=60G
#SBATCH --time=3-00:00:00
#SBATCH --constraint=ntasks-per-node=1

export NCCL_LL_THRESHOLD='0'

ml spconv/2.1.21-foss-2021a-CUDA-11.3.1
ml PyTorch-Geometric/2.0.2-foss-2021a-CUDA-11.3.1-PyTorch-1.10.0
cd ../..
name=t-uda
export NCCL_LL_THRESHOLD=0
echo "epoch 0"
python test.py --config_path 'configs/data_config/da_kitti_usl/uda_val_kitti_usl_f2_0_time.yaml'  --mode 'val' --save 'True' --network 'Student' 2>&1 | tee logs_dir/${name}_uda_val_kitti_usl_f2_0_time.txt
