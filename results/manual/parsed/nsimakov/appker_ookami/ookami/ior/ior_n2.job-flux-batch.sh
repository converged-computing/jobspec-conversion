#!/bin/bash
#FLUX: --job-name=cowy-staircase-0237
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --queue=short
#FLUX: -t=10800
#FLUX: --priority=16

export AKRR_NODES='2'
export AKRR_CORES='96'
export AKRR_CORES_PER_NODE='48'
export AKRR_NETWORK_SCRATCH='/lustre/home/xdmod/scratch'
export AKRR_LOCAL_SCRATCH='/tmp'
export AKRR_TASK_WORKDIR='/lustre/home/xdmod/scratch/akrr_data/Ookami-Cray/ior/2020.12.02.05.00.04.587515'
export AKRR_APPKER_DIR='/lustre/home/xdmod/appker/Ookami'
export AKRR_AKRR_DIR='/lustre/home/xdmod/scratch/akrr_data/Ookami-Cray'
export AKRR_APPKER_NAME='ior'
export AKRR_RESOURCE_NAME='Ookami-Cray'
export AKRR_TIMESTAMP='2020.12.02.05.00.04.587515'
export AKRR_APP_STDOUT_FILE='$AKRR_TASK_WORKDIR/appstdout'
export AKRR_APPKERNEL_INPUT='/lustre/home/xdmod/appker/Ookami/inputs'
export AKRR_APPKERNEL_EXECUTABLE='/lustre/home/xdmod/appker/Ookami/execs/ior'
export AKRR_NODELIST='`srun -l --ntasks-per-node=$AKRR_CORES_PER_NODE -n $AKRR_CORES hostname -s|sort -n| awk '{printf "%s ",$2}' `'
export PATH='$AKRR_APPKER_DIR/execs/bin:$PATH'
export AKRR_TMP_WORKDIR='`mktemp -d /lustre/home/xdmod/scratch/ior.XXXXXXXXX`'

module use /cm/local/modulefiles
module use /opt/cray/pe/modulefiles
module load slurm
export AKRR_NODES=2
export AKRR_CORES=96
export AKRR_CORES_PER_NODE=48
export AKRR_NETWORK_SCRATCH="/lustre/home/xdmod/scratch"
export AKRR_LOCAL_SCRATCH="/tmp"
export AKRR_TASK_WORKDIR="/lustre/home/xdmod/scratch/akrr_data/Ookami-Cray/ior/2020.12.02.05.00.04.587515"
export AKRR_APPKER_DIR="/lustre/home/xdmod/appker/Ookami"
export AKRR_AKRR_DIR="/lustre/home/xdmod/scratch/akrr_data/Ookami-Cray"
export AKRR_APPKER_NAME="ior"
export AKRR_RESOURCE_NAME="Ookami-Cray"
export AKRR_TIMESTAMP="2020.12.02.05.00.04.587515"
export AKRR_APP_STDOUT_FILE="$AKRR_TASK_WORKDIR/appstdout"
export AKRR_APPKERNEL_INPUT="/lustre/home/xdmod/appker/Ookami/inputs"
export AKRR_APPKERNEL_EXECUTABLE="/lustre/home/xdmod/appker/Ookami/execs/ior"
source "$AKRR_APPKER_DIR/execs/bin/akrr_util.bash"
export AKRR_NODELIST=`srun -l --ntasks-per-node=$AKRR_CORES_PER_NODE -n $AKRR_CORES hostname -s|sort -n| awk '{printf "%s ",$2}' `
export PATH="$AKRR_APPKER_DIR/execs/bin:$PATH"
cd "$AKRR_TASK_WORKDIR"
akrr_perform_common_tests
akrr_write_to_gen_info "start_time" "`date`"
akrr_write_to_gen_info "node_list" "$AKRR_NODELIST"
export AKRR_TMP_WORKDIR=`mktemp -d /lustre/home/xdmod/scratch/ior.XXXXXXXXX`
echo "Temporary working directory: $AKRR_TMP_WORKDIR"
cd $AKRR_TMP_WORKDIR
module use /cm/local/modulefiles
module use /opt/cray/pe/modulefiles
module restore PrgEnv-cray
module load slurm cray-mvapich2_nogpu_svealpha/2.3.4 cray-hdf5-parallel/1.12.0.2
module list
EXE=$AKRR_APPKER_DIR/execs/ior/3.3.0rc1_cray_mvapich/bin/ior
for node in $AKRR_NODELIST; do echo $node>>all_nodes; done
RUNMPI="srun -n $AKRR_CORES -N $AKRR_NODES -r 0"
RUNMPI_OFFSET="srun -N $AKRR_NODES -n $AKRR_CORES -r 1"
echo "running on $(hostname)"
if [ "$AKRR_NODES" = "1" ]; then
    echo "try $RUNMPI"
    $RUNMPI -l hostname|uniq
    echo "try $RUNMPI_OFFSET"
    $RUNMPI_OFFSET -l hostname|uniq
fi
appsigcheck.sh $EXE $AKRR_TASK_WORKDIR/.. >> $AKRR_APP_STDOUT_FILE
COMMON_TEST_PARAM="-b 200m -t 20m"
COMMON_OPTIONS="-vv -e -Y"
CACHING_BYPASS="-C"
TESTS_LIST=("-a POSIX $RESOURCE_SPECIFIC_OPTION_N_to_1"
"-a POSIX -F $RESOURCE_SPECIFIC_OPTION_N_to_N"
"-a MPIIO $RESOURCE_SPECIFIC_OPTION_N_to_1"
"-a MPIIO -c $RESOURCE_SPECIFIC_OPTION_N_to_1"
"-a MPIIO -F $RESOURCE_SPECIFIC_OPTION_N_to_N"
"-a HDF5 $RESOURCE_SPECIFIC_OPTION_N_to_1"
"-a HDF5 -c $RESOURCE_SPECIFIC_OPTION_N_to_1"
"-a HDF5 -F $RESOURCE_SPECIFIC_OPTION_N_to_N")
COMMON_PARAM="$COMMON_OPTIONS $RESOURCE_SPECIFIC_OPTION $CACHING_BYPASS $COMMON_TEST_PARAM"
echo "Using $AKRR_TMP_WORKDIR for test...." >> $AKRR_APP_STDOUT_FILE 2>&1
canonicalFilename=`readlink -f $AKRR_TMP_WORKDIR`
filesystem=`awk -v canonical_path="$canonicalFilename" '{if ($2!="/" && 1==index(canonical_path, $2)) print $3 " " $1 " " $2;}' /proc/self/mounts`
echo "File System To Test: $filesystem" >> $AKRR_APP_STDOUT_FILE 2>&1
akrr_write_to_gen_info "file_system" "$filesystem"
akrr_write_to_gen_info "appkernel_start_time" "`date`"
for TEST_PARAM in "${TESTS_LIST[@]}"
do
    echo "# Starting Test: $TEST_PARAM" >> $AKRR_APP_STDOUT_FILE 2>&1
    fileName=`echo ior_test_file_$TEST_PARAM |tr  '-' '_'|tr  ' ' '_'|tr  '=' '_'`
    #run the test
    command_to_run="$RUNMPI $EXE $COMMON_PARAM $TEST_PARAM -w -k -o $AKRR_TMP_WORKDIR/$fileName"
    echo "executing: $command_to_run" >> $AKRR_APP_STDOUT_FILE 2>&1
    $command_to_run >> $AKRR_APP_STDOUT_FILE 2>&1
done
for TEST_PARAM in "${TESTS_LIST[@]}"
do
    echo "# Starting Test: $TEST_PARAM" >> $AKRR_APP_STDOUT_FILE 2>&1
    fileName=`echo ior_test_file_$TEST_PARAM |tr  '-' '_'|tr  ' ' '_'|tr  '=' '_'`
    #run the test
    command_to_run="$RUNMPI $EXE $COMMON_PARAM $TEST_PARAM -r -o $AKRR_TMP_WORKDIR/$fileName"
    echo "executing: $command_to_run" >> $AKRR_APP_STDOUT_FILE 2>&1
    $command_to_run >> $AKRR_APP_STDOUT_FILE 2>&1
done
akrr_write_to_gen_info "appkernel_end_time" "`date`"
cd $AKRR_TASK_WORKDIR
if [ "${AKRR_DEBUG=no}" = "no" ]
then
        echo "Deleting temporary files"
        rm -rf $AKRR_TMP_WORKDIR
else
        echo "Copying temporary files"
        cp -r $AKRR_TMP_WORKDIR workdir
        rm -rf $AKRR_TMP_WORKDIR
fi
akrr_write_to_gen_info "end_time" "`date`"
