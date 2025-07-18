#!/bin/bash
#FLUX: --job-name=BowAtBanff_drainage_database
#FLUX: -t=3600
#FLUX: --urgency=16

module load StdEnv/2020 gcc/9.3.0 openmpi/4.0.3
module load gdal/3.5.1 libspatialindex/1.8.5
module load python/3.8.10 scipy-stack/2022a mpi4py/3.0.3
rm -rf $HOME/MESH-env
virtualenv --no-download $HOME/MESH-env 
source $HOME/MESH-env/bin/activate 
pip install --no-index --upgrade pip
pip install --no-index netcdf4
pip install --no-index h5netcdf
pip install --no-index xarray
pip install --no-index dask
pip install --no-index geopandas
python create_MESH_drainage_database.py 
echo "finished"
