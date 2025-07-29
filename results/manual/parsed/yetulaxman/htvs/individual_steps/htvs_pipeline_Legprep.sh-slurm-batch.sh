#!/bin/bash
#SBATCH --account=project_2004075
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --time=01:10:10
#SBATCH --partition=small

module load maestro parallel
find $PWD/data_SMILES  -name '*.smi' | \
parallel -j 10 bash ${SLURM_SUBMIT_DIR}/wrapper_ligprep_pipeline_Ligprep.sh {} 
