#!/bin/bash
#SBATCH --job-name=imstats_ACES
#SBATCH --account=adamginsburg
#SBATCH --output=/blue/adamginsburg/adamginsburg/ACES/logs/imstats_ACES_%j.log
#SBATCH --mail-user=adamginsburg@ufl.edu
#SBATCH --mail-type=NONE
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=128gb
#SBATCH --time=4-00:00:00
#SBATCH --qos=adamginsburg-b

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
