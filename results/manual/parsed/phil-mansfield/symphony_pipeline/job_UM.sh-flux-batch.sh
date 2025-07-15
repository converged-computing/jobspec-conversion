#!/bin/bash
#FLUX: --job-name=arid-pedo-5532
#FLUX: -t=7200
#FLUX: --urgency=16

python3 print_UM.py configs/Group/config.txt ${SLURM_ARRAY_TASK_ID} &&
   python3 write_um_file.py configs/Group/config.txt ${SLURM_ARRAY_TASK_ID} &&
   echo "done"
