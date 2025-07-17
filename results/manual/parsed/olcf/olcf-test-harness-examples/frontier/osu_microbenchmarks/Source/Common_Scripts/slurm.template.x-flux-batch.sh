#!/bin/bash
#FLUX: --job-name=butterscotch-lizard-9121
#FLUX: --urgency=16

export MPIR_CVAR_GPU_EAGER_DEVICE_MEM='0'
export MPICH_GPU_SUPPORT_ENABLED='1'
export MPICH_SMP_SINGLE_COPY_MODE='CMA'
export MPICH_GPU_EAGER_DEVICE_MEM='0'

module load rocm
module load craype-accel-amd-gfx908
export MPIR_CVAR_GPU_EAGER_DEVICE_MEM=0
export MPICH_GPU_SUPPORT_ENABLED=1
export MPICH_SMP_SINGLE_COPY_MODE=CMA
export MPICH_GPU_EAGER_DEVICE_MEM=0
module list
EXECUTABLE="__executable_path__"
SCRIPTS_DIR="__scripts_dir__"
WORK_DIR="__working_dir__"
RESULTS_DIR="__results_dir__"
HARNESS_ID="__harness_id__"
BUILD_DIR="__build_dir__"
echo "Printing test directory environment variables:"
env | fgrep RGT_APP_SOURCE_
env | fgrep RGT_TEST_
echo
cd $SCRIPTS_DIR
if [ ! -e $WORK_DIR ]
then
    mkdir -p $WORK_DIR
fi
cd $WORK_DIR
env &> job.environ
scontrol show hostnames > job.nodes
log_binary_execution_time.py --scriptsdir $SCRIPTS_DIR --uniqueid $HARNESS_ID --mode start
CMD="srun -n __total_processes__ -N __nodes__ ${SRUN_FLAGS} $BUILD_DIR/$EXECUTABLE $EXECUTABLE_FLAGS"
echo "$CMD 1> stdout.txt 2> stderr.txt"
$CMD 1> stdout.txt 2> stderr.txt
log_binary_execution_time.py --scriptsdir $SCRIPTS_DIR --uniqueid $HARNESS_ID --mode final
cd $SCRIPTS_DIR
cp -rf $WORK_DIR/* $RESULTS_DIR 
cp $BUILD_DIR/output_build.txt $RESULTS_DIR
check_executable_driver.py -p $RESULTS_DIR -i $HARNESS_ID
case __resubmit__ in
    0) 
       echo "No resubmit";;
    1) 
       test_harness_driver.py -r;;
esac 
