#!/bin/bash
#FLUX: --job-name=red-gato-5059
#FLUX: -n=4
#FLUX: -t=345600
#FLUX: --urgency=16

export ALMAIMF_ROOTDIR='/orange/adamginsburg/ALMA_IMF/reduction/reduction'
export CASA='/orange/adamginsburg/casa/casa-release-5.7.0-134.el7/bin/casa'
export PYTHONPATH='$ALMAIMF_ROOTDIR'

pwd; hostname; date
module load git
which python
which git
git --version
echo $?
export ALMAIMF_ROOTDIR="/orange/adamginsburg/ALMA_IMF/reduction/reduction"
cd ${ALMAIMF_ROOTDIR}
python getversion.py
WORK_DIR='/orange/adamginsburg/ALMA_IMF/2017.1.01355.L'
export CASA=/orange/adamginsburg/casa/casa-release-5.7.0-134.el7/bin/casa
cd ${WORK_DIR}
echo ${WORK_DIR}
echo FIELD=${FIELD_ID}  BAND=${BAND_TO_IMAGE}  EXCLUDE_7M=${EXCLUDE_7M}  ONLY_7M=${ONLY_7M}
export PYTHONPATH=$ALMAIMF_ROOTDIR
echo "Logfilename is ${LOGFILENAME}"
echo xvfb-run -d ${CASA} --logfile=${LOGFILENAME}  --nogui --nologger -c "execfile('$ALMAIMF_ROOTDIR/continuum_imaging_selfcal.py')"
echo "ALMAIMF_ROOTDIR: ${ALMAIMF_ROOTDIR}"
xvfb-run -d ${CASA} --logfile=${LOGFILENAME}  --nogui --nologger -c "execfile('$ALMAIMF_ROOTDIR/continuum_imaging_selfcal.py')"
