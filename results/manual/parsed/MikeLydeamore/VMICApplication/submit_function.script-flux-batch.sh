#!/bin/bash
#FLUX: --job-name=salted-chip-1383
#FLUX: -t=21600
#FLUX: --urgency=16

module load gcc/10.2.0
./covid_multistrain/covid_ms --ttiq-type=${TTIQ_TYPE} -a${AGE_DIST_FILE} -s${STRAIN_PARAMS} -v${VACCINE_PARAMS} -e${EXPOSURE_PARAMS} -i${IMMUNITY_PARAMS} -c${CONTACT_FILE} -r${SCENARIO_FILE} -o${OUTPUT_DIR} -n$SLURM_ARRAY_TASK_ID -t${T_END}
