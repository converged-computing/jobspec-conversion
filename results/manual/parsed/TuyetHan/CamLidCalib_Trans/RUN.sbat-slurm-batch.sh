#!/bin/bash
#SBATCH --job-name=Trial
#SBATCH --mail-user=f1tvef@inf.elte.hu
#SBATCH --mail-type=ALL
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem=250GB
#SBATCH --time=03:00:00
#SBATCH --constraint=ntasks-per-node=1

export TORCH_NCCL_ASYNC_ERROR_HANDLING='1'
export CUDA_LAUNCH_BLOCKING='1'
export GPUS_PER_NODE='4'
export LAUNCHER='accelerate launch \'
export SCRIPT='/project/p_trancal/CamLidCalib_Trans/train.py'
export CMD='$LAUNCHER $SCRIPT'

module purge
module load cuda/11.8
module load gcc/11.2.0
source trsclbjob/bin/activate
export TORCH_NCCL_ASYNC_ERROR_HANDLING=1
export CUDA_LAUNCH_BLOCKING=1
head_node_ip=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
export GPUS_PER_NODE=4
WORLD_SIZE=$(($GPUS_PER_NODE*$SLURM_NNODES))
export LAUNCHER="accelerate launch \
    --config_file CamLidCalib_Trans/config/disGPU_accelerate.yaml  \
    --num_processes $WORLD_SIZE \
    --num_machines $SLURM_NNODES \
    --machine_rank $SLURM_PROCID\
    --main_process_ip $head_node_ip \
    --main_process_port $UID  \
    --rdzv_backend c10d  \
    "
export SCRIPT="/project/p_trancal/CamLidCalib_Trans/train.py"
export CMD="$LAUNCHER $SCRIPT"
NCCL_P2P_DISABLE=1 NCCL_IB_DISABLE=1 srun $CMD
