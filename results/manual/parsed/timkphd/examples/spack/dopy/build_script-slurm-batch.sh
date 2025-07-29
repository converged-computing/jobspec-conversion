#!/bin/bash
#FLUX: --job-name=buildpython
#FLUX: --exclusive
#FLUX: -t=14400
#FLUX: --urgency=16

export MDY='`date +%m%d%y_$LETTER`'
export MYDIR='/nopt/nrel/apps/pythons/${MDY}'
export SPACK_ROOT='`pwd`'
export SPACK_USER_CONFIG_PATH='${SPACK_ROOT}/.spack'
export SPACK_USER_CACHE_PATH='${SPACK_ROOT}/.cache'
export TMPDIR='$SPACK_ROOT/tmp'

source /nopt/nrel/apps/env.sh || echo no /nopt/nrel/apps/env.sh
which git 2> /dev/null ; if [ $? -ne 0 ] ; then module load git ; fi
cd `realpath -P .`
STARTDIR=`pwd`
echo $STARTDIR
if [ -z "$LETTER" ]  ; then export LETTER=a ;fi
export MDY=`date +%m%d%y_$LETTER`
export MYDIR=/nopt/nrel/apps/pythons/${MDY}
echo $MYDIR
rm -rf $MYDIR
rm -rf $MDY
mkdir -p $MYDIR
cat $STARTDIR/build_script > $MYDIR/build_script
cp setinstall $MYDIR
cp pipit $MYDIR
printenv > $MYDIR/env
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
rm -rf $MDY
mkdir $MDY
cd $MDY
git clone -c feature.manyFiles=true https://github.com/spack/spack.git  
cd spack
export SPACK_ROOT=`pwd`
export SPACK_USER_CONFIG_PATH=${SPACK_ROOT}/.spack
export SPACK_USER_CACHE_PATH=${SPACK_ROOT}/.cache
export TMPDIR=$SPACK_ROOT/tmp
mkdir -p $TMPDIR
$STARTDIR/setinstall `realpath -P etc/spack/defaults` `realpath $MYDIR`
source share/spack/setup-env.sh
module load PrgEnv-cray/8.3.3 2> /dev/null || echo no PrgEnv-cray
module load gcc/12.1.0
which gcc
spack compiler find
for pack in "python@3.9.0 +tkinter" "python@3.11.2 +tkinter" "python@3.9.0 +tkinter" "python@3.11.2 +tkinter" ; do
echo $pack
now=`mytime`
spack install $pack
echo Time to install $pack: $(mytime $now)
done
echo \$STARTDIR=$STARTDIR
echo \$SPACK_ROOT=$SPACK_ROOT
echo Install directory \$MYDIR=$MYDIR
cd $STARTDIR
echo "modules in:"
BASE=$MYDIR
for KIND in lmod  ; do
for x in `find $BASE/$KIND -type f` ; do dirname `dirname $x` ; done | sort -u | grep $KIND
done
for KIND in  tcl ; do
for x in `find $BASE/$KIND -type f` ; do dirname $x ; done | sort -u | grep $KIND
done
