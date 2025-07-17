#!/bin/bash
#FLUX: --job-name=EM-EARTH-MERG
#FLUX: -n=12
#FLUX: -t=86400
#FLUX: --urgency=16

module load StdEnv/2020 gcc/9.3.0 openmpi/4.0.3
module load gdal/3.5.1 libspatialindex/1.8.5
module load python/3.8.10 scipy-stack/2022a mpi4py/3.0.3
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --no-index --upgrade pip
pip install --no-index requests
pip install --no-index base64
pip install --no-index hashlib
pip install --no-index glob
pip install --no-index xarray
pip install --no-index matplotlib
pip install --no-index jupyter
pip install --no-index re
pip install --no-index netcdf4
pip install --no-index h5netcdf
pip install --no-index gdown
pip install --no-index dask
python ../code/merging_EM_EARTH.py
