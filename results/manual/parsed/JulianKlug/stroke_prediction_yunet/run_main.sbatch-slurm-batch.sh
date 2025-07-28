#!/bin/bash
#FLUX: --job-name=run_main_yunet
#FLUX: -n=3
#FLUX: -c=17
#FLUX: -t=36000
#FLUX: --urgency=16

export PYTHONPATH='$(pwd)'

module load anaconda
cd /home/gridsan/gleclerc/julian/yunet
export PYTHONPATH=$(pwd)
source /home/gridsan/gleclerc/.bashrc
conda activate yunet
ulimit -S -n 131072
ulimit -S -u 1546461
srun /home/gridsan/gleclerc/.conda/envs/yunet/bin/python /home/gridsan/gleclerc/julian/yunet/data_prepro/convert_gsd_to_hdf5.py /home/gridsan/gleclerc/julian/data/padded_flipped_rescaled_with_ncct_dataset_with_core_with_penumbra.npz -o /home/gridsan/gleclerc/julian/data/yunet_datasets/padded_flipped_rescaled_with_ncct_with_core_with_penumbra_hdf5_dataset/
srun /home/gridsan/gleclerc/.conda/envs/yunet/bin/python /home/gridsan/gleclerc/julian/yunet/data_prepro/convert_gsd_to_nifti.py /home/gridsan/gleclerc/julian/data/padded_flipped_rescaled_with_ncct_dataset_with_core_with_penumbra.npz -o /home/gridsan/gleclerc/julian/data/yunet_datasets/padded_flipped_rescaled_with_ncct_with_core_with_penumbra_nifti_dataset/
srun /home/gridsan/gleclerc/.conda/envs/yunet/bin/python /home/gridsan/gleclerc/julian/yunet/main.py
