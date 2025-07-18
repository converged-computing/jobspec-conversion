#!/bin/bash
#FLUX: --job-name=adorable-mango-8630
#FLUX: -c=8
#FLUX: -t=3600
#FLUX: --urgency=16

reponame="lammps"
repo="git@github.com:CTCMS-UQ/${reponame}.git"
checkout="sprint-develop"
dir="lammps-mulan-fftsingle-cpu"
group="sprint4"
umask 007
echo BUILD-START $( date )
module unload gcc/9.3.0
rm -fr $dir
mkdir -p $dir
cd $dir
git clone $repo
cd $reponame
git checkout $checkout
cd src
sed -e 's/KOKKOS_DEVICES *=.*/KOKKOS_DEVICES = OpenMP,Serial\
KOKKOS_ARCH = ZEN2/' \
    -e 's/CC *=.*/CC = CC/g' \
    -e 's/LINK *=.*/LINK = CC/g' \
	-e 's/FFT_INC *=.*/FFT_INC = -DFFT_SINGLE/g' \
    -e '/MPI_INC *=/ s;$; -I${MPICH_DIR}/include;g' \
    -e '/MPI_LIB *=/ s;$; -L${MPICH_DIR}/lib -lmpi -L${CRAY_MPICH_ROOTDIR}/gtl/lib -lmpi_gtl_hsa;g' \
    MAKE/OPTIONS/Makefile.kokkos_mpi_only >MAKE/Makefile.mulan_cpu
sed -i '/KOKKOS_LIBS *+= *-latomic/ s/^/#/g' ../lib/kokkos/Makefile.kokkos
make yes-CLASS2
make yes-MANYBODY
make yes-MISC
make yes-EXTRA-COMPUTE
make yes-EXTRA-DUMP
make yes-EXTRA-FIX
make yes-KSPACE
make yes-MOLECULE
make yes-RIGID
make yes-MOLFILE
make yes-UEF
make yes-MOL-SLLOD
make yes-KOKKOS
sg $group -c 'make -j 8 mulan_cpu'
echo BUILD-END $( date )
