#!/bin/bash
#FLUX: --job-name=petscinstall
#FLUX: -n=12
#FLUX: --queue=normal
#FLUX: -t=60
#FLUX: --urgency=16

set -eu
rm -rf install petsc-3.6.3 src
mkdir install src
$ISSM_DIR/scripts/DownloadExternalPackage.py 'http://issm.jpl.nasa.gov/files/externalpackages/petsc-lite-3.6.3.tar.gz' 'petsc-3.6.3.tar.gz'
tar -zxvf  petsc-3.6.3.tar.gz
mv petsc-3.6.3/* src/
rm -rf petsc-3.6.3
cd src
./config/configure.py \
	--prefix="$ISSM_DIR/externalpackages/petsc/install" \
	--PETSC_DIR="$ISSM_DIR/externalpackages/petsc/src" \
	--with-blas-lapack-dir="$TACC_MKL_LIB" \
	--with-mpi-lib="/opt/cray/mpt/default/gni/mpich-intel/14.0/lib/libmpich.so" \
	--with-mpi-include="/opt/cray/mpt/default/gni/mpich-intel/14.0/include" \
	--known-mpi-shared-libraries=1 \
	--with-debugging=0 \
	--with-valgrind=0 \
	--with-x=0 \
	--with-ssl=0 \
	--with-batch=1  \
	--with-shared-libraries=1 \
	--download-metis=1 \
	--download-parmetis=1 \
	--download-mumps=1 \
	--download-scalapack=1 
cat > script.queue << EOF
set -x # Echo commands, use set echo with csh
ibrun -np 1 ./conftest-arch-linux2-c-opt
EOF
echo "== Now: cd src/ "
echo "== sbatch script.queue "
echo "== Then run reconfigure script generated by PETSc and follow instructions"
