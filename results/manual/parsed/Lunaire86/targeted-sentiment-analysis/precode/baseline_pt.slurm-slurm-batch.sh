#!/bin/bash
#SBATCH --job-name=in5550
#SBATCH --account=nn9447k
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=2

source ${HOME}/.bashrc
if [ -n "${SLURM_JOB_NODELIST}" ]; then
  export OPENBLAS_NUM_THREADS=${SLURM_CPUS_ON_NODE}
fi
set -o errexit
set -o nounset
module purge
module use -a /cluster/shared/nlpl/software/modules/etc
module add nlpl-in5550/202002/3.7
module add nlpl-tensorflow/2.0.0/3.7
echo "submission directory: ${SUBMITDIR}"
ulimit -a module list
python precode/baseline.py "${@}"
