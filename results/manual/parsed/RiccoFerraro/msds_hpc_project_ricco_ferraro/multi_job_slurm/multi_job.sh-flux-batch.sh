#!/bin/bash
#FLUX: --job-name=hpc_assignment_05_ricco_ferraro
#FLUX: --priority=16

cmd=$(cat <<-END
print("running python in signularity container")
END
)
singularity exec ./lab02.sif /opt/view/bin/python3.8 -c "$cmd"
echo "============= job id ============="
echo "jobID is: $SLURM_JOBID"
echo "============= node hostname =============="
hostname=$(srun hostname)
echo "$hostname"
echo "============= current node info ============="
scontrol show node "$hostname"
echo "============= all job info ============="
sinfo --long
echo "============= proc cpu info ============="
proc_info=$(cat /proc/cpuinfo)
echo "$proc_info"
echo "============= free info ============="
free -g
