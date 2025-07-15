#!/bin/bash
#FLUX: --job-name=dask-jetstream
#FLUX: -c=10
#FLUX: --queue=bigmem2
#FLUX: -t=600
#FLUX: --priority=16

PATH_TO_PROJECT='/project2/moyer/jetstream'
PATH_TO_REPO='/home/ivanhigueram/reanalysis_getter'
module load python
conda activate reanalysis_env
python ${PATH_TO_REPO}/infrastructure/runner.py \
       --product_path ${PATH_TO_PROJECT}/era-5-data/subset_data/ds_1979_2021_lat_20_1D_renamed.nc \
       --save_path ${PATH_TO_PROJECT}/era5_processed_data \
       --start_year 1990 \
       --end_year 2000 \
       --time_step 1
