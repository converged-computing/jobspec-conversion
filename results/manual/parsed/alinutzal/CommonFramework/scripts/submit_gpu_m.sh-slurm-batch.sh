#!/bin/bash
#SBATCH --job-name=gnn4itk
#SBATCH --account=pls0144
#SBATCH --output=alazar-%j.out
#SBATCH --mail-user=alazar@ysu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --time=05:00:00
#SBATCH --constraint=ntasks-per-node=2

export NCCL_NET_GDR_LEVEL='PHB'
export NCCL_P2P_LEVEL='NVL'
export TORCH_DISTRIBUTED_DEBUG='DETAIL'

export NCCL_NET_GDR_LEVEL=PHB
export NCCL_P2P_LEVEL=NVL
export TORCH_DISTRIBUTED_DEBUG=DETAIL
echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "
echo "Nodelist:= " $SLURM_JOB_NODELIST
echo "Number of nodes:= " $SLURM_JOB_NUM_NODES
echo "Ntasks per node:= "  $SLURM_NTASKS_PER_NODE
echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "
module load cuda/11.8.0
module load miniconda3/4.10.3-py37
source activate torch
srun --ntasks-per-node=2 --gpu_cmode=exclusive g4i-train /users/PLS0129/ysu0053/CommonFramework/examples/Example_3/gnn_train_2.yaml
