#!/bin/bash
#FLUX: --job-name=make_ACES_scripts
#FLUX: -t=345600
#FLUX: --urgency=16

export ACES='/orange/adamginsburg/ACES/'
export WORK_DIR='/blue/adamginsburg/adamginsburg/ACES/workdir'
export ACES_DATADIR='${ACES}/data/'
export WEBLOG_DIR='${ACES}/data/2021.1.00172.L/weblogs/'
export PYPATH='/orange/adamginsburg/miniconda3/envs/python39/bin/'
export IPYTHON='/orange/adamginsburg/miniconda3/envs/python39/bin/ipython'
export ACES_ROOTDIR='/orange/adamginsburg/ACES/reduction_ACES/'
export SCRIPT_DIR='${ACES_ROOTDIR}/analysis'
export PYTHONPATH='$SCRIPT_DIR'
export NO_PROGRESSBAR='True'
export ENVIRON='BATCH'
export DASK_THREADS='$SLURM_NTASKS'
export TRYDROPTARGET='True'
export TEMPORARY_WORKING_DIRECTORY='/blue/adamginsburg/adamginsburg/ACES/workdir'

pwd; hostname; date
export ACES="/orange/adamginsburg/ACES/"
export WORK_DIR="/orange/adamginsburg/ACES/reduction_ACES/"
export WORK_DIR="/blue/adamginsburg/adamginsburg/ACES/workdir"
export ACES_DATADIR="${ACES}/data/"
export WEBLOG_DIR="${ACES}/data/2021.1.00172.L/weblogs/"
module load git
which python
which git
git --version
echo $?
export PYPATH=/orange/adamginsburg/miniconda3/envs/python39/bin/
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
export TRYDROPTARGET=True
export TEMPORARY_WORKING_DIRECTORY="/blue/adamginsburg/adamginsburg/ACES/workdir"
env
echo "Recovering tclean commands"
${PYPATH}/aces_recover_tclean_commands || exit 1
echo "Writing tclean scripts"
${PYPATH}/aces_write_tclean_scripts || exit 1
echo "Calling job running"
${PYPATH}/aces_job_runner --verbose=True --parallel || exit 1
echo "Linking repipeline weblogs"
${PYPATH}/aces_link_repipeline_weblogs || exit 1
echo "Done!"
