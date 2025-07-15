#!/bin/bash
#FLUX: --job-name=crunchy-avocado-3888
#FLUX: -t=345600
#FLUX: --urgency=16

export PRODUCT_DIRECTORY='/orange/adamginsburg/ALMA_IMF/2017.1.01355.L/imaging_results/'
export IPYTHONDIR='/tmp'
export CASA='/orange/adamginsburg/casa/${CASAVERSION}/bin/casa'
export ALMAIMF_ROOTDIR='/orange/adamginsburg/ALMA_IMF/reduction/reduction'
export USE_TEMPORARY_WORKING_DIRECTORY='True'
export TEMP_WORKDIR='$(pwd)/${FIELD_ID}_${LINE_NAME}_${suffix12m}_${BAND_TO_IMAGE}'
export PYTHONPATH='$SCRIPT_DIR'
export SCRIPT_DIR='$ALMAIMF_ROOTDIR'

env
pwd; hostname; date
echo "Memory=${MEM}"
if [ -z $WORK_DIRECTORY ]; then
    export WORK_DIRECTORY='/blue/adamginsburg/adamginsburg/almaimf/workdir'
fi
export PRODUCT_DIRECTORY='/orange/adamginsburg/ALMA_IMF/2017.1.01355.L/imaging_results/'
export IPYTHONDIR=/tmp
module load git
which python
which git
git --version
echo $?
if [[ ! $CASAVERSION ]]; then
    CASAVERSION=casa-6.4.3-4
    echo "Set CASA version to default ${CASAVERSION}"
fi
echo "CASA version = ${CASAVERSION}"
export CASA=/orange/adamginsburg/casa/${CASAVERSION}/bin/casa
export ALMAIMF_ROOTDIR="/orange/adamginsburg/ALMA_IMF/reduction/reduction"
cd ${ALMAIMF_ROOTDIR}
python getversion.py
cd ${WORK_DIRECTORY}
export USE_TEMPORARY_WORKING_DIRECTORY=True
export TEMP_WORKDIR=$(pwd)/${FIELD_ID}_${LINE_NAME}_${suffix12m}_${BAND_TO_IMAGE}
if ! [[ -d ${TEMP_WORKDIR} ]]; then
    mkdir ${TEMP_WORKDIR}
fi
ln ${WORK_DIRECTORY}/to_image.json ${TEMP_WORKDIR}/to_image.json
ln ${WORK_DIRECTORY}/metadata.json ${TEMP_WORKDIR}/metadata.json
cd ${TEMP_WORKDIR}
pwd
echo "Listing contents of directory $(pwd): json files $(ls -lhrt *.json), others: $(ls)"
echo "Working in ${TEMP_WORKDIR} = $(pwd)"
echo "Publishing to  ${PRODUCT_DIRECTORY}"
echo ${LINE_NAME} ${BAND_NUMBERS}
export PYTHONPATH=$ALMAIMF_ROOTDIR
export SCRIPT_DIR=$ALMAIMF_ROOTDIR
export PYTHONPATH=$SCRIPT_DIR
echo $LOGFILENAME
echo xvfb-run -d ${CASA} --nogui --nologger --logfile=${LOGFILENAME} -c "execfile('$SCRIPT_DIR/line_imaging.py')"
xvfb-run -d ${CASA} --nogui --nologger --logfile=${LOGFILENAME} -c "execfile('$SCRIPT_DIR/line_imaging.py')" &
ppid="$!"; childPID="$(ps -C ${CASA} -o ppid=,pid= | awk -v ppid="$ppid" '$1==ppid {print $2}')"
echo PPID=${ppid} childPID=${childPID}
if [[ ! -z $childPID ]]; then 
    /orange/adamginsburg/miniconda3/bin/python ${ALMAIMF_ROOTDIR}/slurm_scripts/monitor_memory.py ${childPID}
else
    echo "FAILURE: PID=$childPID was not set."
fi
wait $ppid
exitcode=$?
cd -
if [[ -z $(ls -A ${TEMP_WORKDIR}) ]]; then
    rmdir ${TEMP_WORKDIR}
fi
exit $exitcode
