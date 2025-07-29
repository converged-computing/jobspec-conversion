#!/bin/bash
#SBATCH --output=alltoall.cpy.2.out
#SBATCH --mail-user=hochan@utexas.edu
#SBATCH --mail-type=end
#SBATCH --nodes=2
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:p100:4
#SBATCH --time=00:35:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=4,exclusive
#SBATCH --exclude=comet-33-15

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
