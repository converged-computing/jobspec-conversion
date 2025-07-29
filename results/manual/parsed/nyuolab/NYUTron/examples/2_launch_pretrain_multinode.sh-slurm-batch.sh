#!/bin/bash
#SBATCH --job-name=pretraining
#SBATCH --output=outs/multinode_%j.out
#SBATCH --mail-user=lyj2002@nyu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=3
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --gres=gpu:a100:8
#SBATCH --mem=800G
#SBATCH --time=30-00:00:00
#SBATCH --qos=qos_free
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --nodelist=a100-8001,a100-8002,a100-8003

export HOME='/gpfs/home/jiangy09/'

echo "hostname:"
hostname
source /gpfs/data/oermannlab/users/lavender/.bashrc
export HOME=/gpfs/home/jiangy09/
echo "home dir is"
echo $HOME
nvidia-smi
module load cuda/11.4 gcc/10.2.0 nccl
conda activate /gpfs/data/oermannlab/users/lavender/.conda/envs/ds_hf #ds_hf
which deepspeed
run_str='deepspeed --hostfile configs/hostfile --num_gpus=8 --num_nodes=3 pretrain_multinode_hydra.py --deepspeed configs/pretrain_configs/deepspeed_config_multinode.json'
echo "$run_str"
$run_str
