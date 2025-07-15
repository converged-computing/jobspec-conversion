#!/bin/bash
#FLUX: --job-name=NACO-CQTau
#FLUX: --queue=m3g
#FLUX: -t=3600
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export OPENBLAS_NUM_THREADS='$OMP_NUM_THREADS'
export MKL_NUM_THREADS='$OMP_NUM_THREADS'

module load cuda
nvidia-smi
deviceQuery
env # print environmental variables if you wish, good for debugging
export OMP_NUM_THREADS=1
export OPENBLAS_NUM_THREADS=$OMP_NUM_THREADS
export MKL_NUM_THREADS=$OMP_NUM_THREADS
source /home/ihammond/miniconda3/etc/profile.d/conda.sh # initialise conda shell
conda activate VIPenv # activate personal VIP conda environment
ulimit -s unlimited # recommended by M3 support team to prevent stack size memory error
python run_script.py # runs the script
