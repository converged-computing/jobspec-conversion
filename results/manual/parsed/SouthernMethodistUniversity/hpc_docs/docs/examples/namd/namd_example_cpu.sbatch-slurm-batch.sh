#!/bin/bash
#SBATCH --job-name=example
#SBATCH --output=example.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=standard-mem-s
#SBATCH: --exclusive

module purge
module load namd/2.12/cpu
lfs setstripe -c 4 $SLURM_SUBMIT_DIR
N=$(awk '/processor/{a=$3}END{print a}' /proc/cpuinfo)
for n in `echo $SLURM_NODELIST | scontrol show hostnames`; do
  echo "host $n ++cpus $N" >> nodelist.$SLURM_JOBID
done
PPN=$(($N - 1))
P=$(($PPN * $SLURM_NNODES))
charmrun $(which namd2) ++p $P ++ppn $PPN ++nodelist nodelist.$SLURM_JOBID +setcpuaffinity +isomalloc_sync example.conf
rm nodelist.$SLURM_JOBID
