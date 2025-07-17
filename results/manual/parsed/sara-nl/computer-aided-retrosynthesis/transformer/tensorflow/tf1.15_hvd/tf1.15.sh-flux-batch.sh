#!/bin/bash
#FLUX: --job-name=1node_2000_epochs
#FLUX: --queue=gpu_titanrtx
#FLUX: -t=432000
#FLUX: --urgency=16

export HOROVOD_CUDA_HOME='$CUDA_HOME'
export HOROVOD_CUDA_INCLUDE='$CUDA_HOME/include'
export HOROVOD_CUDA_LIB='$CUDA_HOME/lib64'
export HOROVOD_NCCL_HOME='$EBROOTNCCL'
export HOROVOD_GPU_ALLREDUCE='NCCL'
export MPICC='mpicc'
export MPICXX='mpicpc'
export HOROVOD_MPICXX_SHOW='mpicxx --showme:link'

module purge
module load 2019
module load Anaconda3/2018.12
module load cuDNN/7.6.3-CUDA-10.0.130
module load OpenMPI/3.1.4-GCC-8.3.0
module load NCCL/2.4.7-CUDA-10.0.130
VIRTENV=transformer_tf1.15
clear
module list
export HOROVOD_CUDA_HOME=$CUDA_HOME
export HOROVOD_CUDA_INCLUDE=$CUDA_HOME/include
export HOROVOD_CUDA_LIB=$CUDA_HOME/lib64
export HOROVOD_NCCL_HOME=$EBROOTNCCL
export HOROVOD_GPU_ALLREDUCE=NCCL
export MPICC=mpicc
export MPICXX=mpicpc
export HOROVOD_MPICXX_SHOW="mpicxx --showme:link"
echo "Starting training"
source /sw/arch/Debian10/EB_production/2019/software/Anaconda3/2018.12/etc/profile.d/conda.sh
source activate $VIRTENV
python3 --version
mpirun -map-by ppr:4:node -np 4 -x LD_LIBRARY_PATH -x PATH \
       python3 transformer.py --train data/retrosynthesis-train-valid.smi --horovod --run_name 1node_2000_epochs \
       --epochs_to_save 1200 1400 1600 1800 1999 --epochs 2000 --epochs_per_cycle 200 --seed 3 --warmup_on_cyle --eps 1e-5
