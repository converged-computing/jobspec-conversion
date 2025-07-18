#!/bin/bash
#FLUX: --job-name=hybrid
#FLUX: --exclusive
#FLUX: --queue=lg
#FLUX: -t=86400
#FLUX: --urgency=16

export PATH='/home/tkaiser2/boot/opt/spack/linux-rocky8-zen2/gcc-11.2.0/git-2.35.2-4dboh5zioljmmy4q4rwdol4fwahu7k54/bin:$PATH'
export STARTDIR='`pwd`'
export MYDIR='/nopt/nrel/apps/220421a'
export TMPDIR='$MYDIR/tmp'
export SPACK_USER_CONFIG_PATH='`pwd`/.myspack  '
export CV='$(gcc -v 2>&1 | tail -1 | awk '{print $3}')'
export mpath='$(dirname $(find $MYDIR/modules -name bzip2 | tail -1))'

export PATH=/home/tkaiser2/boot/opt/spack/linux-centos7-haswell/gcc-4.8.5/cmake-3.23.1-7djsoimd5wk4tsis4v3t66jwa7evjnan/bin:$PATH
export PATH=/home/tkaiser2/boot/opt/spack/linux-centos7-haswell/gcc-4.8.5/git-2.35.1-x7xe7g4my62x6cge2c2j3mzeyf3dl6om/bin:$PATH
export PATH=/home/tkaiser2/boot/opt/spack/linux-rocky8-zen2/gcc-11.2.0/cmake-3.23.1-dscoqtpfqn7wbnwgqoevbsee7ec5clul/bin:$PATH
export PATH=/home/tkaiser2/boot/opt/spack/linux-rocky8-zen2/gcc-11.2.0/git-2.35.2-4dboh5zioljmmy4q4rwdol4fwahu7k54/bin:$PATH
export STARTDIR=`pwd`
echo $STARTDIR
export MYDIR=/nopt/nrel/apps/220421a
if [ -z "$MYDIR" ]  ;     then
    if [ -n "$BASE" ] ; then
        export MYDIR=$BASE/julia/$(date +%g%m%d)
    else
        export MYDIR=$HOME/julia/$(date +%g%m%d)
        echo WARNING: putting julia in $HOME
    fi
fi
rm -rf $MYDIR
mkdir -p $MYDIR
echo export STARTDIR=$STARTDIR
echo export MYDIR=$MYDIR
export TMPDIR=$MYDIR/tmp
mkdir -p $TMPDIR
module purge
module load python  > /dev/null 2>&1 || echo "python module not found"
mytime () 
{
    now=`date +"%s"`
    if (( $# > 0 )); then
        rtn=`python -c "print($now - $1)"`
    else
       rtn=$now
    fi
    echo $rtn
}
stamp () { date +"%y%m%d%H%M%S"; }
cp $0  $MYDIR/`stamp`.script
date
st=`mytime`
now=$st
mkdir -p myspack/level00
cd myspack/level00
rm -rf spack
git clone -c feature.manyFiles=true https://github.com/spack/spack.git  
export SPACK_USER_CONFIG_PATH=`pwd`/.myspack  
fstr='dospack () { export TMPDIR='${MYDIR}'/tmp ; export SPACK_USER_CONFIG_PATH='${STARTDIR}'/myspack/level00/.myspack ; source '${STARTDIR}'/myspack/level00/spack/share/spack/setup-env.sh ; }' ; eval $fstr
echo Settings:
echo To restart spack to add more packages create this function and run it.
echo Then just do a spack install.
declare -f dospack
declare -f dospack > dospack.func
egrep "^STARTDIR|^MYDIR" | sed "s/^/export /" > dirsettings
dospack
ml gcc  > /dev/null 2>&1 || echo "no gcc module"
spack compiler find
backup=`date +"%y%m%d%H%M%S"`
sed -i$backup "s,root: \$spack,root: $MYDIR/install," spack/etc/spack/defaults/config.yaml
sed -i$backup "s,\$spack/share/spack,$MYDIR/modules," spack/etc/spack/defaults/modules.yaml
sed -ib "s/- tcl/- lmod/"                             spack/etc/spack/defaults/modules.yaml
echo Time to setup spack: $(mytime $now)
now=`mytime`
export CV=$(gcc -v 2>&1 | tail -1 | awk '{print $3}')
spack install gcc
echo Time to install gcc: $(mytime $now)
export mpath=$(dirname $(find $MYDIR/modules -name bzip2 | tail -1))
module use $mpath
ml gcc
spack compiler find
clist=`spack compiler list | grep @`
for c in $clist ; do if [[ ${c} != *"11"* ]];then spack compiler remove $c ; fi; done
now=`mytime`
spack install gcc
echo Time to install gcc: $(mytime $now)
now=`mytime`
spack install nvhpc@22.2 +blas +mpi +lapack
echo Time to install nvhpc: $(mytime $now)
now=`mytime`
spack install fftw -mpi
echo Time to install fftw: $(mytime $now)
now=`mytime`
spack install intel-oneapi-compilers
spack install intel-oneapi-mpi intel-oneapi-ccl  intel-oneapi-dal intel-oneapi-dnn intel-oneapi-ipp intel-oneapi-ippcp intel-oneapi-mkl intel-oneapi-tbb intel-oneapi-vpl
echo Time to install intel: $(mytime $now)
now=`mytime`
spack install git
spack install gmake
spack install cmake
echo Time to install tools: $(mytime $now)
if [[ ! -d myrepo ]];then
  spack repo create myrepo
  #spack repo add $NOWDIR/myrepo
  spack repo add myrepo
fi
mkdir -p myrepo/packages/julia
cp $STARTDIR/julia.py  myrepo/packages/julia/package.py
now=`mytime`
spack install julia
echo Time to install julia: $(mytime $now)
LMODDIR=$(dirname $(find $MYDIR/modules/lmod -name "julia*"))
echo "To enable your modules add the following to your .bashrc file or source it"
echo module use $LMODDIR
module use $LMODDIR
module unload gcc
module load julia
which julia
now=`mytime`
module load gcc
spack install python@3.10.2 +tkinter
echo Time to install python: $(mytime $now)
module load python
which python
python -m pip install update
python -m pip install --upgrade pip
which pip3
pip3 install matplotlib
pip3 install pandas
pip3 install scipy
pip3 install jupyterlab
pip3 install reframe-hpc
pip3 install pygelf
echo Time to install python extras: $(mytime $now)
now=`mytime`
spack install r
echo Time to install R: $(mytime $now)
echo Total time: $(mytime $st)
