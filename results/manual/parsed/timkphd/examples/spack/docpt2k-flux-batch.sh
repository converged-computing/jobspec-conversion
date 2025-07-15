#!/bin/bash
#FLUX: --job-name="buildstuff"
#FLUX: --exclusive
#FLUX: -t=14400
#FLUX: --priority=16

export STARTDIR='`pwd`'
export MDY='`date +%m%d%y_$LETTER`'
export MYDIR='/projects/hpcapps/cpt2k/${MDY}'
export SPACK_ROOT='`pwd`'
export SPACK_USER_CONFIG_PATH='${SPACK_ROOT}/.spack'
export SPACK_USER_CACHE_PATH='${SPACK_ROOT}/.cache'
export TMPDIR='$SPACK_ROOT/tmp'
export BASE='$MYDIR'
export PATH='/opt/rh/gcc-toolset-12/root/usr/bin:$PATH'
export IPATH='$BASE'

export STARTDIR=`pwd`
echo $STARTDIR
if [ -z "$LETTER" ]  ; then export LETTER=a ;fi
export MDY=`date +%m%d%y_$LETTER`
export MYDIR=/projects/hpcapps/cpt2k/${MDY}
echo $MYDIR
rm -rf $MYDIR
rm -rf $MDY
mkdir -p $MYDIR
printenv > $MYDIR/env
cat $0 > $MYDIR/build_script
mytime () 
{
    now=`date +"%s"`
    if (( $# > 0 )); then
        rtn=`python3 -c "print($now - $1)"`
    else
       rtn=$now
    fi
    echo $rtn
}
date
st=`mytime`
now=$st
module purge
ml craype-x86-spr
ml gcc-native
ml git
rm -rf $MDY
mkdir $MDY
cd $MDY
wget https://raw.githubusercontent.com/timkphd/examples/master/tims_tools/setinstall
chmod 755 setinstall
git clone                           https://github.com/spack/spack.git  
cd spack
export SPACK_ROOT=`pwd`
export SPACK_USER_CONFIG_PATH=${SPACK_ROOT}/.spack
export SPACK_USER_CACHE_PATH=${SPACK_ROOT}/.cache
export TMPDIR=$SPACK_ROOT/tmp
mkdir -p $TMPDIR
../setinstall `realpath -P etc/spack/defaults` `realpath $MYDIR`
source share/spack/setup-env.sh
for pack in intel-oneapi-mkl intel-oneapi-compilers intel-oneapi-mpi  ; do
  echo $pack
  spack spec $pack
done
for pack in intel-oneapi-mkl intel-oneapi-compilers intel-oneapi-mpi  ; do
  echo $pack
  now=`mytime`
  #spack install --no-check-signature --no-checksum $pack arch=skylake_avx512
  spack install --no-check-signature --no-checksum $pack 
  echo Time to install $pack: $(mytime $now)
done
echo \$STARTDIR=$STARTDIR
echo \$SPACK_ROOT=$SPACK_ROOT
echo Install directory \$MYDIR=$MYDIR
echo export SPACK_ROOT=$SPACK_ROOT
echo export SPACK_USER_CONFIG_PATH=$SPACK_ROOT/.spack
echo export SPACK_USER_CACHE_PATH=$SPACK_ROOT/.cache
echo export TMPDIR=$SPACK_ROOT/tmp
echo source $SPACK_ROOT/share/spack/setup-env.sh
cd $STARTDIR
echo "modules in:"
BASE=$MYDIR
for KIND in lmod  ; do
for x in `find $BASE/$KIND -type f` ; do dirname `dirname $x` ; done | sort -u | grep $KIND
done
for KIND in  tcl ; do
for x in `find $BASE/$KIND -type f` ; do dirname $x ; done | sort -u | grep $KIND
done
export BASE=$MYDIR
unset spack
module purge
module use $BASE/lmod/linux-rhel8-x86_64/gcc/*
ml intel-oneapi-compilers
ml intel-oneapi-mkl
ml intel-oneapi-mpi
ml git
export PATH=/opt/rh/gcc-toolset-12/root/usr/bin:$PATH
export IPATH=$BASE
mkdir -p $IPATH
cd $IPATH
git clone https://github.com/cp2k/cp2k.git
cd cp2k/tools/toolchain
./install_cp2k_toolchain.sh --with-mkl --with-scalapack --with-cosma=no --with-intelmpi --enable-cray=no   --with-intel --with-fftw
cp $IPATH/cp2k/tools/toolchain/install/arch/* $IPATH/cp2k/arch
source $IPATH/cp2k/tools/toolchain/install/setup
cd $IPATH/cp2k
git submodule update --init --recursive
make -j 26  ARCH=local VERSION="ssmp sdbg psmp pdbg"
echo Install Directory $IPATH/cp2k
echo Module path for Intel compilers: `echo $MODULEPATH | awk -F: '{print $1}'`
echo loaded modules:
module list
