#!/bin/bash
#FLUX: --job-name=pathml_root_pipeline-dask
#FLUX: -c=12
#FLUX: -t=43200
#FLUX: --urgency=16

export SINGULARITY_BIND='/nesi/nobackup/uoa03709/input:/var/inputdata/work-dir,\'

module unload XALT
module load Singularity
mkdir /nesi/nobackup/uoa03709/output/${SLURM_JOB_ID:-0}
export SINGULARITY_BIND="/nesi/nobackup/uoa03709/input:/var/inputdata/work-dir,\
/nesi/nobackup/uoa03709/output/${SLURM_JOB_ID:-0}:/var/outputdata"
srun singularity exec /nesi/project/uoa03709/containers/sif/smp-cv_0.1.6.sif env PYTHONUNBUFFERED=1 python /var/inputdata/root_pipeline_dask.py
