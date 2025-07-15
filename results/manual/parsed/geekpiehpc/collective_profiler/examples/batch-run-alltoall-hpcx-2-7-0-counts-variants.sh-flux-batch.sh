#!/bin/bash
#FLUX: --job-name=alltoall
#FLUX: -N=8
#FLUX: -n=8
#FLUX: -t=1200
#FLUX: --urgency=16

export SUPPRESS_BASHRC='1 #this is pointless - bashrc will have been run already!!'
export PROJECT_ROOT='/home/l/lcl_uotiscscc/lcl_uotiscsccs1034/scratch/code-challenge/collective_profiler/examples'
export JOB_NOW='$( date +%Y%m%d-%H%M%S )'
export RESULTS_ROOT='$( dirname $(readlink --canonicalize --no-newline "$0" ) )'
export POST_ANALYSYS_ROOT='$RESULTS_DIR/post_processed'
export EXECUTABLE1='/home/l/lcl_uotiscscc/lcl_uotiscsccs1034/scratch/code-challenge/collective_profiler/examples/alltoall_c'
export EXECUTABLE1_PARAMS=''

export SUPPRESS_BASHRC=1 #this is pointless - bashrc will have been run already!!
THIS_SCRIPT=$(readlink --canonicalize --no-newline "$0")
THIS_SCRIPT_FILENAME=$(basename "$THIS_SCRIPT")
THIS_SCRIPT_DIR=$(dirname "$THIS_SCRIPT")
export PROJECT_ROOT=/home/l/lcl_uotiscscc/lcl_uotiscsccs1034/scratch/code-challenge/collective_profiler/examples
module purge
HNAME=$(hostname)
spack load gcc@11
module load intel/2019u4  openmpi/4.0.1
    # module load gcc/8.3.1 hpcx/2.7.0
export JOB_NOW=$( date +%Y%m%d-%H%M%S )
export RESULTS_ROOT=${PROJECT_ROOT}/alltoall_profiling/examples/results/run-at-${JOB_NOW} #-${THIS_SCRIPT_FILENAME}
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
export EXECUTABLE1=/home/l/lcl_uotiscscc/lcl_uotiscsccs1034/scratch/code-challenge/collective_profiler/examples/alltoall_c
export EXECUTABLE1_PARAMS=""
ALLTOALL_LIB_ROOT=/home/l/lcl_uotiscscc/lcl_uotiscsccs1034/scratch/code-challenge/collective_profiler/src/alltoall
declare -a COUNTSFLAGS
COUNTSFLAGS[0]="$ALLTOALL_LIB_ROOT/liballtoall_counts.so"
COUNTSFLAGS[1]="$ALLTOALL_LIB_ROOT/liballtoall_counts_unequal.so"
COUNTSFLAGS[2]="$ALLTOALL_LIB_ROOT/liballtoall_counts_compact.so"
COUNTSFLAGS[3]="$ALLTOALL_LIB_ROOT/liballtoall_counts_unequal_compact.so"
declare -a RESULTS_SUB
RESULTS_SUB[0]="equal_counts"
RESULTS_SUB[1]="unequal_counts"
RESULTS_SUB[2]="equal_counts_compact"
RESULTS_SUB[3]="unequal_counts_compact"
MPIFLAGS="--mca pml ucx -x UCX_NET_DEVICES=mlx5_0:1 "
MPIFLAGS+="-x A2A_PROFILING_OUTPUT_DIR "
MPIFLAGS+="-x LD_LIBRARY_PATH "
MPIFLAGS+="-np 8 -map-by ppr:1:node -bind-to core "
MPIFLAGS+="--mca pml_base_verbose 100 --mca btl_base_verbose 100 " 
declare -a MPIRUN_COMMANDS 
MPIRUN_COMMANDS[0]="mpirun $MPIFLAGS --output-filename $RESULTS_ROOT/${RESULTS_SUB[0]} -x LD_PRELOAD=${COUNTSFLAGS[0]} $EXECUTABLE1 $EXECUTABLE1_PARAMS"
MPIRUN_COMMANDS[1]="mpirun $MPIFLAGS --output-filename $RESULTS_ROOT/${RESULTS_SUB[1]} -x LD_PRELOAD=${COUNTSFLAGS[1]} $EXECUTABLE1 $EXECUTABLE1_PARAMS"
MPIRUN_COMMANDS[2]="mpirun $MPIFLAGS --output-filename $RESULTS_ROOT/${RESULTS_SUB[2]} -x LD_PRELOAD=${COUNTSFLAGS[2]} $EXECUTABLE1 $EXECUTABLE1_PARAMS"
MPIRUN_COMMANDS[3]="mpirun $MPIFLAGS --output-filename $RESULTS_ROOT/${RESULTS_SUB[3]} -x LD_PRELOAD=${COUNTSFLAGS[3]} $EXECUTABLE1 $EXECUTABLE1_PARAMS"
echo
echo "recording basic job details ..."
{
    echo "alltoall sampling test script"
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
} |& tee "$RESULTS_ROOT/basic_job_details.log"
echo
echo "recording ldd for the executables ..."
ldd "$(which $EXECUTABLE1)" > "${RESULTS_ROOT}/$(basename $EXECUTABLE1).ldd" 
echo  "in this example are using PRELOAD so this may not be giving the right information to compare to that" >> "${RESULTS_ROOT}/$(basename $EXECUTABLE1).ldd" 
echo
echo "recording the mpirun command ..."
cat - > "$RESULTS_ROOT/mpirun_command1.log" << EOF
${MPIRUN_COMMANDS[0]}
${MPIRUN_COMMANDS[1]}
${MPIRUN_COMMANDS[2]}
${MPIRUN_COMMANDS[3]}
EOF
echo "Now calling mpirun ..."
echo "- stdout and stderr of this mpirun will be in " 
echo "  the results directory but appear also below"
echo "- stdout and stderr of the respective MPI ranks will be in" 
echo "  subdirectories of that and are not shown here "
echo "  if mpirun uses --output-file"
echo "*********************************************************"
echo 
idx=0
 for MPIRUN_COMMAND in "${MPIRUN_COMMANDS[@]}"
  do
    export A2A_PROFILING_OUTPUT_DIR="$RESULTS_ROOT/${RESULTS_SUB[${idx}]}"
    mkdir -p $A2A_PROFILING_OUTPUT_DIR
    echo "mpirun command will be: $MPIRUN_COMMAND"
    $MPIRUN_COMMAND \
    ${RESULTS_ROOT}/${RESULTS_SUB[${idx}]}/mpirun.stdout \
    ${RESULTS_ROOT}/${RESULTS_SUB[${idx}]}/mpirun.stderr
    echo "... results stored at ${RESULTS_ROOT}/${RESULTS_SUB[${idx}]}/mpirun.stdout and .../stderr"
    echo "... end of that mpirun"
let "idx=idx+1"
done
echo
echo "*********************************************************"
echo "... mpirun complete"
echo 
echo "recording Slurm job stats at end of job ..."
sstat -j "$SLURM_JOB_ID" > "$RESULTS_ROOT/slurm_stats_at_end.log" 
echo
echo "setting the files of the results directory to read only ..."
find "$RESULTS_ROOT" -type d -exec chmod ug=rwx,o=rx {} \;
find "$RESULTS_ROOT" -type f -exec chmod ug=r,o=r {} \;
echo
echo "adding execute permission to post processing scripts ..."
chmod ug+x "$RESULTS_ROOT/copy_slurm_output_here.sh"
echo 
echo "you can see the results at $RESULTS_ROOT"
echo
echo "========================================================="
echo "            END: This is the batch script" 
echo "========================================================="
