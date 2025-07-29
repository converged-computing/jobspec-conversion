#!/bin/bash
#SBATCH --job-name=T4C
#SBATCH --account=kuex0005
#SBATCH --output=t4c.%j.out
#SBATCH --error=t4c.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=4

export NCCL_SOCKET_IFNAME='^docker0,lo'

export NCCL_SOCKET_IFNAME=^docker0,lo
module purge
module load cuda/11.3 miniconda/3 gcc/9.3
conda activate ai4ex
for i in $(lsof /dev/nvidia0 | grep python | awk '{print $2}' | sort -u); do kill -9 $i; done
srun python Traffic4Cast2021/main1.py --nodes 1 --gpus 4 --precision 16 --batch-size 5 --epochs 100 --mlp_ratio 1 --stages 4 --patch_size 4 --dropout 0.0 --start_filters 192 --sampling-step 1 --decode_depth 1 --use_neck --lr 1e-4 --optimizer lamb --merge_type both --mix_features --city_category TEMPORAL --memory_efficient
