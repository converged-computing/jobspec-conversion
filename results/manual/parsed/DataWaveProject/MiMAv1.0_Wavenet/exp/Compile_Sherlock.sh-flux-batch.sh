#!/bin/bash
#FLUX: --job-name=mima-compile
#FLUX: --urgency=16

export LD='${FC}'
export CC_SPP='${CC}'
export MPIFC='${MPIF90}'
export FC='${MPIFC}'
export CXX='${MPICXX}'
export CC='${MPICC}'
export FFLAGS='${DEBUG} ${OPT} ${MIMA_CONFIG_FFLAGS} '
export CFLAGS='${MIMA_CONFIG_CFLAGS}'
export LDFLAGS='${MIMA_CONFIG_LDFLAGS}'
export cppDefs='-Duse_libMPI -Duse_netCDF -DgFortran'

ulimit -s unlimited
. /home/groups/s-ees/share/cees/spack_cees/scripts/cees_sw_setup-beta.sh
module purge
CEES_MODULE_SUFFIX="cees-beta"
COMP="intel"
MPI="mpich"
module load devel gcc/10.
module load intel-${CEES_MODULE_SUFFIX}
export LD=${FC}
export CC_SPP=${CC}
module load mpich-${CEES_MODULE_SUFFIX}/
MPI_ROOT=$(dirname $(dirname ${MPICC}))
MPI_FFLAGS="`pkg-config --cflags ${MPI_ROOT}/lib/pkgconfig/mpich.pc` -I${MPI_ROOT}/lib "
MPI_CFLAGS="`pkg-config --cflags ${MPI_ROOT}/lib/pkgconfig/mpich.pc`"
MPI_LDFLAGS="`pkg-config --libs ${MPI_ROOT}/lib/pkgconfig/mpich.pc` -lmpifort "
export MPIFC=${MPIF90}
export FC=${MPIFC}
export CXX=${MPICXX}
export CC=${MPICC}
module load netcdf-c-${CEES_MODULE_SUFFIX}/
module load netcdf-fortran-${CEES_MODULE_SUFFIX}/
module list
echo "Compilers: "
echo "** CC: $CC"
echo "** CXX: $CXX"
echo "** FC: $FC"
echo "** MPICC: $MPICC"
echo "** MPICXX: $MPICXX"
echo "** MPIFC: $MPIFC"
MIMA_CONFIG_FFLAGS=" -i4 -r8 -g ${MPI_FFLAGS} `nf-config --fflags` `nc-config --fflags`  `nc-config --cflags` -cpp"
MIMA_CONFIG_CFLAGS=" -g ${MPI_CFLAGS} `nc-config --cflags` `nf-config --cflags` "
MIMA_CONFIG_LDFLAGS=" -shared-intel  ${MPI_LDFLAGS} `nf-config --flibs` `nc-config --libs` `python3-config --ldflags --embed` "
DEBUG=""
OPT="-O2"
export FFLAGS="${DEBUG} ${OPT} ${MIMA_CONFIG_FFLAGS} "
export CFLAGS=${MIMA_CONFIG_CFLAGS}
export LDFLAGS=${MIMA_CONFIG_LDFLAGS}
cwd=`pwd`
if [[ -z ${SLURM_NTASKS} ]]; then
    MIMA_NPES=8
else
    MIMA_NPES=${SLURM_NTASKS}
fi
echo "Compile on N=${MIMA_NPES} process"
VER="1.0.1"
DO_MODULE=0
MODULE_PATH="/share/cees/modules/moduledeps/${COMP}-${MPI}/MiMA"
MIMA_ROOT_PATH=`cd ..;pwd`
platform="Sherlock"
template="`pwd`/mkmf.template.$platform"
mkmf="${MIMA_ROOT_PATH}/bin/mkmf"                           # path to executable mkmf
sourcedir="${MIMA_ROOT_PATH}/src"                           # path to directory containing model source code
mppnccombine="${MIMA_ROOT_PATH}/bin/mppnccombine.$platform" # path to executable mppnccombine
execdir="${cwd}/exec.$platform"       # where code is compiled and executable is created
workdir="${cwd}/workdir"              # where model is run and model output is produced
pathnames="${cwd}/path_names"           # path to file containing list of source paths
namelist="${cwd}/namelists"            # path to namelist file
diagtable="${cwd}/diag_table"           # path to diagnositics table
fieldtable="${cwd}/field_table"         # path to field table (specifies tracers)
if [[ ! -f ${template} ]] ; then touch ${template}; fi
echo "*** compile step..."
rm ${mppnccombine}
if [[ ! -f "${mppnccombine}" ]]; then
  #icc -O -o $mppnccombine -I$NETCDF_INC -L$NETCDF_LIB ${cwd}/../postprocessing/mppnccombine.c -lnetcdf
  # NOTE: this can be problematic if the SPP and MPI CC compilers get mixed up. this program often requires the spp compiler.
   ${CC_SPP} -O -o ${mppnccombine} -I${NETCDF_INC} -I${NETCDF_FORTRAN_INC} -I{HDF5_INC} -L${NETCDF_LIB} -L${NETCDF_FORTRAN_LIB} -L{HDF5_LIB}  -lnetcdf -lnetcdff ${cwd}/../postprocessing/mppnccombine.c
else
    echo "${mppnccombine} exists?"
fi
if [[ ! $? = 0 ]]; then
    echo "Something Broke! after mppnccombine..."
fi
echo "*** set up directory structure..."
if [[ -d ${execdir} ]]; then rm -rf ${execdir}; fi
if [[ ! -d "${execdir}" ]]; then mkdir -p ${execdir}; fi
if [[ -e "${workdir}" ]]; then
  #echo "ERROR: Existing workdir may contaminate run. Move or remove $workdir and try again."
  #exit 1
  rm -rf ${workdir}
  mkdir -p ${workdir}
fi
echo "**"
echo "*** compile the model code and create executable"
cd ${execdir}
if [[ ! $? = 0 ]]; then
    echo "Something Broke! after execdir..."
fi
export cppDefs="-Duse_libMPI -Duse_netCDF -DgFortran"
${mkmf} -p mima.x -t $template -c "${cppDefs}" -a $sourcedir $pathnames ${NETCDF_INC} ${NETCDF_LIB} ${NETCDF_FORTRAN_INC} ${NETCDF_FORTRAN_LIB} ${HDF5_INC} ${HDF5_LIB} ${MPI_DIR}/include ${MPI_DIR}/lib $sourcedir/shared/mpp/include $sourcedir/shared/include
echo "Compilers: "
echo "** CC: $CC"
echo "** CXX: $CXX"
echo "** FC: $FC"
echo "** MPICC: $MPICC"
echo "** MPICXX: $MPICXX"
echo "** MPIFC: $MPIFC"
make clean
make -f Makefile -j${MIMA_NPES}
if [[ ! $? -eq 0 ]]; then
  echo "*** Error during make."
fi
echo "Exiting intentionally after make "
