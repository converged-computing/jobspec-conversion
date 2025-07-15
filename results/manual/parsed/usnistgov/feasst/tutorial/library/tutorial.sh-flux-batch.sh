#!/bin/bash
#FLUX: --job-name=red-motorcycle-1799
#FLUX: --priority=16

function launch_node {
cat << _EOF_ > launch.cmd
echo "Running on host \$(hostname)"
echo "Time is \$(date)"
echo "Directory is \$PWD"
echo "ID is \$SLURM_JOB_ID"
cd \$PWD
python tutorial.py --trials $trials
if [ \$? == 0 ]; then
  echo "Job is done"
  scancel \$SLURM_ARRAY_JOB_ID
else
  echo "Job is terminating, to be restarted again"
fi
echo "Time is \$(date)"
_EOF_
sbatch launch.cmd
}
trials=15000000
launch_node
