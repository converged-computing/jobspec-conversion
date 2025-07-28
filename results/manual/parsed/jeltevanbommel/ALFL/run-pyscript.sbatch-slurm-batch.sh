#!/bin/bash
#FLUX: --job-name=jupyter-notebook
#FLUX: -t=345600
#FLUX: --urgency=16

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
