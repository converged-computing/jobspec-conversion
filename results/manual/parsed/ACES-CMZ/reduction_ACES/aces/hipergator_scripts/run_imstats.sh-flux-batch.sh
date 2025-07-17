#!/bin/bash
#FLUX: --job-name=imstats_ACES
#FLUX: -n=32
#FLUX: -t=345600
#FLUX: --urgency=16

export WORK_DIR='/blue/adamginsburg/adamginsburg/ACES/workdir'
export IPYTHON='/orange/adamginsburg/miniconda3/envs/python39/bin/ipython'
export ACES_ROOTDIR='/orange/adamginsburg/ACES/reduction_ACES/'
export SCRIPT_DIR='${ACES_ROOTDIR}/analysis'
export PYTHONPATH='$SCRIPT_DIR'
export NO_PROGRESSBAR='True'
export ENVIRON='BATCH'
export DASK_THREADS='$SLURM_NTASKS'

pwd; hostname; date
export WORK_DIR="/blue/adamginsburg/adamginsburg/ACES/workdir"
module load git
which python
which git
git --version
echo $?
export IPYTHON=/orange/adamginsburg/miniconda3/envs/python39/bin/ipython
cd ${WORK_DIR}
echo ${WORK_DIR}
export ACES_ROOTDIR="/orange/adamginsburg/ACES/reduction_ACES/"
export SCRIPT_DIR="${ACES_ROOTDIR}/analysis"
export PYTHONPATH=$SCRIPT_DIR
echo $LOGFILENAME
export NO_PROGRESSBAR='True'
export ENVIRON='BATCH'
export DASK_THREADS=$SLURM_NTASKS
env
/orange/adamginsburg/miniconda3/envs/python39/bin/aces_imstats
