#!/bin/bash
#FLUX: --job-name=pathml_dask_tile-only
#FLUX: -c=12
#FLUX: -t=7200
#FLUX: --urgency=16

export SINGULARITY_BIND='/nesi/project/uoa03709/work-dir:/var/inputdata'
export NAME='TCGA-02-0003-01Z-00-DX1.6171b175-0972-4e84-9997-2f1ce75f4407Region01'

module unload XALT
module load Singularity
export SINGULARITY_BIND="/nesi/project/uoa03709/work-dir:/var/inputdata"
export NAME=TCGA-02-0003-01Z-00-DX1.6171b175-0972-4e84-9997-2f1ce75f4407Region01
srun singularity exec /nesi/project/uoa03709/containers/sif/smp-cv_0.1.6.sif env PYTHONUNBUFFERED=1 python /var/inputdata/py-data/root_pipeline_dask.py
