#!/bin/bash
#FLUX: --job-name=Training
#FLUX: -c=17
#FLUX: -t=1209600
#FLUX: --priority=16

echo ">>> start"
echo ">>> Training"
CFGS=()
while IFS= read -r line; do
  [[ "$line" =~ ^#.*$ ]] && continue
  CFGS+=("$line")
done < configs/experiment_configs.txt
CFG=${CFGS[$SLURM_ARRAY_TASK_ID]}
echo '>>> Training:' $CFG
python -u train.py --config $CFG
