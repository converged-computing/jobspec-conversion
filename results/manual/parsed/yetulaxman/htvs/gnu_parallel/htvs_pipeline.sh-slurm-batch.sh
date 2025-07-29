#!/bin/bash
#SBATCH --account=project_xxxx
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --cpus-per-task=1
#SBATCH --time=15:10:10
#SBATCH --partition=small

module load maestro parallel
find /scratch/project_xxxx/yetukuri/results_1000k_splits  -name '*.smi' | \
parallel -j 38 bash ${SLURM_SUBMIT_DIR}/wrapper_ligprep_pipeline.sh {} 
