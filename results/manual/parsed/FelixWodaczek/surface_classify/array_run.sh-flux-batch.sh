#!/bin/bash
#FLUX: --job-name=arraySurfaceClass
#FLUX: -t=7200
#FLUX: --priority=16

unset SLURM_EXPORT_ENV
module load python/3.9.7
source SURFCLASS_VENV01/bin/activate
python3 slurm_classify.py -m 'soap_sort' # soap_sort, lmbtr_sort, soap_gendescr, lmbtr_gendescr
deactivate
