#!/bin/bash
#SBATCH --output=%A_%a.out
#SBATCH --error=%A_%a.err
#SBATCH --mail-user=simmo536@umn.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4gb
#SBATCH --time=08:00:00
#SBATCH --partition=msismall

cd ~/2023-DynPTOModelDesignStudies
module load matlab
matlab -nodisplay -r \
"iVar = ${SLURM_ARRAY_TASK_ID}; \
display(['iVar = ',num2str(iVar)]); \
SS = ${SS}; \
display(['SS = ',num2str(SS)]); \
study_parPTO_accumNoDpDt_woPL_wPassiveRV"
