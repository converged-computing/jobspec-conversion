#!/bin/bash
#FLUX: --job-name=hybrid
#FLUX: --exclusive
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

export STARTDIR='`pwd`'
export MYDIR='$STARTDIR/nopt'
export SPACK_USER_CONFIG_PATH='$STARTDIR/.myspack '
export BOOT='$STARTDIR/.spack_boot'

module use /nopt/nrel/apps/boot/base/nopt/modules/lmod/linux-rocky8-x86_64/Core
module load gcc
module load python
module unload openssl
mkdir base 
cd base
rm -rf spack
git clone -c feature.manyFiles=true https://github.com/spack/spack.git  
export STARTDIR=`pwd`
export MYDIR=$STARTDIR/nopt
mkdir $MYDIR
export SPACK_USER_CONFIG_PATH=$STARTDIR/.myspack 
export BOOT=$STARTDIR/.spack_boot
fstr='dospack () {  export SPACK_USER_CONFIG_PATH='${STARTDIR}'/.myspack ; source '${STARTDIR}'/spack/share/spack/setup-env.sh ; spack bootstrap root --scope defaults '${BOOT}' ; }' ; eval $fstr
echo $fstr > dospack.func
backup=`date +"%y%m%d%H%M%S"`
sed -i$backup "s,root: \$spack,root: $MYDIR/install," spack/etc/spack/defaults/config.yaml
sed -i$backup "s,\$spack/share/spack,$MYDIR/modules," spack/etc/spack/defaults/modules.yaml
sed -ib "s/- tcl/- lmod/"                             spack/etc/spack/defaults/modules.yaml
dospack
spack install wget
spack install gcc@11.3.0
spack install python@3.9.12
spack install python@3.10.4
