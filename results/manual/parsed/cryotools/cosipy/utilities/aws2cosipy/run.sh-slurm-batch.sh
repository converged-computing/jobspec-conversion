#!/bin/bash
#FLUX: --job-name=REAL
#FLUX: -t=10800
#FLUX: --urgency=16

export KMP_STACKSIZE='64000000'
export OMP_NUM_THREADS='1'

module load intel64 netcdf 
export KMP_STACKSIZE=64000000
export OMP_NUM_THREADS=1
ulimit -s unlimited
python3 aws2cosipy.py -c ../../data/input/Zhadang/Zhadang_ERA5_200901_short.csv -o ../../data/input/Zhadang/Zhadang_ERA5_2009.nc -s ../../data/static/Zhadang_static.nc -b 20090101 -e 20091231 
