#!/bin/bash
#FLUX: --job-name=ISIMIP3a-pos-GSWP3
#FLUX: -n=28
#FLUX: --queue=broadwell
#FLUX: -t=432000
#FLUX: --priority=16

echo EMPIEZA TODO `date`
ml SciPy-bundle/2021.10-foss-2021b
ml netcdf4-python/1.5.8-foss-2021b
ml xarray/2022.6.0-foss-2021b
ml dask/2022.1.0-foss-2021b
ml NCO/5.0.3-foss-2021b
ml CDO/2.0.5-gompi-2021b
echo create_ISIMIP_NetCDF.py -p ISIMIP3a -t obsclim -m 20CRv3-W5E5 -c historical -fi 1901 -f 2019 
./create_ISIMIP_NetCDF.py -p ISIMIP3a -t obsclim -m 20CRv3-W5E5 -c historical -fi 1901 -f 2019 
echo TERMINA TODO `date`
