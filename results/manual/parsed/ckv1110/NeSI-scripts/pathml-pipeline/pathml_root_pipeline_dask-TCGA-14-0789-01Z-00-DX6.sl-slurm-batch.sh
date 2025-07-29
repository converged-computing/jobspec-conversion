#!/bin/bash
#SBATCH --job-name=pathml_root_pipeline-TCGA-14-0789-01Z-00-DX6
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=8G
#SBATCH --time=12:00:00
#SBATCH --partition=bigmem

export SINGULARITY_BIND='/nesi/nobackup/uoa03709/input:/var/inputdata,\'

module load Singularity
mkdir /nesi/nobackup/uoa03709/output/${SLURM_JOB_ID:-0}
export SINGULARITY_BIND="/nesi/nobackup/uoa03709/input:/var/inputdata,\
/nesi/nobackup/uoa03709/output/${SLURM_JOB_ID:-0}:/var/outputdata"
srun singularity exec smp-cv_0.1.3.sif python /var/inputdata/root_pipeline_dask.py
