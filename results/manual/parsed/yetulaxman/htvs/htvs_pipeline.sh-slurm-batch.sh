#!/bin/bash
#SBATCH --account=project_2001659
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=1G
#SBATCH --time=00:10:10
#SBATCH --partition=small

module load maestro parallel  # load module
find $PWD/data_SMILES  -name '*.smi' | \
parallel -j 10 bash ${SLURM_SUBMIT_DIR}/wrapper_ligprep_pipeline.sh {}
