#!/bin/bash
#FLUX: --job-name=gpu
#FLUX: -n=4
#FLUX: --queue=gpu
#FLUX: -t=600
#FLUX: --priority=16

export TORCH_HOME='/p/tmp/bochow/LAMA/lama/ && export PYTHONPATH=/p/tmp/bochow/LAMA/lama/'
export HDF5_USE_FILE_LOCKING='FALSE'

module load anaconda/2021.11
source activate /p/tmp/bochow/lama_env/
export TORCH_HOME=/p/tmp/bochow/LAMA/lama/ && export PYTHONPATH=/p/tmp/bochow/LAMA/lama/
module load cuda/10.2
export HDF5_USE_FILE_LOCKING='FALSE'
srun --ntasks=1 --cpus-per-task=4 --time=0:10:00 --qos=priority python bin/predict.py model.path=$(pwd)/experiments/bochow_2023-02-10_09-23-51_train_lama-fourier-sic_ indir=/p/tmp/bochow/sic_era5/Niklas_1440/fixed_1440.yaml/ outdir=/p/tmp/bochow/sic_era5/Niklas_1440/inpainted/ model.checkpoint=last.ckpt
