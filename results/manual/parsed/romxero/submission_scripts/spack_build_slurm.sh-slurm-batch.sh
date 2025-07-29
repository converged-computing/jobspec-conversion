#!/bin/bash
#SBATCH --job-name=spack_environment_builds
#SBATCH --output=spack_environment_builds_%A.%a.out
#SBATCH --error=spack_environment_builds_%A.%a.err
#SBATCH --mail-user=randall.white@czbiohub.org
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=2G
#SBATCH --time=1-00:00:00
#SBATCH --partition=preempted,cpu
#SBATCH --chdir=/home/randall.white/hpc/spack

SPACK_ENV_NAME="MY_TEST_ENVIRONMENT"
ml purge
ml load gcc/11.3
git clone git@github.com:romxero/spack_cz_tester.git
cp spack_cz_tester/cz_spack.yml .
source spack/share/spack/setup-env.sh
spack compiler find /hpc/apps/x86_64/gcc/11.3
spack env activate -p ${SPACK_ENV_NAME} ./cz_spack.yml
spack install -J ${SLURM_CPUS_PER_TASK}
spack env deactivate
exit 0 
