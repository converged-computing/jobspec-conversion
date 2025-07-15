#!/bin/bash
#FLUX: --job-name="hybrid"
#FLUX: --exclusive
#FLUX: -t=14400
#FLUX: --priority=16

export TMPDIR='$MYDIR/tmp'
export SPACK_USER_CONFIG_PATH='`pwd`/.myspack  '

STARTDIR=`pwd`
echo $STARTDIR
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
export TMPDIR=$MYDIR/tmp
mkdir -p $TMPDIR
cat $STARTDIR/dojulia.sh > $MYDIR/build_script
module purge
if [[ $(which git 2>/dev/null) ]] ; then echo found git ; else module load conda ; fi
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
date
st=`mytime`
now=$st
mkdir -p myspack/level00
cd myspack/level00
rm -rf spack
git clone -c feature.manyFiles=true https://github.com/spack/spack.git  
export SPACK_USER_CONFIG_PATH=`pwd`/.myspack  
alias dospack="source `pwd`/spack/share/spack/setup-env.sh"  
echo To restart spack to add more packages add these two lines to ~/.bashrc or source them
alias | grep dospack
echo "export SPACK_USER_CONFIG_PATH=$SPACK_USER_CONFIG_PATH"
source `pwd`/spack/share/spack/setup-env.sh  
ml gcc
spack compiler find
backup=`date +"%y%m%d%H%M%S"`
sed -i$backup "s.root: \$spack/opt/spack.root: $MYDIR/install."             spack/etc/spack/defaults/config.yaml 
sed -i$backup "s.#  lmod:   \$spack/share/spack/lmod.  lmod: $MYDIR/lmod."  spack/etc/spack/defaults/modules.yaml
sed -ia "s.#  tcl:    \$spack/share/spack/modules.  tcl: $MYDIR/modules."   spack/etc/spack/defaults/modules.yaml
sed -ib "s/- tcl/- lmod/"                                                   spack/etc/spack/defaults/modules.yaml
sed -ic "s/# roots:/roots:/"                                                spack/etc/spack/defaults/modules.yaml
echo Time to setup spack: $(mytime $now)
now=`mytime`
spack install python@3.10.2
echo Time to install python: $(mytime $now)
now=`mytime`
spack install julia
echo Time to install julia: $(mytime $now)
LMODDIR=$(dirname $(find $MYDIR/lmod -name "julia*"))
echo "To enable your modules add the following to your .bashrc file or source it"
echo module use $LMODDIR
module use $LMODDIR
module unload gcc
module load julia
which julia
module load python
which python
now=`mytime`
python -m pip install update
which pip3
pip3 install matplotlib
pip3 install pandas
pip3 install scipy
pip3 install jupyterlab
echo Time to install python extras: $(mytime $now)
echo Total time: $(mytime $st)
echo To add Julia to Jupyter Notebook we run the following commands in julia:
echo '
using Pkg
Pkg.add("IJulia")
' > ij
cat ij
julia ij
echo To launch jupyter-lab:
echo '
jupyter-lab --no-browser
'
echo 'On your local machine you will want to do a tunnel, something like:
ssh -t -L 8888:localhost:8888 vs-login-1.hpc.nrel.gov
Finally copy/paste the link give by jupyter-lab into a web browser
'
echo '
tkaiser2@nrel.gov
'
cp $STARTDIR/julia_build $MYDIR
