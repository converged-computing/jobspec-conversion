#!/bin/bash
#SBATCH --job-name=nextflow_amr
#SBATCH --account=naiss2023-5-97
#SBATCH --output=/proj/fume/nobackup/private/jay/Freshwater_AMR/scripts/amr_finding/logs/nf_amr_pipeline_230512.log
#SBATCH --error=/proj/fume/nobackup/private/jay/Freshwater_AMR/scripts/amr_finding/logs/nf_amr_pipeline.err
#SBATCH --mail-user=jay.hakansson.4449@student.uu.se
#SBATCH --mail-type=FAIL,END
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --time=5-00:00:00
#SBATCH --partition=core

export CONDA_ENVS_PATH='/proj/fume/nobackup/private/jay/Freshwater_AMR/conda_envs'

cd /proj/fume/nobackup/private/jay/Freshwater_AMR/scripts/amr_finding
module load conda
source conda_init.sh
export CONDA_ENVS_PATH=/proj/fume/nobackup/private/jay/Freshwater_AMR/conda_envs
bash
mamba activate nextflow-22.10.6
nextflow run amr_finding_pipeline.nf -c amr_finding_uppmax.config -resume
