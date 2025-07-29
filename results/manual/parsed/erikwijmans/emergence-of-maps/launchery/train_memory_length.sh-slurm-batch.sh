#!/bin/bash
#FLUX: --job-name=navigation-analysis-habitat
#FLUX: -N=2
#FLUX: -c=10
#FLUX: --gpus-per-task=1
#FLUX: --queue=learnfair,scavenge
#FLUX: -t=259200
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/usr/lib/x86_64-linux-gnu/nvidia-opengl:${LD_LIBRARY_PATH}'
export GLOG_minloglevel='3'
export MAGNUM_LOG='quiet'
export MASTER_ADDR='$(srun --ntasks=1 hostname 2>&1 | tail -n1)'

echo #SBATCH --constraint=volta32gb
echo ${PYTHONPATH}
echo "Using setup for Erik"
. /private/home/erikwijmans/miniconda3/etc/profile.d/conda.sh
conda deactivate
conda activate nav-analysis-base
eval $(slurm-array-split split mem_len="[1, 2, 4, 8, 16, 32, 64, 128, 256]")
BASE_EXP_DIR="/checkpoint/erikwijmans/exp-dir"
CURRENT_DATETIME="`date +%Y_%m_%d_%H_%M_%S`";
EXP_DIR="${BASE_EXP_DIR}/exp_habitat_api_navigation_analysis_datetime_${CURRENT_DATETIME}"
mkdir -p ${EXP_DIR}
ENV_NAME="memory-length/mp3d-gibson-all-pointnav-mem_${mem_len}-run_${repeat_number}-blind"
CHECKPOINT="data/checkpoints/${ENV_NAME}"
module purge
module load cuda/10.1
module load cudnn/v7.6.5.32-cuda.10.1
module load NCCL/2.5.6-1-cuda.10.1
module load openmpi/4.0.1/gcc.7.4.0-git_patch#6654
export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/nvidia-opengl:${LD_LIBRARY_PATH}
export GLOG_minloglevel=3
export MAGNUM_LOG=quiet
export MASTER_ADDR=$(srun --ntasks=1 hostname 2>&1 | tail -n1)
printenv | grep SLURM
set -x
srun --mpi=pmix_v3 --kill-on-bad-exit=1 \
    python -u -m nav_analysis.train_ppo_distrib \
    --extra-confs \
    nav_analysis/configs/experiments/pointnav-blind.yaml \
    nav_analysis/configs/experiments/loopnav/loopnav_sparse_pg_blind.yaml \
    --opts \
    task.max_episode_timesteps=1000 \
    task.nav_task=pointnav \
    model.max_memory_length=${mem_len} \
    ppo.num_steps=128 \
    ppo.num_processes=8 \
    "logging.log_file=${EXP_DIR}/log.txt" \
    "logging.checkpoint_folder=${CHECKPOINT}" \
    "logging.tensorboard_dir=runs/${ENV_NAME}"
