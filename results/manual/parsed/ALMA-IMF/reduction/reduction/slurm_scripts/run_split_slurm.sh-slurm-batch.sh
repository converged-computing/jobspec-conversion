#!/bin/bash
#FLUX: --job-name=split_windows
#FLUX: -t=604800
#FLUX: --urgency=16

export ALMAIMF_ROOTDIR='/orange/adamginsburg/ALMA_IMF/reduction/reduction'
export SCRIPT_DIR='$ALMAIMF_ROOTDIR'
export PYTHONPATH='$SCRIPT_DIR'
export CASA='/orange/adamginsburg/casa/casa-release-5.6.0-60.el7/bin/casa'
export LOGFILENAME='casa_log_split_$(date +%Y-%m-%d_%H_%M_%S).log'

WORK_DIR='/orange/adamginsburg/ALMA_IMF/2017.1.01355.L'
module load git
which python
which git
git --version
echo $?
export ALMAIMF_ROOTDIR="/orange/adamginsburg/ALMA_IMF/reduction/reduction"
cd ${ALMAIMF_ROOTDIR}
python getversion.py
cd ${WORK_DIR}
echo ${WORK_DIR}
export SCRIPT_DIR=$ALMAIMF_ROOTDIR
export PYTHONPATH=$SCRIPT_DIR
export CASA=/orange/adamginsburg/casa/casa-release-5.6.0-60.el7/bin/casa
export LOGFILENAME="casa_log_split_$(date +%Y-%m-%d_%H_%M_%S).log"
echo $LOGFILENAME
xvfb-run -d ${CASA} --nogui --nologger --logfile=${LOGFILENAME} -c "execfile('$SCRIPT_DIR/split_windows.py')"
