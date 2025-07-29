#!/bin/bash
#SBATCH --job-name=jupyter-notebook
#SBATCH --output=jupyter-notebook-%J.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=16G
#SBATCH --time=4-00:00:00
#SBATCH --constraint=[titan-x|p100|gtx-1080ti]

export XDG_RUNTIME_DIR=''

module load nvidia/cuda-10.2
echo "Gpu devices: "$CUDA_VISIBLE_DEVICES
export XDG_RUNTIME_DIR=""
NODE=$(hostname)
PORT=$(((RANDOM % 10)+8800))
for currround in {111..200}
do 
  for client in {0..8}
  do
   python3 research.py --action train --epochs 20 --reuse_weights --client "$client" --classes 2 --round "$currround" --name "$1"
  done
  python3 research.py --action fedavg --classes 2 --round "$currround" --name "$1"
done
