#!/bin/bash
#SBATCH --output=/home/gebreawe/Model_logs/Segmentation/ST_Cylinder_3D/logs/wod_concordance_T11_33_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=60G
#SBATCH --time=1-00:00:00
#SBATCH --partition=amdcpu
#SBATCH --constraint=ntasks-per-node=3

export NCCL_LL_THRESHOLD='1'

ml spconv/2.1.21-foss-2021a-CUDA-11.3.1
ml PyTorch-Geometric/2.0.2-foss-2021a-CUDA-11.3.1-PyTorch-1.10.0
cd ../..
name=cylinder_asym_networks
export NCCL_LL_THRESHOLD=1
echo "epoch 0"
CUDA_VISIBLE_DEVICES=0,1,2 NCCL_P2P_DISABLE=1 python -u -m torch.distributed.launch --nproc_per_node=3 --master_port=$RANDOM test_cylinder_asym_wod.py --config_path 'config/wod/wod_train_infer_f1_1.yaml' --mode 'test' --save 'True' \
2>&1 | tee logs_dir/${name}_logs_wod_f1_1_b3_infer.txt
