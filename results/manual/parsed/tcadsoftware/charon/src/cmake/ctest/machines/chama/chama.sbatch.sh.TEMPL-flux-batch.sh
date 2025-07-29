#!/bin/bash
#FLUX: --job-name=charon_nt
#FLUX: --urgency=16

export TRIBITS_BASE_DIR='${WORKSPACE}/TriBITS'
export TMP='${WORKSPACE}/tmp'

nodes=$SLURM_JOB_NUM_NODES           # Number of nodes - the number of nodes you have requested (for a list of SLURM environment variables see "man sbatch")
cores=16                             # Number MPI processes to run on each node (a.k.a. PPN)
CHARONROOT=${WORKSPACE}/tcad-charon
OPTARG="OPT"
PROC_COUNT=${cores}
BLDSCRIPTARG="-f chama.opts"
DONOTUPDATE=TRUE
mkdir -p ${TMP}
if [ "$#" -eq "1" ]
then
if [ "$1" = "heavy" ]
then
SITEDESC="chama heavy"
TRACK="Heavy"
LARG="^heavy$"
elif [ "$1" = "xyce" ]
then
BLDSCRIPTARG="${BLDSCRIPTARG} -f chama-with-xyce-tri-libs.opts"
SITEDESC="chama xyce coupled heavy"
TRACK="XyceCoupledHeavy"
LARG="^xycecoupledheavy$"
else
echo "ERROR: Unknown script argument(s)"
echo "  $*"
exit 1
fi
elif [ "$#" -eq "0" ]
then
SITEDESC="chama"
LARG="nightly"
TRACK=""
else
echo "ERROR: Unknown number of arguments to script!"
exit 1
fi
module purge
source /projects/sems/modulefiles/utils/sems-modules-init.sh
MODULE_LIST="intel \
cmake \
mkl \
openmpi-intel/3.0 \
sems-git"
for mod in ${MODULE_LIST}
do
module load ${mod}
done
if [ -d ${WORKSPACE}/TEST.OPT ]
then
if [ "x${WORKSPACE}" != "x" ]
then
cd ${BASETESTDIR}
if [ $? -eq 0 ]
then
rm -rf TEST.OPT
fi
else
echo "ERROR:"
echo "  WORKSPACE=${WORKSPACE}"
exit 1
fi
mkdir -p TEST.OPT
cd ${WORKSPACE}
fi
if [ "${TRACK}" = "XyceCoupledHeavy" ]
then
DONOTUPDATE=TRUE
rm -rf ${WORKSPACE}/install
mkdir ${WORKSPACE}/install
cd ${WORKSPACE}/charon-boost
./buildBoost.sh INTEL
cd ${WORKSPACE}
[[ ":${LD_LIBRARY_PATH}:" != *":${WORKSPACE}/install/lib:"* ]] && LD_LIBRARY_PATH="${WORKSPACE}/install/lib:${LD_LIBRARY_PATH}"
ctest -j${PROC_COUNT} \
-S ${CHARONROOT}/src/cmake/ctest/machines/ctest_regression.cmake \
-DDEBUGLEVEL:INT=8 \
-DTYPE:STRING=${OPTARG} \
-DTESTTRACK:STRING="${TRACK}" \
-DDISTRIB:STRING="chama" \
-DCOMPILER:STRING="MPI_INTEL_19.x" \
-DPROCESSORCOUNT:INT=${PROC_COUNT} \
-DBASETESTDIR:STRING="${WORKSPACE}" \
-DBSCRIPTARGS:STRING="${BLDSCRIPTARG}" \
-DSITEDESC:STRING="${SITEDESC}" \
-DBUILDONLY:BOOL=TRUE \
-DDONOTUPDATE:BOOL=${DONOTUPDATE}
cd ${WORKSPACE}/TEST.OPT
make -j${PROC_COUNT} install
cd ${WORKSPACE}/Xyce
${WORKSPACE}/tcad-charon/scripts/build/jenkins/xyce-conf-c2.sh
cd build
make -j16 install prefix=${WORKSPACE}/install
cd ${WORKSPACE}/Xyce/src
find . -name '*.h' -exec cp {} ${WORKSPACE}/install/include \;
cd ${WORKSPACE}/Xyce/build/src
find . -name '*.h' -exec cp {} ${WORKSPACE}/install/include \;
cd ${WORKSPACE}
BLDSCRIPTARG="-f chama.opts -f chama-with-xyce-tri-libs.opts -f chama-xyce-cluster.opts"
cd ${WORKSPACE}
rm -rf TEST.OPT
mkdir -p TEST.OPT
fi
EXTRAOPTS=""
if [ "x${OPTARG}" = "xDBG" ]
then
EXTRAOPTS="-LE debugexclude"
fi
umask 007
ctest -L ${LARG} ${EXTRAOPTS} -j${PROC_COUNT} \
-S ${CHARONROOT}/src/cmake/ctest/machines/ctest_regression.cmake \
-DDEBUGLEVEL:INT=1 \
-DTYPE:STRING=${OPTARG} \
-DTESTTRACK:STRING="${TRACK}" \
-DDISTRIB:STRING="chama" \
-DCOMPILER:STRING="MPI_INTEL_19.x" \
-DPROCESSORCOUNT:INT=${PROC_COUNT} \
-DBASETESTDIR:STRING="${WORKSPACE}" \
-DBSCRIPTARGS:STRING="${BLDSCRIPTARG}" \
-DSITEDESC:STRING="${SITEDESC}" \
-DDONOTUPDATE:BOOL=${DONOTUPDATE}
exit 0
