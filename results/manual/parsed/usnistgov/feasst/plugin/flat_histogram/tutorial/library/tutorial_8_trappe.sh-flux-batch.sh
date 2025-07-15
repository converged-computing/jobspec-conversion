#!/bin/bash
#FLUX: --job-name=evasive-ricecake-2807
#FLUX: --priority=16

((num_hours=1))
num_procs=12
((num_procs_ext=2*$num_procs))
function launch_node {
cat << _EOF_ > launch.cmd
echo "Running on host \$(hostname)"
echo "Time is \$(date)"
echo "Directory is \$PWD"
echo "ID is \$SLURM_JOB_ID"
cd \$PWD
python tutorial_8_trappe.py \
  --task \$SLURM_ARRAY_TASK_ID \
  -p ~/feasst/forcefield/ethane.fstprt \
  -p ~/feasst/forcefield/ethene.fstprt \
  --num_hours $num_hours \
  --num_procs $num_procs
echo "Job is done"
echo "Time is \$(date)"
_EOF_
sbatch --array=0-15%1 launch.cmd
}
launch_node
