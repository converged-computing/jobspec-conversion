#!/bin/bash
#FLUX: --job-name=salted-ricecake-9675
#FLUX: --priority=16

GROUP='iqss_lab'
if [ -z "$SCRATCH" ]; then
  echo "$0: ERROR: Cannot run a multi-node script without a shared \$SCRATCH" >&2
  exit 1
fi
SCRIPT=$(mktemp -p $SCRATCH/$GROUP)
if [ -z "$SCRIPT" ]; then
  echo "$0: ERROR: Could not create tempfile" >&2
  exit 1
fi
cat > $SCRIPT << EOF
print_info() {
  cpuset=\$(cat /sys/fs/cgroup/cpuset/slurm/uid_\$(id -u)/job_\${SLURM_JOB_ID}/cpuset.cpus)
  memory_limit=\$(cat /sys/fs/cgroup/memory/slurm/uid_\$(id -u)/job_\${SLURM_JOB_ID}/memory.limit_in_bytes)
  echo "PID \$\$ running on \$(hostname) allocated cpuset \\"\$cpuset\\" memory limit \\"\$memory_limit\\""
}
print_info
EOF
echo "Running: srun -n $SLURM_NTASKS -c $SLURM_CPUS_PER_TASK -N $SLURM_JOB_NUM_NODES bash $SCRIPT"
srun -n $SLURM_NTASKS -c $SLURM_CPUS_PER_TASK -N $SLURM_JOB_NUM_NODES bash $SCRIPT
rm -f $SCRIPT
