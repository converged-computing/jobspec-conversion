#!/bin/bash
#FLUX: --job-name=slurm-pytorch-ddp-boilerplate
#FLUX: -N=2
#FLUX: -c=6
#FLUX: --queue=shared-gpu
#FLUX: -t=900
#FLUX: --urgency=16

export VENV_PATH='$HOME/venv/slurm-pytorch-ddp-boilerplate'
export MASTER_PORT='$master_port'
export MASTER_ADDR='$master_addr'
export nproc_per_node='$SLURM_NTASKS_PER_NODE'

echo "+++++++++++SETUP++++++++++++"
VERSION_PYTHON='3.10.4'
module load GCCcore/11.3.0
module load Python/${VERSION_PYTHON}
VERSION_CUDA='11.7'
module load CUDA/${VERSION_CUDA}
module load NCCL/2.12.12-CUDA-11.7.0
echo "=====MODULES INSTALLED====="
echo "++++++++++++++++++++++"
echo "=====PYTHON SETUP====="
export VENV_PATH="$HOME/venv/slurm-pytorch-ddp-boilerplate"
../setup_environment.sh gpu
echo "=====END PYTHON SETUP====="
echo "++++++++++++++++++++++++++"
echo "=====DDP SETUP====="
master_port=$(expr 10000 + $(echo -n $SLURM_JOBID | tail -c 4))
export MASTER_PORT=$master_port
master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_ADDR=$master_addr
world_size=$(($SLURM_NTASKS_PER_NODE * $SLURM_NNODES))
export nproc_per_node=$SLURM_NTASKS_PER_NODE
echo "MASTER_ADDR="$master_addr
echo "MASTER_PORT="$master_port
echo "WORLD_SIZE="$world_size
echo "NNODES="$SLURM_NNODES
echo "NODE LIST="$SLURM_JOB_NODELIST
echo "NPROC_PER_NODE="$nproc_per_node
echo "CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES}"
echo "PYTHON VERSION=$(python --version)"
echo "=====END DDP SETUP====="
echo "+++++++++++END SETUP++++++++++++"
echo " * * * Starting slurm run. * * *"
source $VENV_PATH/bin/activate
srun python3 ../main.py
echo " * * * Slurm run finished. * * *"
deactivate
