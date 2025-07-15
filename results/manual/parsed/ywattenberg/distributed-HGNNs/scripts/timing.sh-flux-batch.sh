#!/bin/bash
#FLUX: --job-name=thnn
#FLUX: -c=8
#FLUX: -t=7200
#FLUX: --priority=16

set -o errexit
TMPDIR=$(mktemp -d)
if [[ ! -d ${TMPDIR} ]]; then
    echo 'Failed to create temp directory' >&2
    exit 1
fi
trap "exit 1" HUP INT TERM
trap 'rm -rf "${TMPDIR}"' EXIT
export TMPDIR
cd "${TMPDIR}" || exit 1
CPUS=$((${SLURM_CPUS_PER_TASK} * ${SLURM_NTASKS}))
echo "Running on node:      $(hostname)"
echo "In directory:         $(pwd)"
echo "Starting on:          $(date)"
echo "SLURM_JOB_ID:         ${SLURM_JOB_ID}"
echo "SLURM_JOB_NODELIST:   ${SLURM_JOB_NODELIST}"
echo "SLURM_NTASKS:         ${SLURM_NTASKS}"
echo "SLURM_CPUS_PER_TASK:  ${SLURM_CPUS_PER_TASK}"
echo "CPUS:                 ${CPUS}"
rsync -ah --stats /cluster/home/$USER/distributed-HGNNs/data $TMPDIR
module load gcc/11.4.0 openmpi openblas cmake/3.26.3 eth_proxy curl
echo "Dependencies installed"
cd $HOME/distributed-HGNNs/build
cmake ..
make -j $CPUS
echo "Build finished at:          $(date)"
echo "Starting timing run at:     $(date)"
$HOME/distributed-HGNNs/build/torchtest -c "${HOME}/distributed-HGNNs/config/128.yaml" -d ${TMPDIR} -i ${SLURM_JOB_ID} -p $CPUS -t 1
echo "Finished timing run at:     $(date)"
exit 0
