#!/bin/bash
#FLUX: --job-name=hanky-itch-8506
#FLUX: -t=345600
#FLUX: --urgency=16

export PATH='/apps/gcc/9.3.0/gsl/2.6/bin:/apps/compilers/gcc/9.3.0/bin:/apps/libfuse/3.10.4/bin:/apps/ufrc/bin:/apps/screen/4.8.0/bin:/opt/slurm/bin:/usr/lib64/qt-3.3/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/opt/puppetlabs/bin:/bin:/opt/dell/srvadmin/bin:/home/adamginsburg/bin'
export PRODUCT_DIRECTORY='/orange/adamginsburg/ALMA_IMF/2017.1.01355.L/imaging_results/'
export CASA='/blue/adamginsburg/adamginsburg/casa/${CASAVERSION}/bin/casa'
export MPICASA='/blue/adamginsburg/adamginsburg/casa/${CASAVERSION}/bin/mpicasa'
export ALMAIMF_ROOTDIR='/orange/adamginsburg/ALMA_IMF/reduction/reduction'
export USE_TEMPORARY_WORKING_DIRECTORY='True'
export TEMP_WORKDIR='$(pwd)/${FIELD_ID}_${LINE_NAME}_${suffix12m}_${BAND_TO_IMAGE}'
export PYTHONPATH='$SCRIPT_DIR'
export SCRIPT_DIR='$ALMAIMF_ROOTDIR'
export LD_LIBRARY_PATH=''

export PATH=/apps/gcc/9.3.0/gsl/2.6/bin:/apps/compilers/gcc/9.3.0/bin:/apps/libfuse/3.10.4/bin:/apps/ufrc/bin:/apps/screen/4.8.0/bin:/opt/slurm/bin:/usr/lib64/qt-3.3/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/opt/puppetlabs/bin:/bin:/opt/dell/srvadmin/bin:/home/adamginsburg/bin
env
pwd; hostname; date
echo "Memory=${MEM}"
if [ -z $WORK_DIRECTORY ]; then
    export WORK_DIRECTORY='/blue/adamginsburg/adamginsburg/almaimf/workdir'
    #export WORK_DIRECTORY=$TMPDIR
fi
export PRODUCT_DIRECTORY='/orange/adamginsburg/ALMA_IMF/2017.1.01355.L/imaging_results/'
echo "WORK_DIRECTORY=${WORK_DIRECTORY}, PRODUCT_DIRECTORY=${PRODUCT_DIRECTORY}"
echo "Available temp drive: "
df -h /local
module load git gcc/9.3.0 openmpi/4.1.1
which python
which git
git --version
echo $?
if [ -z $SLURM_NTASKS ]; then
    echo "FAILURE - SLURM_NTASKS=${SLURM_NTASKS}, i.e., empty"
    exit
fi
OMPI_COMM_WORLD_SIZE=$SLURM_NTASKS
if [[ ! $CASAVERSION ]]; then
    #CASAVERSION=casa-6.4.3-4
    CASAVERSION=casa-6.4.4-31-py3.8
    CASAVERSION=casa-6.5.0-9-py3.8
    CASAVERSION=casa-6.4.0-16
    #CASAVERSION=casa-6.3.0-48
    #CASAVERSION=casa-6.2.1-3
    #CASAVERSION=casa-6.1.0-118
    echo "Set CASA version to default ${CASAVERSION}"
fi
echo "CASA version = ${CASAVERSION}"
export CASA=/blue/adamginsburg/adamginsburg/casa/${CASAVERSION}/bin/casa
export MPICASA=/blue/adamginsburg/adamginsburg/casa/${CASAVERSION}/bin/mpicasa
export ALMAIMF_ROOTDIR="/orange/adamginsburg/ALMA_IMF/reduction/reduction"
cd ${ALMAIMF_ROOTDIR}
python getversion.py
cd ${WORK_DIRECTORY}
export USE_TEMPORARY_WORKING_DIRECTORY=True
export TEMP_WORKDIR=$(pwd)/${FIELD_ID}_${LINE_NAME}_${suffix12m}_${BAND_TO_IMAGE}
if ! [[ -d ${TEMP_WORKDIR} ]]; then
    mkdir -v ${TEMP_WORKDIR}
fi
PROJECT_DIRECTORY=/orange/adamginsburg/ALMA_IMF/2017.1.01355.L/
cp -v ${PROJECT_DIRECTORY}/to_image.json ${TEMP_WORKDIR}/to_image.json
cp -v ${PROJECT_DIRECTORY}/metadata.json ${TEMP_WORKDIR}/metadata.json
cd ${TEMP_WORKDIR}
pwd
echo "Listing contents of directory ${TEMP_WORKDIR}: json files $(ls -lhrt *.json), others: $(ls)"
echo "Working in ${TEMP_WORKDIR} = $(pwd)"
echo "Publishing to  ${PRODUCT_DIRECTORY}"
echo ${LINE_NAME} ${BAND_NUMBERS}
export PYTHONPATH=$ALMAIMF_ROOTDIR
export SCRIPT_DIR=$ALMAIMF_ROOTDIR
export PYTHONPATH=$SCRIPT_DIR
cp -v ~/.casa/config.py ${TMPDIR}/
cp -v ~/.casarc ${TMPDIR}/rc
cp -v ~/.casarc ${TMPDIR}/.casarc
casamem=$(python -c "print(${SLURM_MEM_PER_NODE}/${NTASKS})")
echo "system.resources.memory: ${casamem}" >> ${TMPDIR}/rc
echo "config.py: (cat ${TMPDIR}/config.py) "
cat ${TMPDIR}/config.py
echo "rc: (cat ${TMPDIR/.casarc}) "
cat ${TMPDIR}/.casarc
echo "rc: (cat ${TMPDIR/rc}) "
cat ${TMPDIR}/rc
echo "Which is used, rc or .casarc?  I think .casarc"
echo "CASA memory set to: ${casamem} in principle, but see system.resources.memory above"
export LD_LIBRARY_PATH=""
echo "ldd /blue/adamginsburg/adamginsburg/casa/${CASAVERSION}/lib/libcasatools.so.4011.25.171:"
ldd /blue/adamginsburg/adamginsburg/casa/${CASAVERSION}/lib/libcasatools.so.4011.25.171
echo logfile=$LOGFILENAME
echo "DEBUG STUFF"
echo "Printing CASA path"
${CASA} --nogui --nologger --ipython-dir=${TMPDIR} --rcdir=${TMPDIR}  --logfile=${LOGFILENAME} -c "import sys; print(sys.path)"
mpi_ntasks=$(python -c "print(int(${SLURM_NTASKS}/2+1))")
echo "global env var CASAPATH=$CASAPATH"
echo "Using MPICASA to determine CASAPATH"
${MPICASA} -n ${mpi_ntasks} ${CASA} --nogui --nologger --ipython-dir=${TMPDIR} --rcdir=${TMPDIR}  --logfile=${LOGFILENAME} -c "import os; print(f'mpi inside casa CASAPATH=', os.getenv('CASAPATH'))"
echo Running command: ${MPICASA} -n ${mpi_ntasks} ${CASA} --nogui --nologger --ipython-dir=${TMPDIR} --rcdir=${TMPDIR}  --logfile=${LOGFILENAME} -c "execfile('$SCRIPT_DIR/line_imaging.py')" &
${MPICASA} -n ${mpi_ntasks} ${CASA} --nogui --nologger --ipython-dir=${TMPDIR} --rcdir=${TMPDIR}  --logfile=${LOGFILENAME} -c "execfile('$SCRIPT_DIR/line_imaging.py')" &
ppid="$!"; childPID="$(ps -C ${CASA} -o ppid=,pid= | awk -v ppid="$ppid" '$1==ppid {print $2}')"
echo PID=${ppid} childPID=${childPID}
echo "DEBUG: ps -C CASA -o ppid=,pid= : $(ps -C ${CASA} -o ppid=,pid=)"
sleep 10
date
childPID="$(ps -C ${CASA} -o ppid=,pid= | awk -v ppid="$ppid" '$1==ppid {print $2}')"
echo PID=${ppid} childPID=${childPID}
echo "DEBUG: ps -C CASA -o ppid=,pid= : $(ps -C ${CASA} -o ppid=,pid=)"
sleep 10
date
childPID="$(ps -C ${CASA} -o ppid=,pid= | awk -v ppid="$ppid" '$1==ppid {print $2}')"
echo PID=${ppid} childPID=${childPID}
echo "DEBUG: ps -C CASA -o ppid=,pid= : $(ps -C ${CASA} -o ppid=,pid=)"
date
echo "Temp drive: "
df -h /local
if [[ ! -z $childPID ]]; then 
    /orange/adamginsburg/miniconda3/bin/python ${ALMAIMF_ROOTDIR}/slurm_scripts/monitor_memory.py ${childPID}
else
    echo "FAILURE to run monitor_memory: PID=$PID was not set."
fi
wait $ppid
exitcode=$?
date
echo "Temp drive: "
df -h /local
cd -
if [[ -z $(ls -A ${TEMP_WORKDIR}) ]]; then
    rmdir -v ${TEMP_WORKDIR}
fi
exit $exitcode
