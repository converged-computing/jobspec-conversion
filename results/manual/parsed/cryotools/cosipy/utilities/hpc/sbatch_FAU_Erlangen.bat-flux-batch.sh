#!/bin/bash
#FLUX: --job-name=Test_run
#FLUX: -t=600
#FLUX: --priority=16

unset SLURM_EXPORT_ENV
module load intel64 netcdf 
/home/woody/gwgk/gwgk01/envs/karoshi/bin/python COSIPY.py
rm -r worker-* *.lock
