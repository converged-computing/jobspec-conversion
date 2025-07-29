#!/bin/bash
#SBATCH --job-name=cube_stats_grid_ACES
#SBATCH --account=adamginsburg
#SBATCH --output=/blue/adamginsburg/adamginsburg/ACES/logs/cube_stats_grid_ACES_%j.log
#SBATCH --mail-user=adamginsburg@ufl.edu
#SBATCH --mail-type=NONE
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=256gb
#SBATCH --time=4-00:00:00
#SBATCH --qos=adamginsburg-b

export WORK_DIR='/blue/adamginsburg/adamginsburg/ACES/workdir'
export IPYTHON='/orange/adamginsburg/miniconda3/envs/python39/bin/ipython'
export ACES_ROOTDIR='/orange/adamginsburg/ACES/reduction_ACES/'
export SCRIPT_DIR='${ACES_ROOTDIR}/analysis'
export PYTHONPATH='$SCRIPT_DIR'
export NO_PROGRESSBAR='True'
export ENVIRON='BATCH'
export JOBNAME='cube_stats_grid_ACES'
export jobname='$JOBNAME'
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
export JOBNAME=cube_stats_grid_ACES
export jobname=$JOBNAME
export DASK_THREADS=$SLURM_NTASKS
env
/orange/adamginsburg/miniconda3/envs/python39/bin/aces_cube_stats_grid
