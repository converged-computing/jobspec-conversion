#!/bin/bash
#FLUX: --job-name=cowy-peanut-butter-3599
#FLUX: -n=24
#FLUX: --queue=serc
#FLUX: -t=10800
#FLUX: --priority=16

export PKG_CONFIG_PATH='$PKG_CONFIG_PATH:MPICC_DIR_PKG_CONFIG '
export CPATH='${INCLUDE}:${CPATH}'
export NETCDF_FORTRAN_INC='/home/groups/s-ees/share/cees/spack_cees/spack/opt/spack/linux-centos7-zen2/intel-2021.4.0/netcdf-fortran-4.5.3-yeufglyxxhffrzdfwvumi6wzvspa2qph/include'
export NETCDF_FORTRAN_LIB='/home/groups/s-ees/share/cees/spack_cees/spack/opt/spack/linux-centos7-zen2/intel-2021.4.0/netcdf-fortran-4.5.3-yeufglyxxhffrzdfwvumi6wzvspa2qph/lib'
export NETCDF_INC='/home/groups/s-ees/share/cees/spack_cees/spack/opt/spack/linux-centos7-zen2/intel-2021.4.0/netcdf-c-4.7.4-soivf6s6cbpkn5faaxq7shvomz6vnpp5/include'
export NETCDF_LIB='/home/groups/s-ees/share/cees/spack_cees/spack/opt/spack/linux-centos7-zen2/intel-2021.4.0/netcdf-c-4.7.4-soivf6s6cbpkn5faaxq7shvomz6vnpp5/lib'
export HDF5_INC='/home/groups/s-ees/share/cees/spack_cees/spack/opt/spack/linux-centos7-zen2/intel-2021.4.0/hdf5-1.10.7-wtwsbe7dqdc6coehdom6hlufplcudfdf/include'
export HDF5_LIB='/home/groups/s-ees/share/cees/spack_cees/spack/opt/spack/linux-centos7-zen2/intel-2021.4.0/hdf5-1.10.7-wtwsbe7dqdc6coehdom6hlufplcudfdf/lib'
export MIMA_CONFIG_FFLAGS='`nf-config --cflags` `pkg-config --cflags mpich` -I${HDF5_INC} -I${HDF5_LIB} -I${NETCDF_FORTRAN_LIB} -I${NETCDF_LIB} '
export MIMA_CONFIG_CFLAGS='`nc-config --cflags` `pkg-config --cflags mpich` '
export MIMA_CONFIG_LDFLAGS=' -shared-intel `python3-config --ldflags` `nf-config --flibs` `pkg-config --libs mpich`'

module purge
module unuse /usr/local/modulefiles
. /home/groups/s-ees/share/cees/spack_cees/scripts/cees_sw_setup-beta.sh
module --ignore-cache load intel-cees-beta/2021.4.0
  #Load MPICH
module load mpich-cees-beta
  #Load the C and Fortran versions of NetCDF
module load netcdf-c-cees-beta netcdf-fortran-cees-beta
module load hdf5-cees-beta
  # Point to where the MPICH pkgconfig is, found via module show <mpich module name>
MPICC_DIR=/home/groups/s-ees/share/cees/spack_cees/spack/opt/spack/linux-centos7-zen2/intel-2021.4.0/mpich-3.4.2-bq6mpcfiujv2lkq7dtt2bzbejvglysiu
MPICC_DIR_PKG_CONFIG=$MPICC_DIR/lib/pkgconfig
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:MPICC_DIR_PKG_CONFIG 
export CPATH=${INCLUDE}:${CPATH}
CC_SPP=${CC}
export NETCDF_FORTRAN_INC=/home/groups/s-ees/share/cees/spack_cees/spack/opt/spack/linux-centos7-zen2/intel-2021.4.0/netcdf-fortran-4.5.3-yeufglyxxhffrzdfwvumi6wzvspa2qph/include
export NETCDF_FORTRAN_LIB=/home/groups/s-ees/share/cees/spack_cees/spack/opt/spack/linux-centos7-zen2/intel-2021.4.0/netcdf-fortran-4.5.3-yeufglyxxhffrzdfwvumi6wzvspa2qph/lib
export NETCDF_INC=/home/groups/s-ees/share/cees/spack_cees/spack/opt/spack/linux-centos7-zen2/intel-2021.4.0/netcdf-c-4.7.4-soivf6s6cbpkn5faaxq7shvomz6vnpp5/include
export NETCDF_LIB=/home/groups/s-ees/share/cees/spack_cees/spack/opt/spack/linux-centos7-zen2/intel-2021.4.0/netcdf-c-4.7.4-soivf6s6cbpkn5faaxq7shvomz6vnpp5/lib
export HDF5_INC=/home/groups/s-ees/share/cees/spack_cees/spack/opt/spack/linux-centos7-zen2/intel-2021.4.0/hdf5-1.10.7-wtwsbe7dqdc6coehdom6hlufplcudfdf/include
export HDF5_LIB=/home/groups/s-ees/share/cees/spack_cees/spack/opt/spack/linux-centos7-zen2/intel-2021.4.0/hdf5-1.10.7-wtwsbe7dqdc6coehdom6hlufplcudfdf/lib
export MIMA_CONFIG_FFLAGS="`nf-config --cflags` `pkg-config --cflags mpich` -I${HDF5_INC} -I${HDF5_LIB} -I${NETCDF_FORTRAN_LIB} -I${NETCDF_LIB} "
export MIMA_CONFIG_CFLAGS="`nc-config --cflags` `pkg-config --cflags mpich` "
export MIMA_CONFIG_LDFLAGS=" -shared-intel `python3-config --ldflags` `nf-config --flibs` `pkg-config --libs mpich`"
echo "*** ** *** ldflags: ${MIMA_CONFIG_LDFLAGS}"
cwd=`pwd`
echo "MIMA_CONFIG_FFLAGS: ${MIMA_CONFIG_FFLAGS}"
echo "MIMA_CONFIG_CFLAGS: ${MIMA_CONFIG_CFLAGS}"
echo "MIMA_CONFIG_LDFLAGS: ${MIMA_CONFIG_LDFLAGS}"
if [[ -z ${SLURM_NTASKS} ]]; then
    MIMA_NPES=8
else
    MIMA_NPES=${SLURM_NTASKS}
fi
echo "Compile on N=${MIMA_NPES} process"
platform="Sherlock"
template="`pwd`/mkmf.template.$platform"    # path to template for your platform
mkmf="`cd ../bin;pwd`/mkmf"                           # path to executable mkmf
sourcedir="`cd ../src;pwd`"                           # path to directory containing model source code
mppnccombine="`cd ../bin;pwd`/mppnccombine.$platform" # path to executable mppnccombine
execdir="${cwd}/exec.$platform"       # where code is compiled and executable is created
workdir="${cwd}/workdir"              # where model is run and model output is produced
pathnames="${cwd}/path_names"           # path to file containing list of source paths
diagtable="${cwd}/diag_table"           # path to diagnositics table
fieldtable="${cwd}/field_table"         # path to field table (specifies tracers)
echo "${template}"
echo "**"
echo "*** compile step..."
rm ${mppnccombine}
if [[ ! -f "${mppnccombine}" ]]; then
  #icc -O -o $mppnccombine -I$NETCDF_INC -L$NETCDF_LIB ${cwd}/../postprocessing/mppnccombine.c -lnetcdf
  # NOTE: this can be problematic if the SPP and MPI CC compilers get mixed up. this program often requires the spp compiler.
   ${CC_SPP} -O -o ${mppnccombine} -I${NETCDF_INC} -I${NETCDF_FORTRAN_INC} -I{HDF5_INC} -L${NETCDF_LIB} -L${NETCDF_FORTRAN_LIB} -L{HDF5_LIB}  -lnetcdf -lnetcdff ${cwd}/../postprocessing/mppnccombine.c
else
    echo "${mppnccombine} exists?"
fi
echo "*** set up directory structure..."
if [[ -d ${execdir} ]]; then rm -rf ${execdir}; fi
if [[ ! -d "${execdir}" ]]; then mkdir ${execdir}; fi
if [[ -e "${workdir}" ]]; then
  #echo "ERROR: Existing workdir may contaminate run. Move or remove $workdir and try again."
  #exit 1
  rm -rf ${workdir}
  mkdir ${workdir}
fi
echo "**"
echo "*** compile the model code and create executable"
cd ${execdir}
cppDefs="-Duse_libMPI -Duse_netCDF -DgFortran"
${mkmf} -p mima.x -t $template -c "${cppDefs}" -a $sourcedir $pathnames ${NETCDF_INC} ${NETCDF_LIB} ${NETCDF_FORTRAN_INC} ${NETCDF_FORTRAN_LIB} ${HDF5_INC} ${HDF5_LIB} ${MPICC_DIR}/include ${MPICC_DIR}/lib $sourcedir/shared/mpp/include $sourcedir/shared/include
make clean
echo "*** do live compile... (`pwd`)"
make -f Makefile -j${MIMA_NPES}
