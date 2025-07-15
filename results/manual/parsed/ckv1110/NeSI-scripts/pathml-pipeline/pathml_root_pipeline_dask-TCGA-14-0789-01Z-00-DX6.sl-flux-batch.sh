#!/bin/bash
#FLUX: --job-name=pathml_root_pipeline-TCGA-14-0789-01Z-00-DX6
#FLUX: -c=12
#FLUX: --queue=bigmem
#FLUX: -t=43200
#FLUX: --priority=16

export SINGULARITY_BIND='/nesi/nobackup/uoa03709/input:/var/inputdata,\'

module load Singularity
mkdir /nesi/nobackup/uoa03709/output/${SLURM_JOB_ID:-0}
export SINGULARITY_BIND="/nesi/nobackup/uoa03709/input:/var/inputdata,\
/nesi/nobackup/uoa03709/output/${SLURM_JOB_ID:-0}:/var/outputdata"
srun singularity exec smp-cv_0.1.3.sif python /var/inputdata/root_pipeline_dask.py
