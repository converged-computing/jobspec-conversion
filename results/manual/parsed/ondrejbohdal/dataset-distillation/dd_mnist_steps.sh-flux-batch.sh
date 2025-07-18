#!/bin/bash
#FLUX: --job-name=dd
#FLUX: --queue=General_Usage
#FLUX: -t=255600
#FLUX: --urgency=16

export CUDA_HOME='/opt/cuda-10.0.130/'
export CUDNN_HOME='/opt/cuDNN-7.6.0.64_10.0/'
export STUDENT_ID='$(whoami)'
export LD_LIBRARY_PATH='${CUDNN_HOME}/lib64:${CUDA_HOME}/lib64:$LD_LIBRARY_PATH'
export LIBRARY_PATH='${CUDNN_HOME}/lib64:$LIBRARY_PATH'
export CPATH='${CUDNN_HOME}/include:$CPATH'
export PATH='${CUDA_HOME}/bin:${PATH}'
export PYTHON_PATH='$PATH'

export CUDA_HOME=/opt/cuda-10.0.130/
export CUDNN_HOME=/opt/cuDNN-7.6.0.64_10.0/
export STUDENT_ID=$(whoami)
export LD_LIBRARY_PATH=${CUDNN_HOME}/lib64:${CUDA_HOME}/lib64:$LD_LIBRARY_PATH
export LIBRARY_PATH=${CUDNN_HOME}/lib64:$LIBRARY_PATH
export CPATH=${CUDNN_HOME}/include:$CPATH
export PATH=${CUDA_HOME}/bin:${PATH}
export PYTHON_PATH=$PATH
source /home/${STUDENT_ID}/miniconda3/bin/activate meta_learning_pytorch_env_2
STEPS=(
1
2
5
10
20
50
)
echo "Job running on ${SLURM_JOB_NODELIST}"
dt=$(date '+%d/%m/%Y %H:%M:%S')
echo "Job started: $dt"
echo ${STEPS[SLURM_ARRAY_TASK_ID-1]}
python main.py --mode distill_basic --dataset MNIST --arch LeNet --distill_steps ${STEPS[SLURM_ARRAY_TASK_ID-1]}
dt=$(date '+%d/%m/%Y %H:%M:%S')
echo "Training ended: $dt"
