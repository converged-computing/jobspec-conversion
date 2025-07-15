#!/bin/bash
#FLUX: --job-name=astute-leopard-2067
#FLUX: --urgency=16

export PIN_ROOT='/uufs/chpc.utah.edu/common/home/u0993036/pintool/newpin/'
export PTOOL_ROOT='/uufs/chpc.utah.edu/common/home/u0993036/pintool/newpin/source/tools'
export CG_ROOT='/uufs/chpc.utah.edu/common/home/u0993036/valgrind/bin'
export NAS_ROOT='/uufs/chpc.utah.edu/common/home/u0993036/nas/NPB3.3-MPI/bin'
export LOCAL_STORAGE='/scratch/local/'
export WORKSPACE='$SCRATCH/workspace/'
export TCMD='mpirun -np $SLURM_NTASKS '
export PATH='$PATH:$CG_ROOT ; '

export PIN_ROOT=/uufs/chpc.utah.edu/common/home/u0993036/pintool/newpin/
export PTOOL_ROOT=/uufs/chpc.utah.edu/common/home/u0993036/pintool/newpin/source/tools
export CG_ROOT=/uufs/chpc.utah.edu/common/home/u0993036/valgrind/bin
export NAS_ROOT=/uufs/chpc.utah.edu/common/home/u0993036/nas/NPB3.3-MPI/bin
export LOCAL_STORAGE=/scratch/local/
export WORKSPACE=$SCRATCH/workspace/
export TCMD="mpirun -np $SLURM_NTASKS "
EXPERIMENT=callgrind;
JOB=callgrind.4;
TRACE_DIR=$WORKSPACE/$EXPERIMENT/traces;
APPOUT_DIR=$WORKSPACE/$EXPERIMENT/app_out;
EXEC_DIR=$WORKSPACE/$EXPERIMENT/exec_dir;
FILE_DIR=$EXEC_DIR/files;
mkdir -p $APPOUT_DIR ; 
mkdir -p $FILE_DIR ; 
mkdir -p $TRACE_DIR ; 
echo LOADING APPROPRIATE MODULES ; 
echo LOADING APPROPRIATE ENV_VARS ; 
export PATH=$PATH:$CG_ROOT ; 
echo COPYING ; 
cp $NAS_ROOT/o1/cg.C.64 $FILE_DIR ; 
mkdir -p $TRACE_DIR/$JOB.1 ; 
TEMP_DIR=$EXEC_DIR/$JOB.1 ; 
mkdir -p $TEMP_DIR;
chmod -R 755 $TEMP_DIR ; 
cd $TEMP_DIR ; 
echo job:$JOB.1 ; 
echo "time $TCMD valgrind --tool=callgrind $FILE_DIR/cg.C.64 1> $APPOUT_DIR/$JOB.1.txt 2> $APPOUT_DIR/$JOB.1.err.txt" ; 
time $TCMD valgrind --tool=callgrind --callgrind-out-file=/scratch/local/callgrind.%q{SLURM_NODEID}.%p $FILE_DIR/cg.C.64 1> $APPOUT_DIR/$JOB.1.txt 2> $APPOUT_DIR/$JOB.1.err.txt ; 
echo END OF JOBBBBBBBBB ; 
mv $LOCAL_STORAGE/callgrind.* $TRACE_DIR/$JOB.1/ ;
echo END OF MOVING TRACES ; 
cd $EXEC_DIR ; 
rm -rf $TEMP_DIR ; 
