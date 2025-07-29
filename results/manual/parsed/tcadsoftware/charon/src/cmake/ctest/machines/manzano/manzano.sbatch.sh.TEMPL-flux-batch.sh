#!/bin/bash
#FLUX: --job-name=charon_nt
#FLUX: --urgency=16

export PYTHONPATH='/projects/charon/pythonTools:${PYTHONPATH}'
export TRIBITS_BASE_DIR='${WORKSPACE}/TriBITS'
export TMP='${WORKSPACE}/tmp'
export no_proxy='.sandia.gov'

nodes=$SLURM_JOB_NUM_NODES          # Number of nodes
cores=$(( ${nodes}*36 ))
BLDINSTDIR=${WORKSPACE}/installs
PROJINSTROOT=/projects/charon/install/attaway.jenkins
function find_install_suffix () {
local linktarg="`readlink ${PROJINSTROOT}/$1`"
local extension="${linktarg##*.}"
case "$extension" in
1)
INSTSUFFIX=2
;;
2)
INSTSUFFIX=1
;;
*)
echo "ERROR: Unknown active target"
exit 2
;;
esac
}
BLDSCRIPTARG="${BLDSCRIPTARG} --reset-option=tcad-charon_ENABLE_DAKOTA_DRIVERS:ON"
BLDSCRIPTARG="${BLDSCRIPTARG} --reset-option=tcad-charon_ENABLE_PYMESH:ON"
CHARONROOT=${WORKSPACE}/tcad-charon
BLDTYPE="OPT"
mkdir -p ${TMP}
trilinosUpdate=false
developToMaster=false
heavyTest=false
xyceTest=false
nightlyTest=false
cdeGnuBuild=false
cdeIntelBuild=false
if [ $# = 0 ]
then
nightlyTest=true
cdeGnuBuild=true
fi
while getopts "tdxhnig" opt; do
case "$opt" in
t)
trilinosUpdate=true
developToMaster=false
;;
d)
trilinosUpdate=false
developToMaster=true
;;
x)
xyceTest=true
heavyTest=false
;;
h)
xyceTest=false
heavyTest=true
;;
n)
nightlyTest=true
;;
i)
cdeIntelBuild=true
cdeGnuBuild=false
;;
g)
cdeIntelBuild=false
cdeGnuBuild=true
;;
\?)
exit 1
;;
esac
done
shift $(( $OPTIND - 1 ))
if ${heavyTest}
then
SITEDESC="manzano heavy"
TRACK="Heavy"
LARG="^heavy$"
elif ${xyceTest}
then
BLDSCRIPTARG="${BLDSCRIPTARG} -f with-xyce-tri-libs.opts"
SITEDESC="manzano Xyce Coupled heavy"
TRACK="XyceCoupled"
LARG="^xycecoupledheavy$"
else
SITEDESC="manzano"
LARG="nightly"
TRACK=""
fi
if ${trilinosUpdate}
then
SITEDESC="${SITEDESC} TrilinosUpdate"
TRACK="TrilinosUpdate"
fi
if ${developToMaster}
then
SITEDESC="${SITEDESC} DevelopToMaster"
TRACK="DevelopToMaster"
fi
. /etc/profile
module purge
module load cde/v2/cmake/3.19.2
if ${cdeIntelBuild}
then
module load cde/v2/cmake/3.19.2
module load cde/v2/compiler/intel/19.1.2
module load cde/v2/compiler/gcc/7.2.0
module load cde/v2/intel/19.1.2/openmpi/4.0.5
module load cde/v2/intel/19.1.2/intel-mkl/2020.3.279
module load cde/v2/intel/19.1.2/boost/1.73.0
module load cde/v2/intel/19.1.2/hdf5/1.10.6
module load cde/v2/intel/19.1.2/netcdf-c/4.7.3
module load cde/v2/intel/19.1.2/parallel-netcdf/1.12.1
COMPILER="CDE_V2_OpenMPI_4.0.5_Intel_19.1.2"
BLDSCRIPTARG="${BLDSCRIPTARG} -f attaway-cde-intel.opts"
ACTLINKNAME="cde.intel.active"
find_install_suffix $ACTLINKNAME
PROJINSTDIR="${PROJINSTROOT}/cde.intel.${INSTSUFFIX}"
else
module load cde/v2/cmake/3.19.2
module load cde/v2/compiler/gcc/7.2.0
module load cde/v2/gcc/7.2.0/openmpi/4.0.5
module load cde/v2/intel/19.1.2/intel-mkl/2020.3.279
module load cde/v2/gcc/7.2.0/boost/1.73.0
module load cde/v2/gcc/7.2.0/hdf5/1.10.6
module load cde/v2/gcc/7.2.0/netcdf-c/4.7.3
module load cde/v2/gcc/7.2.0/parallel-netcdf/1.12.1
COMPILER="CDE_V2_OpenMPI_4.0.5_GNU_7.2.0"
BLDSCRIPTARG="${BLDSCRIPTARG} -f attaway-cde-gnu.opts"
ACTLINKNAME="cde.gnu.active"
find_install_suffix $ACTLINKNAME
PROJINSTDIR="${PROJINSTROOT}/cde.gnu.${INSTSUFFIX}"
fi
if [ -d ${WORKSPACE}/TEST.OPT ]
then
rm -r ${WORKSPACE}/TEST.OPT
mkdir ${WORKSPACE}/TEST.OPT
fi
if [ -d ${BLDINSTDIR} ]
then
rm -r ${BLDINSTDIR}
fi
cd ${WORKSPACE}
if [ "${TRACK}" = "XyceCoupled" ]
then
ctest \
-j${cores} \
-S ${CHARONROOT}/src/cmake/ctest/machines/ctest_regression.cmake \
-DDEBUGLEVEL:INT=8 \
-DTYPE:STRING=${BLDTYPE} \
-DTESTTRACK:STRING="${TRACK}" \
-DDISTRIB:STRING="manzano" \
-DCOMPILER:STRING="${COMPILER}" \
-DPROCESSORCOUNT:INT=${cores} \
-DBASETESTDIR:STRING="${WORKSPACE}" \
-DBSCRIPTARGS:STRING="${BLDSCRIPTARG}" \
-DSITEDESC:STRING="${SITEDESC}" \
-DBUILDONLY:BOOL=TRUE \
-DINSTALLDIR:STRING="${BLDINSTDIR}/charon-for-xyce" \
-DDONOTUPDATE:BOOL=TRUE \
-DDONOTCLONE:BOOL=TRUE
cd ${WORKSPACE}/TEST.OPT
make -j${cores} install
cd ${WORKSPACE}/Xyce
rm -rf ${WORKSPACE}/Xyce/build
mkdir ${WORKSPACE}/Xyce/build
cd ${WORKSPACE}/Xyce/build
${WORKSPACE}/tcad-charon/scripts/build/charonops/xyce-for-charon-cmake.sh
make -j${cores} install
cd ${WORKSPACE}/Xyce/src
find . -follow -name '*.h' -exec cp {} ${BLDINSTDIR}/xyce-for-charon/include \;
cd ${WORKSPACE}/Xyce/build/src
find . -follow -name '*.h' -exec cp {} ${BLDINSTDIR}/xyce-for-charon/include \;
cd ${WORKSPACE}
BLDSCRIPTARG="${BLDSCRIPTARG} -f xyce-cluster.cts1.opts"
BLDINSTDIR=${PROJINSTDIR}
cd ${WORKSPACE}
rm -rf TEST.OPT
mkdir -p TEST.OPT
fi
EXTRAOPTS=""
if [ "x${BLDTYPE}" = "xDBG" ]
then
EXTRAOPTS="-LE debugexclude"
fi
umask 007
ctest \
-L ${LARG} ${EXTRAOPTS} -j${cores} \
-S ${CHARONROOT}/src/cmake/ctest/machines/ctest_regression.cmake \
-DDEBUGLEVEL:INT=8 \
-DTYPE:STRING=${BLDTYPE} \
-DTESTTRACK:STRING="${TRACK}" \
-DDISTRIB:STRING="manzano" \
-DCOMPILER:STRING="${COMPILER}" \
-DPROCESSORCOUNT:INT=${cores} \
-DBASETESTDIR:STRING="${WORKSPACE}" \
-DBSCRIPTARGS:STRING="${BLDSCRIPTARG}" \
-DSITEDESC:STRING="${SITEDESC}" \
-DINSTALLDIR:STRING="${PROJINSTDIR}" \
-DDONOTUPDATE:BOOL=TRUE \
-DDONOTCLONE:BOOL=TRUE
