#!/bin/bash
#FLUX: --job-name=wrf-profile
#FLUX: -N=4
#FLUX: -n=160
#FLUX: -t=1800
#FLUX: --urgency=16

export SUPPRESS_BASHRC='1 #this is pointless - bashrc will have been run already!!'
export PROJECT_ROOT='/home/l/lcl_uotiscscc/lcl_uotiscsccs1034/scratch/code-challenge/collective_profiler/'
export HDF5='/home/l/lcl_uotiscscc/lcl_uotiscsccs1034/scratch/nonspack/hdf5'
export PATH='$NETCDF/bin:$PATH'
export LD_LIBRARY_PATH='$NETCDF/lib:$LD_LIBRARY_PATH'
export INCLUDE='$NETCDF/include:$INCLUDE'
export NETCDF='/home/l/lcl_uotiscscc/lcl_uotiscsccs1034/scratch/nonspack/netcdf'
export JOB_NOW='$( date +%Y%m%d-%H%M%S )'
export RESULTS_ROOT='${PROJECT_ROOT}/examples/results_task2_wrf/run-at-${JOB_NOW} '
export POST_ANALYSYS_ROOT='$RESULTS_DIR/post_processed'
export EXECUTABLE1='./wrf.exe'
export EXECUTABLE1_PARAMS=''
export A2A_PROFILING_OUTPUT_DIR='$RESULTS_ROOT'

export SUPPRESS_BASHRC=1 #this is pointless - bashrc will have been run already!!
THIS_SCRIPT=$(readlink --canonicalize --no-newline "$0")
THIS_SCRIPT_FILENAME=$(basename "$THIS_SCRIPT")
THIS_SCRIPT_DIR=$(dirname "$THIS_SCRIPT")
export PROJECT_ROOT=/home/l/lcl_uotiscscc/lcl_uotiscsccs1034/scratch/code-challenge/collective_profiler/
module purge
HNAME=$(hostname)
module load NiaEnv/2019b
module load intel/2019u4  openmpi/4.0.1
ulimit -c unlimited
ulimit -s unlimited
ulimit -c unlimited
ulimit -s unlimited
export HDF5=/home/l/lcl_uotiscscc/lcl_uotiscsccs1034/scratch/nonspack/hdf5
export PATH=$HDF5/bin:$PATH
export LD_LIBRARY_PATH=$HDF5/lib:$LD_LIBRARY_PATH
export INCLUDE=$HDF5/include:$INCLUDE
export NETCDF=/home/l/lcl_uotiscscc/lcl_uotiscsccs1034/scratch/nonspack/netcdf
export PATH=$NETCDF/bin:$PATH
export LD_LIBRARY_PATH=$NETCDF/lib:$LD_LIBRARY_PATH
export INCLUDE=$NETCDF/include:$INCLUDE
export JOB_NOW=$( date +%Y%m%d-%H%M%S )
export RESULTS_ROOT=${PROJECT_ROOT}/examples/results_task2_wrf/run-at-${JOB_NOW}  #-${THIS_SCRIPT_FILENAME}
mkdir -p "${RESULTS_ROOT}/analysis"
mkdir -p "${RESULTS_ROOT}/ranks"
echo "========================================================="
echo "          START: This is the batch script" 
echo "========================================================="
echo
echo "results directory created at: $RESULTS_ROOT"
echo "recording Slurm job stats at beginning of job ..."
sstat -j "$SLURM_JOB_ID" > "$RESULTS_ROOT/slurm_stats_at_start.log" 
echo
echo "recording env ..."
env > "$RESULTS_ROOT/env.log"
echo
echo "recording ompi_info ..."
ompi_info > "$RESULTS_ROOT/ompi_info.log"
echo
echo "recording SLURM variables ..."
env | grep SLURM > "$RESULTS_ROOT/slurm_variable.log"
echo
echo "recording a copy of this script ..."
cp "$THIS_SCRIPT" "${RESULTS_ROOT}/${THIS_SCRIPT_FILENAME}.copy"
echo
echo "creating post processing scripts to use in results dir..."
cat - > "$RESULTS_ROOT/copy_slurm_output_here.sh" << 'EOF' 
RESULTS_ROOT=$(dirname "$0")
eval $( grep SLURM_SUBMIT_DIR "$RESULTS_ROOT/slurm_variable.log" )
eval $( grep SLURM_JOB_NAME  "$RESULTS_ROOT/slurm_variable.log" )
eval $( grep SLURM_JOB_ID  "$RESULTS_ROOT/slurm_variable.log" )
SLURM_OUTPUT_FILE=$(ls "$SLURM_SUBMIT_DIR" | grep "$SLURM_JOB_NAME" | grep "$SLURM_JOB_ID")
echo "copying $SLURM_SUBMIT_DIR/$SLURM_OUTPUT_FILE here ..."
cp "$SLURM_SUBMIT_DIR/$SLURM_OUTPUT_FILE" "$RESULTS_ROOT"
chmod a=r "$RESULTS_ROOT/$SLURM_OUTPUT_FILE"
EOF
cat - > "$RESULTS_ROOT/analyze.sh" << 'EOF'
export RESULTS_ROOT=$( dirname $(readlink --canonicalize --no-newline "$0" ) )
export POST_ANALYSYS_ROOT="$RESULTS_DIR/post_processed"
echo "this script is as yet a dummy and has set only some paths - no analysis performed
EOF
export EXECUTABLE1=./wrf.exe
export EXECUTABLE1_PARAMS=""
cd /home/l/lcl_uotiscscc/lcl_uotiscsccs1034/scratch/code-challenge/collective_profiler/examples/
python /home/l/lcl_uotiscscc/lcl_uotiscsccs1034/scratch/code-challenge/collective_profiler/examples/wrf-autotuning.py --date 20210608-081238
export A2A_PROFILING_OUTPUT_DIR=$RESULTS_ROOT
ALLTOALL_LIB_ROOT=/home/l/lcl_uotiscscc/lcl_uotiscsccs1034/scratch/code-challenge/collective_profiler/src/alltoallv
COUNTSFLAGS="$ALLTOALL_LIB_ROOT/liballtoallv_counts_notcompact.so"
MPIFLAGS="-x OMP_NUM_THREADS=10 "
MPIFLAGS+="-x A2A_PROFILING_OUTPUT_DIR "
MPIFLAGS+="-x LD_LIBRARY_PATH "
MPIFLAGS+="--rankfile /gpfs/fs0/scratch/l/lcl_uotiscscc/lcl_uotiscsccs1034/code-challenge/collective_profiler/examples/rank " 
declare -a MPIRUN_COMMANDS 
cd /home/l/lcl_uotiscscc/lcl_uotiscsccs1034/scratch/WRF/wrf_mpiomp
mpirun $MPIFLAGS --output-filename $RESULTS_ROOT/counts -x LD_PRELOAD=$COUNTSFLAGS $EXECUTABLE1 $EXECUTABLE1_PARAMS
python /home/l/lcl_uotiscscc/lcl_uotiscsccs1034/scratch/code-challenge/collective_profiler/examples/wrf-autotuning.py --date ${JOB_NOW}
export JOB_NOW=$( date +%Y%m%d-%H%M%S )
export RESULTS_ROOT=${PROJECT_ROOT}/examples/results_task2_wrf/run-at-${JOB_NOW} 
mkdir -p "${RESULTS_ROOT}/analysis"
mkdir -p "${RESULTS_ROOT}/ranks"
mpirun $MPIFLAGS --output-filename $RESULTS_ROOT/counts     -x LD_PRELOAD=$COUNTSFLAGS $EXECUTABLE1 $EXECUTABLE1_PARAMS
python /home/l/lcl_uotiscscc/lcl_uotiscsccs1034/scratch/code-challenge/collective_profiler/examples/wrf-autotuning.py --date ${JOB_NOW}
export JOB_NOW=$( date +%Y%m%d-%H%M%S )
export RESULTS_ROOT=${PROJECT_ROOT}/examples/results_task2_wrf/run-at-${JOB_NOW} 
mkdir -p "${RESULTS_ROOT}/analysis"
mkdir -p "${RESULTS_ROOT}/ranks"
mpirun $MPIFLAGS --output-filename $RESULTS_ROOT/counts     -x LD_PRELOAD=$COUNTSFLAGS $EXECUTABLE1 $EXECUTABLE1_PARAMS
python /home/l/lcl_uotiscscc/lcl_uotiscsccs1034/scratch/code-challenge/collective_profiler/examples/wrf-autotuning.py --date ${JOB_NOW}
export JOB_NOW=$( date +%Y%m%d-%H%M%S )
export RESULTS_ROOT=${PROJECT_ROOT}/examples/results_task2_wrf/run-at-${JOB_NOW} 
mkdir -p "${RESULTS_ROOT}/analysis"
mkdir -p "${RESULTS_ROOT}/ranks"
mpirun $MPIFLAGS --output-filename $RESULTS_ROOT/counts     -x LD_PRELOAD=$COUNTSFLAGS $EXECUTABLE1 $EXECUTABLE1_PARAMS
python /home/l/lcl_uotiscscc/lcl_uotiscsccs1034/scratch/code-challenge/collective_profiler/examples/wrf-autotuning.py --date ${JOB_NOW}
export JOB_NOW=$( date +%Y%m%d-%H%M%S )
export RESULTS_ROOT=${PROJECT_ROOT}/examples/results_task2_wrf/run-at-${JOB_NOW} 
mkdir -p "${RESULTS_ROOT}/analysis"
mkdir -p "${RESULTS_ROOT}/ranks"
mpirun $MPIFLAGS --output-filename $RESULTS_ROOT/counts     -x LD_PRELOAD=$COUNTSFLAGS $EXECUTABLE1 $EXECUTABLE1_PARAMS
echo
echo "recording basic job details ..."
{
    echo "alltoallv sampling test script"
    echo "SCRIPT NAME             : $THIS_SCRIPT_FILENAME"
    echo "SCRIPT DIR              : $THIS_SCRIPT_DIR"
    echo "(the scheduler may have made a copy at a location other than the source)"
    echo "PROJECT_ROOT            : $PROJECT_ROOT"
    echo "RESULTS_ROOT            : $RESULTS_ROOT"
    echo "HOSTNAME                : $(hostname)"
    echo "USER                    : $USER"
    echo "JOB_NOW                 : ${JOB_NOW}"
    echo "(note that this the local time on the cluster, so California time)"
    echo "which mpirun            : $(which mpirun)"
    echo "mpirun --version ..." 
    mpirun --version
    echo "module list ..."
    module list
    echo "spack env status ..."
    spack env status
    echo "EXECUTABLE1             : $EXECUTABLE1"
    echo "EXECUTABLE1_PARAMS      : $EXECUTABLE1_PARAMS"
    echo "MPIFLAGS                : $MPIFLAGS"
    echo "A2A_PROFILING_OUTPUT_DIR: $A2A_PROFILING_OUTPUT_DIR"
} |& tee "$RESULTS_ROOT/basic_job_details.log"
echo
echo "recording ldd for the executables ..."
ldd "$(which $EXECUTABLE1)" > "${RESULTS_ROOT}/$(basename $EXECUTABLE1).ldd" 
echo  "in this example are using PRELOAD so this may not be giving the right information to compare to that" >> "${RESULTS_ROOT}/$(basename $EXECUTABLE1).ldd" 
echo
echo "========================================================="
echo "            END: This is the batch script" 
echo "========================================================="
