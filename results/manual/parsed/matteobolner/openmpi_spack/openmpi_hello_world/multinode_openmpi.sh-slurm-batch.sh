#!/bin/bash
#SBATCH --account=ExaF_prod_0
#SBATCH --output=myJob.out
#SBATCH --error=myJob.err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:01:00
#SBATCH --constraint=ntasks-per-node=1

module use /marconi_work/ExaF_prod_0/spack/opt/spack/linux-centos7-broadwell/gcc-7.3.0/openmpi-4.0.1-tsuqdoly7rjs3vy6dk5pugjj4so3cu26
module load openmpi-4.0.1-gcc-7.3.0-tsuqdol
srun -display-allocation -N $SLURM_NTASKS hello
