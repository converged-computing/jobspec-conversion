#!/bin/bash
# flux: -N 1
# flux: -n 4
# flux: --cpus-per-task=2
# flux: --gpus-per-task=1
# flux: -t 72:00:00
# flux: --queue=gpgpu
# Note: Slurm QoS '#SBATCH -q gpgpumse' has no direct Flux equivalent in generic options.
# This might be handled by queue properties or site-specific Flux configurations.

module purge
module load fosscuda/2019b
module load cuda/10.1.243
module load gcccore/8.3.0
module load gcc/8.3.0 openmpi/3.1.4
module load python/3.7.4
module load opencv
module load pillow
module load torch/20200428
module load scipy-bundle
module load pyyaml
module load numpy/1.17.3-python-3.7.4
module load torchvision
module load matplotlib/3.1.1-python-3.7.4
module load scikit-learn
module load torchvision/0.5.0-python-3.7.4
module load tqdm
module unload pytorch/1.4.0-python-3.7.4
module load pytorch-geometric/1.6.1-python-3.7.4-pytorch-1.6.0
module load tensorflow/2.3.1-python-3.7.4

# The `flux run` command is typically used if Flux needs to launch the parallel tasks.
# However, `torch.distributed.launch` handles process launching on the node.
# Flux will set up the environment for the 4 tasks, each with 2 CPUs and 1 GPU.
# The python command will then run within this environment.
# The --nproc_per_node=4 in torch.distributed.launch aligns with the -n 4 tasks requested from Flux.

time python3 -m torch.distributed.launch --nproc_per_node 4 train.py --batch-size 32 --epochs 100 --data custom_train/dataset_df.yaml --weights weights/yolov5l.pt --nosave