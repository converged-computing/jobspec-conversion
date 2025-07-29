#!/bin/bash
#SBATCH --output=joboutput/%x-%a-output-%j.txt
#SBATCH --error=joboutput/%x-%a-error-%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32gb
#SBATCH --time=03:00:00
#SBATCH --constraint=ntasks-per-node=1,[intel16|intel18|amd20|amd22]
#SBATCH --array=1-3

export RVER='4.2.2-GCC-11.2.0'
export R_LIBS_USER='$HOME/R/$RVER'

if [ -z "$SDM_SPECIES" ]; then 
  echo "the var SDM_SPECIES is not set, exiting" 
  exit 1
fi 
RUN_NUMBER="${SLURM_ARRAY_TASK_ID:-1}"
OUTPUT_PATH="${SDM_OUTPUT_PATH:-$HOME/sdm_model_runs}"
RADII=( 1 3 9 15 21 27 33 )
module purge
module load GCC/11.2.0  OpenMPI/4.1.1 GDAL R Automake UDUNITS
export RVER="4.2.2-GCC-11.2.0"
export R_LIBS_USER=$HOME/R/$RVER
for RADIUS in "${RADII[@]}";do
  Rscript --no-save  --no-init-file --no-restore  \
  L1_1_sdm_model.R $SDM_SPECIES $RADIUS $RUN_NUMBER $OUTPUT_PATH \
  $SLURM_JOB_CPUS_PER_NODE
done  
