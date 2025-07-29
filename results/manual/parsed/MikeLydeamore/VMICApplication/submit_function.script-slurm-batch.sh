#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=18G
#SBATCH --time=06:00:00

module load gcc/10.2.0
./covid_multistrain/covid_ms --ttiq-type=${TTIQ_TYPE} -a${AGE_DIST_FILE} -s${STRAIN_PARAMS} -v${VACCINE_PARAMS} -e${EXPOSURE_PARAMS} -i${IMMUNITY_PARAMS} -c${CONTACT_FILE} -r${SCENARIO_FILE} -o${OUTPUT_DIR} -n$SLURM_ARRAY_TASK_ID -t${T_END}
