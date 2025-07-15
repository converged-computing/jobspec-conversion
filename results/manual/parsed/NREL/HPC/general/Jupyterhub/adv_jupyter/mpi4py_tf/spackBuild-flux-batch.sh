#!/bin/bash
#FLUX: --job-name="jupyter"
#FLUX: --queue=short
#FLUX: -t=7200
#FLUX: --priority=16

export IDIR='/projects/hpcapps/tkaiser'
export TMP='/scratch/$USER/tmp'
export TMPDIR='/scratch/$USER/tmp'
export BLDIR='`pwd`'
export PATH='/nopt/nrel/apps/openmpi/4.1.0-gcc-8.4.0/jdk-11.0.10/bin:$PATH'
export LD_LIBRARY_PATH='/nopt/nrel/apps/cuda/11.2/targets/x86_64-linux/lib:/nopt/nrel/apps/cudnn/8.1.1-cuda-11.2/lib64:/nopt/nrel/apps/cuda/11.2/lib64:/nopt/mpi/mpt-2.23/lib:/nopt/slurm/current/lib:$HOME/lib:$LD_LIBRARY_PATH'
export NEWMOD='`pwd`'
export TYPE='OPENMPI'
export CFLAGS='-L/nopt/nrel/apps/cuda/11.2/targets/x86_64-linux/lib'
export LDFLAGS='-L/nopt/nrel/apps/cuda/11.2/targets/x86_64-linux/lib -L/nopt/nrel/apps/cuda/11.2/compat'
export LIBRARY_PATH='/nopt/nrel/apps/cuda/11.2/targets/x86_64-linux/lib:'

export IDIR=/projects/hpcapps/tkaiser
cd $IDIR
command -v tymer >/dev/null 2>&1 || alias tymer='python -c "import sys ;import time ;print(time.time(),time.asctime(),sys.argv[1:])" '
rm ~/sbuild 
tymer ~/sbuild start
export TMP=/scratch/$USER/tmp
export TMPDIR=/scratch/$USER/tmp
mkdir -p $TMP
module purge
true
DOR=$?
if [ $DOR -eq 0 ] ; then   echo Will install R ;fi
ml conda
ml mpt/2.23
ml gcc/10.1.0 cuda/11.2 cudnn/8.1.1/cuda-11.2 
MYBASE=`date +"%m%d%H%M%S"`
mkdir $MYBASE
cd $MYBASE
export BLDIR=`pwd`
echo "Building in:" $BLDIR
cat $0 > build_script
tymer ~/sbuild start spack
git clone https://github.com/spack/spack.git
cd spack
cat > pack << HERE
packages: 
  all: 
    providers: 
      openjdk: 
      - openjdk 
  openjdk: 
    buildable: false 
    externals: 
    - spec: openjdk 
      prefix: /nopt/nrel/apps/openmpi/4.1.0-gcc-8.4.0/jdk-11.0.10
HERE
export PATH=/nopt/nrel/apps/openmpi/4.1.0-gcc-8.4.0/jdk-11.0.10/bin:$PATH
export LD_LIBRARY_PATH=/nopt/nrel/apps/openmpi/4.1.0-gcc-8.4.0/jdk-11.0.10/lib:$LD_LIBRARY_PATH
mv pack etc/spack/packages.yaml
. share/spack/setup-env.sh 
tymer ~/sbuild done setup
cd $BLDIR
spack install python@3.9.5
tymer ~/sbuild done python
if [ $DOR -eq 0 ] ; then
  spack install r@4.1.0
  tymer ~/sbuild done r
fi
cd spack/share/spack/lmod/linux-centos7*
export NEWMOD=`pwd`
module use $NEWMOD
pwd
ls
ml `ls | grep python-3.9`
if [ $DOR -eq 0 ] ; then
  ml `ls | grep r-4`
fi
cd $BLDIR
tymer ~/sbuild done load
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py 
tymer ~/sbuild done pip
pip install jupyter matplotlib scipy pandas xlwt dask
pip install jupyterlab
tymer ~/sbuild done jupyter
pip install git+https://github.com/NERSC/slurm-magic.git
pip --no-cache-dir install mpi4py
tymer ~/sbuild done mpi4py
if [ $DOR -eq 0 ] ; then
curl --insecure https://cran.r-project.org/src/contrib/Rmpi_0.6-9.1.tar.gz -o Rmpi.tar.gz
MY_MPI_PATH=`which mpicc| sed s,/bin/mpicc,,`
echo MY_MPI_PATH= $MY_MPI_PATH
export TYPE=OPENMPI
ml
srun -n 1 R CMD INSTALL --configure-args="\
--with-Rmpi-include='$MY_MPI_PATH/include' \
--with-Rmpi-libpath='$MY_MPI_PATH/lib' \
--with-mpi='$MY_MPI_PATH/bin/mpicc' \
--with-Rmpi-type='$TYPE'"  \
Rmpi.tar.gz    
tymer ~/sbuild done Rmpi
fi
pip --no-cache-dir install tensorflow==2.5.0
pip --no-cache-dir install tensorflow-gpu==2.5.0
pip --no-cache-dir install horovod[tensorflow]==0.22.0
tymer ~/sbuild done tensorflow
if [ ! -e ~/lib/libcusolver.so.10  ] ; then
    mkdir -p ~/lib
    ln -s /nopt/nrel/apps/cuda/11.2/targets/x86_64-linux/lib/libcusolver.so libcusolver.so.10
fi
export CFLAGS=-L/nopt/nrel/apps/cuda/11.2/targets/x86_64-linux/lib
export LDFLAGS="-L/nopt/nrel/apps/cuda/11.2/targets/x86_64-linux/lib -L/nopt/nrel/apps/cuda/11.2/compat"
export LIBRARY_PATH=/nopt/nrel/apps/cuda/11.2/targets/x86_64-linux/lib:
export LD_LIBRARY_PATH=/nopt/nrel/apps/cuda/11.2/targets/x86_64-linux/lib:/nopt/nrel/apps/cudnn/8.1.1-cuda-11.2/lib64:/nopt/nrel/apps/cuda/11.2/lib64:/nopt/mpi/mpt-2.23/lib:/nopt/slurm/current/lib:$HOME/lib:$LD_LIBRARY_PATH
pip --no-cache-dir install cupy==9.0.0
tymer ~/sbuild done cupy
wget  https://raw.githubusercontent.com/NREL/HPC/master/slurm/source/setup.py
wget  https://raw.githubusercontent.com/NREL/HPC/master/slurm/source/spam.c
python3 setup.py install
tymer ~/sbuild done spam
echo "TO USE:"
echo "export LD_LIBRARY_PATH="$LD_LIBRARY_PATH
echo ""
echo "source $IDIR/$MYBASE/spack/share/spack/setup-env.sh"
echo ""
echo "module use " $NEWMOD
echo ml `ml 2>&1 | grep 1 | sed "s/.)//g"`
echo
echo "YOU SHOULD BE ABLE TO SHORTEN LD_LIBRARY_PATH"
echo
echo "Suggestion, Try this:"
echo "module use " $NEWMOD
echo "  Run the \"ml line\""
echo " Then:"
echo export LD_LIBRARY_PATH=$HOME/lib:\$LD_LIBRARY_PATH
cp $SLURM_SUBMIT_DIR/slurm-$SLURM_JOBID.out $BLDIR
