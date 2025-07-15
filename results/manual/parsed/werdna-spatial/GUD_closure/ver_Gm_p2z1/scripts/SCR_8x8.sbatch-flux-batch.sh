#!/bin/bash
#FLUX: --job-name=pusheena-squidward-1613
#FLUX: -c=64
#FLUX: --exclusive
#FLUX: --queue=condo-dtalmy
#FLUX: -t=172800
#FLUX: --priority=16

export LD_LIBRARY_PATH='${NCDIR}/lib:${LD_LIBRARY_PATH}'
export I_MPI_JOB_RESPECT_PROCESS_PLACEMENT='0   # the option -ppn only works if you set this before'

echo ---Modules 
module purge
module load intel-compilers/2021.2.0
module load intel-mpi/2021.2.0
module load PE-intel
module list
NCDIR=/lustre/isaac/proj/UTK0105/usr
echo $NCDIR
export LD_LIBRARY_PATH=${NCDIR}/lib:${LD_LIBRARY_PATH}
echo $LD_LIBRARY_PATH
shopt -s expand_aliases
alias python='/usr/bin/python2'
python2 --version
python  --version
VALpath=/lustre/isaac/proj/UTK0105/Darwin/GITLAB/gud-gud/verification/GUD_closure_DD
USERpath=/lustre/isaac/scratch/ecarr/runs
RUN_ID=$SLURM_JOB_ID
TAG_ID='Gm_p2z1'
DIR_NAME=run_$TAG_ID\_$RUN_ID
USER_DIR=$USERpath/$DIR_NAME
RUN_DIR=$VALpath/$DIR_NAME
RESULTS_DIR=mm_$RUN_ID
GUDBpath=/lustre/isaac/proj/UTK0105/Darwin/GITLAB/gud-gud
echo RUN_ID    : $RUN_ID
echo TAG_ID    : $TAG_ID
echo VALpath   : $VALpath
echo USERpath  : $USERpath
echo RUN_DIR   : $RUN_DIR
echo USER_DIR   : $USER_DIR
cd $USERpath
if [ -d "$USER_DIR" ]; then
    # Will enter here if $DIRECTORY exists, even if it contains spaces
    echo "User run dir exists  failed"
    exit 1
fi
mkdir  $USER_DIR
lfs setstripe $USER_DIR -S 32m -i -1 -c 1
cd $VALpath 
if [ -d "$RUN_DIR" ]; then
    # Will enter here if $DIRECTORY exists, even if it contains spaces
    echo "RUN area ln dir exists  failed"
    exit 1
fi
cd $VALpath 
ln -s $USER_DIR ./$DIR_NAME
cd   $RUN_DIR
cp -r $VALpath/ver_$TAG_ID/* $RUN_DIR
cd   $RUN_DIR
pwd
cd ./code
cd $RUN_DIR
mkdir ./build
cd ./build
if 
    $GUDBpath/tools/genmake2 \
      -rootdir $GUDBpath \
      -mods ../code \
      -mpi  \
      -optfile $GUDBpath/tools/build_options/linux_amd64_ifort+impi_stampede2_skx_isaac
then
    echo "genmake2 succeeded"
else
    echo "genmake2 failed"
    exit 1
fi
if 
  make depend
then
    echo "make depend succeeded"
else
    echo "make depend failed"
    exit 1
fi
if 
  make 
then
    echo "make  succeeded"
else
    echo "make  failed"
    exit 1
fi
cd ..
ln -s ./input/* .
cp ./build/mitgcmuv .
unset I_MPI_PMI_LIBRARY 
export I_MPI_JOB_RESPECT_PROCESS_PLACEMENT=0   # the option -ppn only works if you set this before
cd $RUN_DIR
pwd
if
    /usr/bin/time --output=outtime_$RUN_ID.log -p sh -c ' /sw/isaac/compilers/intel/oneAPI_2021.2.0/mpi/latest/bin/mpirun -np 64  ./mitgcmuv 2>&1 | tee output.log'
then
    echo "RUN  succeeded"
else
    echo "RUN  failed"
    exit 1
fi
sbatch --job-name=NC_npzd --export=RUN_DIR=$USER_DIR,MODEL_RUNID=$RUN_ID  ./scripts/NC_createTracer.sbatch
