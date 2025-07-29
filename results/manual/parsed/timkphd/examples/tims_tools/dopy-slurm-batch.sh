#!/bin/bash
#FLUX: --job-name=buildpython
#FLUX: --exclusive
#FLUX: --queue=debug
#FLUX: -t=3600
#FLUX: --urgency=16

export LETTER='t'
export MDY='`date +%m%d%y_$LETTER`'
export BIRD='${BASED}/${MDY}'
export SPACK_ROOT='`pwd`'
export SPACK_USER_CONFIG_PATH='${SPACK_ROOT}/.spack'
export SPACK_USER_CACHE_PATH='${SPACK_ROOT}/.cache'
export TMPDIR='$SPACK_ROOT/tmp'
export NEWPY='mypie'
export NEWDIR='`pwd`'
export CC='mpiicc'
export HDF5_MPI='ON'
export HDF5_DIR='/nopt/nrel/apps/hdf5/1.12.0-intel-impi'

which git 2> /dev/null || ml git
mytime () 
{ 
    now=`date +"%s.%N"`;
    if (( $# > 0 )); then
        rtn=$(printf "%0.3f" `echo $now - $1 | bc`);
    else
        rtn=$(printf "%0.3f" `echo $now`);
    fi;
    echo $rtn
}
cd `realpath -P .`
STARTDIR=`pwd`
echo $STARTDIR
export LETTER=t
if [ -z "$LETTER" ]  ; then export LETTER=a;fi
export MDY=`date +%m%d%y_$LETTER`
BASED=/kfs2/projects/hpcapps/pythons
if [ -z "$BASED" ]  ; then export BASED=/lustre/eaglefs/scratch/tkaiser2/shared/python ;fi
export BIRD=${BASED}/${MDY}
echo $BIRD
echo $MDY
rm -rf $BIRD
rm -rf $MDY
mkdir -p $BIRD
mkdir $MDY
ls setinstall 2>/dev/null || wget https://raw.githubusercontent.com/timkphd/examples/master/tims_tools/setinstall
chmod 755 setinstall
ls tkinter 2>/dev/null    || wget https://raw.githubusercontent.com/timkphd/examples/master/tims_tools/tkinter
cat $0 > $BIRD/build_script
cp setinstall $BIRD
printenv > $BIRD/env
cat $0 > $MDY/build_script
cp setinstall $MDY
printenv > $MDY/env
st=`mytime`
now=$st
cd $MDY
git clone https://github.com/spack/spack.git  
cd spack
export SPACK_ROOT=`pwd`
export SPACK_USER_CONFIG_PATH=${SPACK_ROOT}/.spack
export SPACK_USER_CACHE_PATH=${SPACK_ROOT}/.cache
export TMPDIR=$SPACK_ROOT/tmp
mkdir -p $TMPDIR
$STARTDIR/setinstall `realpath -P etc/spack/defaults` `realpath $BIRD`
source $STARTDIR/tkinter || echo tkinter patch not installed
source share/spack/setup-env.sh
ml gcc
ml python
ml gmake
spack compiler find
spack external find sqlite
spack info python
for pack in  "python@3.11.7 +tkinter" "python@3.12.1 +tkinter"  ; do
echo installing $pack
now=`mytime`
spack install $pack
echo Time to install $pack: $(mytime $now)
done
echo export STARTDIR=$STARTDIR
echo export SPACK_ROOT=$SPACK_ROOT
echo export SPACK_USER_CONFIG_PATH=$SPACK_ROOT/.spack
echo export SPACK_USER_CACHE_PATH=$SPACK_ROOT/.cache
echo export TMPDIR=$SPACK_ROOT/tmp
echo source $SPACK_ROOT/share/spack/setup-env.sh
echo Install directory \$BIRD=$BIRD
cd $STARTDIR
echo "modules in:"
BASE=$BIRD
LDIR=$(for x in `find $BASE/lmod -type f` ; do dirname `dirname $x` ; done | sort -u | grep lmod)
echo $LDIR
module use $LDIR
ml python
which python 
pipit() {
rm -rf get-pip.py
wget  https://bootstrap.pypa.io/get-pip.py
which python
python get-pip.py
pip install --upgrade  --no-cache-dir pip
pip3 install  --no-cache-dir matplotlib
pip3 install  --no-cache-dir pyarrow
pip3 install  --no-cache-dir pandas
pip3 install  --no-cache-dir scipy
pip3 install  --no-cache-dir jupyterlab
pip3 install  --no-cache-dir reframe-hpc
}
pipit
export NEWPY=mypie
export NEWDIR=`pwd`
rm -rf $NEWDIR/$NEWPY
python -m venv  $NEWDIR/$NEWPY
source  $NEWDIR/$NEWPY/bin/activate
which python
pipit
pip install --no-cache-dir mpi4py
: << SKIP
ml hdf5/1.12.0/intel-impi
export CC=mpiicc
export HDF5_MPI="ON"
export HDF5_DIR=/nopt/nrel/apps/hdf5/1.12.0-intel-impi
pip install  --no-cache-dir --no-binary=h5py h5py
SKIP
echo to use your new python:
echo source $NEWDIR/$NEWPY/bin/activate
