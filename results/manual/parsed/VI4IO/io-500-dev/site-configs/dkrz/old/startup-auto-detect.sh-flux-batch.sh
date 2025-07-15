#!/bin/bash
#FLUX: --job-name=IO-500
#FLUX: -N=10
#FLUX: -t=10200
#FLUX: --urgency=16

module load bullxmpi
module load intel
maxTasks=$((${SLURM_JOB_CPUS_PER_NODE} * ${SLURM_JOB_NUM_NODES}))
mpirun="srun -m block"
workdir=/mnt/lustre02/work/k20200/k202079/io500-data/
output_dir=/mnt/lustre02/work/k20200/k202079/io500-results-${SLURM_JOB_NUM_NODES}
mkdir -p ${workdir}/ior_easy
lfs setstripe --stripe-count 2  ${workdir}/ior_easy
mkdir -p ${workdir}/ior_hard
lfs setstripe --stripe-count 100  ${workdir}/ior_hard
find_cmd=$PWD/../../find/io500-find.sh
ior_cmd=/home/dkrz/k202079/work/io-500/io-500-dev/proposal-draft/ior
mdtest_cmd=/home/dkrz/k202079/work/io-500/io-500-dev/proposal-draft/mdtest
params_mdreal="-P=10 -I=10"
identify_parameters_ior_hard=True
identify_parameters_ior_easy=True
identify_parameters_md_easy=True # also enables to do the find
identify_parameters_md_hard=True
identify_parameters_find=False # only works if ior_easy is also run
timeExpected=10
cd ..
source ./auto-determine-parameters.sh | tee auto-${SLURM_JOB_NUM_NODES}-${SLURM_JOB_CPUS_PER_NODE}.txt
