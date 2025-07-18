#!/bin/bash
#FLUX: --job-name=S2_TEannot
#FLUX: --queue=intel
#FLUX: -t=172800
#FLUX: --urgency=16

module load repet/2.5
if  [ ! -n "$ProjectName" ] || [ ! -n "$ALIGNERS_AVAIL" ]; then
    echo 'One or more environment variables required by this script' \
    'are unset. Either run this script through the scheduler script or' \
    'set the variable(s) and use the --export option of sbatch before' \
    'restarting.'
    exit 1
fi
if [ "$(( $SLURM_ARRAY_TASK_ID % 2 ))" -eq "0" ]; then
    OUT_DIR="${ProjectName}_TEdetect"
    CMD_SUFFIX=""
elif [ "$(( $SLURM_ARRAY_TASK_ID % 2 ))" -eq "1" ]; then
    OUT_DIR="${ProjectName}_TEdetect_rnd"
    CMD_SUFFIX="-r"
else
    echo "SLURM array improperly set up"
    exit 1
fi
IFS='+' read -ra ALIGNERS_AVAIL_ARRAY <<< "${ALIGNERS_AVAIL}"
NUM_ALIGNERS=${#ALIGNERS_AVAIL_ARRAY[@]}
ALIGNER=${ALIGNERS_AVAIL_ARRAY[$(( $SLURM_ARRAY_TASK_ID % $NUM_ALIGNERS ))]}
if [ ! -d "${OUT_DIR}/${ALIGNER}" ]; then
    TEannot.py -P $ProjectName -C TEannot.cfg -S 2 -a $ALIGNER $CMD_SUFFIX
else
    echo "Step 2 output folder detected, skipping..."
fi
