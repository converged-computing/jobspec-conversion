#!/bin/bash
#FLUX: --job-name=example
#FLUX: --exclusive
#FLUX: --queue=gpgpu-1
#FLUX: --urgency=16

module purge
module load namd/2.12/gpu
lfs setstripe -c 2 $SLURM_SUBMIT_DIR
N=$(awk '/processor/{a=$3}END{print a}' /proc/cpuinfo)
for n in `echo $SLURM_NODELIST | scontrol show hostnames`; do
  echo "host $n ++cpus $N" >> nodelist.$SLURM_JOBID
done
PPN=$(($N - 1))
P=$(($PPN * $SLURM_NNODES))
charmrun $(which namd2) ++mpiexec ++p $P ++ppn $PPN ++nodelist nodelist.$SLURM_JOBID +setcpuaffinity +isomalloc_sync example.conf
rm nodelist.$SLURM_JOBID
