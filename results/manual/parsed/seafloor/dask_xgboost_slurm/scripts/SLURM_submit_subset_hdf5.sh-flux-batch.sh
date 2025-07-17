#!/bin/bash
#FLUX: --job-name=gassy-citrus-8634
#FLUX: --urgency=16

scriptdir=""  # location for python scripts e.g. $HOME/dask_xgboost_slurm/scripts
data_dir=""
snps_dir=""
ids_dir=""
module load python_module  # replace with python/conda module
conda activate env_name  # replace with env name
python3 ${scriptdir}/subset_hdf5.py \
    --in_path "${data_dir}/infile.hdf5" \
    --out_path "${data_dir}/outfile.hdf5" \
    --ids "${ids_dir}/row_ids.txt" \
    --xkey 'x_adjusted' \
    --ykey 'y_adjusted'
