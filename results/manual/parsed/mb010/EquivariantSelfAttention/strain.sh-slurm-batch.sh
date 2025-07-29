#!/bin/bash
#SBATCH --job-name=Training
#SBATCH --mail-user=micah.bowles@postgrad.manchester.ac.uk
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=17
#SBATCH --time=14-00:00:00
#SBATCH --constraint=A100,ntasks-per-node=1
#SBATCH --array=0-23%24

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
