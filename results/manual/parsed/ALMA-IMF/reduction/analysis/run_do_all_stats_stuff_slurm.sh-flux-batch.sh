#!/bin/bash
#FLUX: --job-name=stats_stuff
#FLUX: -n=16
#FLUX: -t=345600
#FLUX: --urgency=16

export WORK_DIR='/orange/adamginsburg/ALMA_IMF/2017.1.01355.L/imaging_results'
export IPYTHON='/orange/adamginsburg/miniconda3/envs/casa6_py36/bin/ipython '
export SCRIPT_DIR='/orange/adamginsburg/ALMA_IMF/reduction/analysis'
export PYTHONPATH='$SCRIPT_DIR'

pwd; hostname; date
export WORK_DIR="/orange/adamginsburg/ALMA_IMF/reduction/analysis"
export WORK_DIR="/orange/adamginsburg/ALMA_IMF/2017.1.01355.L/imaging_results"
module load git
which python
which git
git --version
echo $?
export IPYTHON=/orange/adamginsburg/miniconda3/envs/casa6_py36/bin/ipython 
cd ${WORK_DIR}
python /orange/adamginsburg/ALMA_IMF/reduction/reduction/getversion.py
cd ${WORK_DIR}
echo ${WORK_DIR}
echo ${LINE_NAME} ${BAND_NUMBERS}
export SCRIPT_DIR="/orange/adamginsburg/ALMA_IMF/reduction/analysis"
export PYTHONPATH=$SCRIPT_DIR
echo $LOGFILENAME
env
xvfb-run -d ${IPYTHON} ${SCRIPT_DIR}/do_all_stats_stuff.py
