#!/bin/bash
#SBATCH --job-name=nextflow_trim
#SBATCH --account=naiss2023-5-97
#SBATCH --output=/proj/fume/nobackup/private/jay/Freshwater_AMR/scripts/process_sites/logs/nextflow_single_asm20230428.log
#SBATCH --error=/proj/fume/nobackup/private/jay/Freshwater_AMR/scripts/amr_finding/logs/nextflow_singleasm202304086.err
#SBATCH --mail-user=jay.hakansson.4449@student.uu.se
#SBATCH --mail-type=FAIL,END
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --time=10-00:00:00

export CONDA_ENVS_PATH='/proj/fume/nobackup/private/jay/Freshwater_AMR/conda_envs'

cd /proj/fume/nobackup/private/jay/Freshwater_AMR/scripts/process_sites/
module load conda
source conda_init.sh
export CONDA_ENVS_PATH=/proj/fume/nobackup/private/jay/Freshwater_AMR/conda_envs
bash
mamba activate nextflow-22.10.6
nextflow run trim_pipeline.nf -c trim_pipeline.config -resume
