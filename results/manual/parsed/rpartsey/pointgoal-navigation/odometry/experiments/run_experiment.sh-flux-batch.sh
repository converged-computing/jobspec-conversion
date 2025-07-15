#!/bin/bash
#FLUX: --job-name=vo_3m_nod_fx
#FLUX: -N=8
#FLUX: -c=10
#FLUX: --queue=learnlab
#FLUX: -t=259200
#FLUX: --urgency=16

export MASTER_ADDR='$(srun --ntasks=1 hostname 2>&1 | tail -n1)'
export GLOG_minloglevel='2'
export MAGNUM_LOG='quiet'
export CUDA_HOME='/public/apps/cuda/10.1'
export CUDA_NVCC_EXECUTABLE='/public/apps/cuda/10.1/bin/nvcc'
export CUDNN_INCLUDE_PATH='/public/apps/cuda/10.1/include/'
export CUDNN_LIBRARY_PATH='/public/apps/cuda/10.1/lib64/'
export LIBRARY_PATH='/public/apps/cuda/10.1/lib64'
export CMAKE_PREFIX_PATH='${CONDA_PREFIX:-"$(dirname $(which conda))/../"}'
export USE_CUDA='1 USE_CUDNN=1 USE_MKLDNN=1'

export MASTER_ADDR=$(srun --ntasks=1 hostname 2>&1 | tail -n1)
EXP_NAME="vo_3m_nod"
source ~/.bash_profile
source ~/.profile
source /etc/bash.bashrc
source /etc/profile
export GLOG_minloglevel=2
export MAGNUM_LOG=quiet
module unload cuda
module load cuda/10.1
module unload cudnn
module load cudnn/v7.6.5.32-cuda.10.1
module load anaconda3/5.0.1
module load gcc/7.1.0
module load cmake/3.10.1/gcc.5.4.0
source activate challenge_2021
export CUDA_HOME="/public/apps/cuda/10.1"
export CUDA_NVCC_EXECUTABLE="/public/apps/cuda/10.1/bin/nvcc"
export CUDNN_INCLUDE_PATH="/public/apps/cuda/10.1/include/"
export CUDNN_LIBRARY_PATH="/public/apps/cuda/10.1/lib64/"
export LIBRARY_PATH="/public/apps/cuda/10.1/lib64"
export CMAKE_PREFIX_PATH=${CONDA_PREFIX:-"$(dirname $(which conda))/../"}
export USE_CUDA=1 USE_CUDNN=1 USE_MKLDNN=1
CURRENT_DATETIME="`date +%Y_%m_%d_%H_%M_%S`";
echo $CUDA_VISIBLE_DEVICES
unset LD_PRELOAD
CMD_OPTS=$(cat "$CMD_OPTS_FILE")
set -x
srun python -u -m train_odometry --config-file config_files/odometry/resnet18_bs16_ddepth5_maxd0.5_randomsampling_dropout0.2_poselossv2_1._1._180x320_embedd_act_vflip_hc2021_vo3_bigdata_3m_fair.yaml --invert-rotations-train --invert-collisions
