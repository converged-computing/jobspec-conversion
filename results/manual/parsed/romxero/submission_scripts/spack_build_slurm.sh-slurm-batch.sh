#!/bin/bash
#FLUX: --job-name=spack_environment_builds
#FLUX: -c=4
#FLUX: --queue=preempted,cpu
#FLUX: -t=86400
#FLUX: --urgency=16

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
