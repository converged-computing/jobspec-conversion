#!/bin/bash
#SBATCH --job-name=exawind-sphere
#SBATCH --output=%x.o%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00

set -e
cmd() {
  echo "+ $@"
  eval "$@"
}
cmd "module purge"
cmd "module load PrgEnv-intel"
cmd "export SPACK_MANAGER=${HOME}/exawind/spack-manager"
cmd "source ${SPACK_MANAGER}/start.sh && spack-start"
cmd "spack env activate exawind-kestrel"
cmd "spack load exawind~amr_wind_gpu~nalu_wind_gpu"
cmd "which exawind"
cmd "srun -N1 -n2 exawind --awind 1 --nwind 1 sphere.yaml"
