#!/bin/bash
#SBATCH --job-name=pytorch.distributed
#SBATCH --account=dt-mtp
#SBATCH --output=%x-%j.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:4
#SBATCH --time=00:20:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=1

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

readonly MASTER_ADDR_JOB=$SLURMD_NODENAME
readonly MASTER_PORT_JOB="12234"
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
readonly srun='srun --output=%x-%j.%t.out'
env
$srun bash \
   task.sh \
      $MASTER_ADDR_JOB \
      $MASTER_PORT_JOB &
wait
