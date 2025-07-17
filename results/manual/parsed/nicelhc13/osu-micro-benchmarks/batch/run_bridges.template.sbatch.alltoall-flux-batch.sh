#!/bin/bash
#FLUX: --job-name=gassy-toaster-3591
#FLUX: -N=2
#FLUX: -n=8
#FLUX: --queue=gpu
#FLUX: -t=2100
#FLUX: --urgency=16

export HFILE='`generate_pbs_nodefile`'
export OMP_NUM_THREADS='1'
export MV2_USE_CUDA='1'
export MV2_USE_GDR='1'
export MPI_THREAD_MULTIPLE='1'
export MV2_CPU_MAPPING='0'
export MV2_ENABLE_AFFINITY='0'
export LD_PRELOAD='/home/hlee89/bin/opt/mvapich2/gdr/2.3.4/mcast/no-openacc/cuda10.1/mofed4.7/mpirun/gnu4.8.5/lib64/libmpi.so'
export MV2_DEBUG_SHOW_BACKTRACE='1'

nvidia-smi
source ~/.bash_profile
module list
RUN=mpirun
mpirun --version
export HFILE=`generate_pbs_nodefile`
cat $HFILE | sort -u > hosts.txt.$SLURM_JOBID
export OMP_NUM_THREADS=1
export MV2_USE_CUDA=1
export MV2_USE_GDR=1
export MPI_THREAD_MULTIPLE=1
export MV2_CPU_MAPPING=0
export MV2_ENABLE_AFFINITY=0
export LD_PRELOAD=/home/hlee89/bin/opt/mvapich2/gdr/2.3.4/mcast/no-openacc/cuda10.1/mofed4.7/mpirun/gnu4.8.5/lib64/libmpi.so
export MV2_DEBUG_SHOW_BACKTRACE=1
echo "D-Host to Host-D (A2A)"
mpirun_rsh -export-all -hostfile hosts.txt.$SLURM_JOBID -np 8 ./osu_alltoall -m 0:40000000 -g -r gpu
rm hosts.txt.$SLURM_JOBID
