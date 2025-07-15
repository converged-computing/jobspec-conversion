#!/bin/bash
#FLUX: --job-name=moolicious-platanos-0663
#FLUX: -c=40
#FLUX: --queue=batch
#FLUX: -t=7200
#FLUX: --priority=16

export MALLOC_MMAP_MAX_='40960'

WORK_DIR=$(pwd)
BASE_DIR=$(dirname "${WORK_DIR}")
ml GCCcore/.11.2.0
ml GCC/11.2.0
ml ParaStationMPI/5.5.0-1
ml netcdf4-python/1.5.7-serial
ml SciPy-bundle/2021.10
ml xarray/0.20.1
ml dask/2021.9.1
ml TensorFlow/2.6.0-CUDA-11.5
source ${BASE_DIR}/virtual_envs/venv_hdfml/bin/activate
export MALLOC_MMAP_MAX_=40960
srun --overlap python3 ${BASE_DIR}/jupyter_notebooks_test/demo_tfdataset_ap5.py -lprefetch
