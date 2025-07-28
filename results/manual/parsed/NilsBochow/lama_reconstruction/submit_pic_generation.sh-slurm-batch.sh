#!/bin/bash
#FLUX: --job-name=era5_pic_generation
#FLUX: -n=12
#FLUX: -t=600
#FLUX: --urgency=16

export TORCH_HOME='/p/tmp/bochow/LAMA/lama/ && export PYTHONPATH=/p/tmp/bochow/LAMA/lama/'
export HDF5_USE_FILE_LOCKING='FALSE'

module load anaconda/2021.11
source activate /p/tmp/bochow/lama_env/
export TORCH_HOME=/p/tmp/bochow/LAMA/lama/ && export PYTHONPATH=/p/tmp/bochow/LAMA/lama/
module load cuda/10.2
export HDF5_USE_FILE_LOCKING='FALSE'
srun --ntasks=1 --cpus-per-task=4 --time=0:10:00 --qos=priority python bin/gen_mask_dataset.py $(pwd)/configs/data_gen/fixed_1440.yaml /p/tmp/bochow/sic_era5/Niklas_1440/ /p/tmp/bochow/sic_era5/Niklas_1440/fixed_1440.yaml  --ext png &
wait
