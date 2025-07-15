#!/bin/bash
#FLUX: --job-name=in5550
#FLUX: -t=10800
#FLUX: --urgency=16

source ${HOME}/.bashrc
if [ -n "${SLURM_JOB_NODELIST}" ]; then
  export OPENBLAS_NUM_THREADS=${SLURM_CPUS_ON_NODE}
fi
set -o errexit
set -o nounset
module purge
module use -a /cluster/shared/nlpl/software/modules/etc
module add nlpl-in5550/202005/3.7
module add nlpl-tensorflow/2.0.0/3.7
module add nlpl-fasttext/0.9.2/3.7
echo "submission directory: ${SUBMITDIR}"
ulimit -a module list
python babil "${@}"
