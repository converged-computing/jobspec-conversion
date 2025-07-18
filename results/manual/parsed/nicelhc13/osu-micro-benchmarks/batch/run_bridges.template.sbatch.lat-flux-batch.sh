#!/bin/bash
#FLUX: --job-name=delicious-taco-6744
#FLUX: -N=2
#FLUX: -n=2
#FLUX: --queue=gpu
#FLUX: -t=900
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
export MV2_SHOW_ENV_INFO='1'

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
export MV2_SHOW_ENV_INFO=1
echo "Device to Device (Lt)"
mpirun_rsh -export-all -hostfile hosts.txt.$SLURM_JOBID -np 2 ./osu_latency -m 0:40000000 -d cuda D D
echo "S-Device to Device-S (Lt)"
mpirun_rsh -export-all -hostfile hosts.txt.$SLURM_JOBID -np 2 ./osu_latency -m 0:40000000 -d cuda -g D D
echo "Host to Host (Lt)"
mpirun_rsh -export-all -hostfile hosts.txt.$SLURM_JOBID -np 2 ./osu_latency -m 0:40000000 H H
echo "S-Host to Host-S (Lt)"
mpirun_rsh -export-all -hostfile hosts.txt.$SLURM_JOBID -np 2 ./osu_latency -m 0:40000000 -c H H
echo "D-Host to Host-D (Lt)"
mpirun_rsh -export-all -hostfile hosts.txt.$SLURM_JOBID -np 2 ./osu_latency -m 0:40000000 -g H H
echo "SD-Host to Host-DS (Lt)"
mpirun_rsh -export-all -hostfile hosts.txt.$SLURM_JOBID -np 2 ./osu_latency_sdh_hds -m 0:40000000 -g H H
rm hosts.txt.$SLURM_JOBID
