#!/bin/bash
#SBATCH --output=%A_%a.out
#SBATCH --error=%A_%a.err
#SBATCH --mail-user=simmo536@umn.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=11
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=125000M
#SBATCH --time=1-00:00:00
#SBATCH --partition=msismall

cd ~/2023-DynPTOModelDesignStudies
module load matlab
matlab -nodisplay -r \
"SS = ${SS}; \
display(['SS = ',num2str(SS)]); \
addpath('Utilities'); \
nWorkers = ${SLURM_NTASKS}-1; \
parSafeStartSlurm; \
study_parPTO_accum_woPL_woRV; \
rmdir(storage_folder)"
