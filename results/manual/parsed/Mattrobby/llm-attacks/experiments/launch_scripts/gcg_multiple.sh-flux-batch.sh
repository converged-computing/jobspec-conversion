#!/bin/bash
#FLUX: --job-name=stanky-spoon-9370
#FLUX: --priority=16

module load gcc/9.2 cmake python3/3.10 cuda/11.7
source ../../.venv/bin/activate
INITIALTIME=$(date)
echo "The initial time is " $INITIALTIME
bash run_gcg_multiple.sh llama2
FINALTIME=$(date)
echo "Finished at " $FINALTIME
echo "Elapsed time is " $FINALTIME-$INITIALTIME
