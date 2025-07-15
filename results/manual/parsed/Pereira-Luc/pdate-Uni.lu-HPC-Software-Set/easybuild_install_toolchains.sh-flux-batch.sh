#!/bin/bash
#FLUX: --job-name=install_eb_modules_toolchains
#FLUX: --queue=batch
#FLUX: -t=72000
#FLUX: --priority=16

export EASYBUILD_JOB_BACKEND='Slurm'

module purge
export EASYBUILD_JOB_BACKEND=Slurm
print_error_and_exit() { echo "***ERROR*** $*"; exit 1; }
hash parallel 2>/dev/null && test $? -eq 0 || print_error_and_exit "Parallel is not installed on the system"
module load tools/EasyBuild/4.9.1
TOOLCHAIN="intel-2023a.eb"
EBFILES=($TOOLCHAIN)
mkdir -p eb_logs_toolchains
parallel -j 1 --verbose --joblog eb_logs_toolchains/eb_joblog.log "srun -n1  -c 8 eb {} --robot --job --job-cores=8 --job-max-walltime=5 --job-backend-config=slurm --trace --accept-eula-for=Intel-oneAPI> eb_logs_toolchains/eb_log_{#}.log" ::: "${EBFILES[@]}"
echo 'Tasks are all running now.'
echo 'Use sq to see them. '
