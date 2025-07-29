#!/bin/bash
#SBATCH --job-name=restormer-universal-gauss-25
#SBATCH --account=delia-mp
#SBATCH --output=/p/scratch/delia-mp/lin4/experiment_result/restormer/0803-universal-gauss-25/output-%j.out
#SBATCH --error=/p/scratch/delia-mp/lin4/experiment_result/restormer/0803-universal-gauss-25/error-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1

export SRUN_CPUS_PER_TASK='$SLURM_CPUS_PER_TASK'
export MASTER_ADDR='$(nslookup "$MASTER_ADDR" | grep -oP '(?<=Address: ).*')'
export NCCL_DEBUG='INFO'
export CUDA_VISIBLE_DEVICES='0,1,2,3'
export NUM_GPU_PER_NODE='4'

echo 'Experiment start !'
export SRUN_CPUS_PER_TASK="$SLURM_CPUS_PER_TASK"
MASTER_ADDR="$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)"
MASTER_ADDR="${MASTER_ADDR}i"
export MASTER_ADDR="$(nslookup "$MASTER_ADDR" | grep -oP '(?<=Address: ).*')"
export NCCL_DEBUG=INFO
export CUDA_VISIBLE_DEVICES=0,1,2,3
export NUM_GPU_PER_NODE=4
CONFIG=Denoising/Options/GaussianGrayDenoising_Restormer_universal_gauss_25.yml
source /p/project/delia-mp/lin4/Julich_experiment/Restormer/restormer_env/activate.sh
srun python3 -m torch.distributed.launch \
    --nproc_per_node=4 \
    basicsr/train.py \
    -opt $CONFIG \
    --launcher pytorch;
echo 'Experiment End !'
