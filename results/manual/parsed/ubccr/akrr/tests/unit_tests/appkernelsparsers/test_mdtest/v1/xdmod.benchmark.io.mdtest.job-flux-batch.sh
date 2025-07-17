#!/bin/bash
#FLUX: --job-name=angry-lizard-3544
#FLUX: -N=8
#FLUX: --exclusive
#FLUX: --queue=general-compute
#FLUX: -t=420
#FLUX: --urgency=16

export AKRR_NODES='8'
export AKRR_CORES='96'
export AKRR_CORES_PER_NODE='12'
export AKRR_NETWORK_SCRATCH='/gpfs/scratch/xdtas/edge12core'
export AKRR_LOCAL_SCRATCH='$SLURMTMPDIR'
export AKRR_TASK_WORKDIR='/gpfs/scratch/xdtas/edge12core/xdmod.benchmark.io.mdtest/2018.12.31.13.33.16.469128'
export AKRR_APPKER_DIR='/projects/ccrstaff/general/appker/edge12core'
export AKRR_AKRR_DIR='/gpfs/scratch/xdtas/edge12core'
export AKRR_APPKER_NAME='xdmod.benchmark.io.mdtest'
export AKRR_RESOURCE_NAME='edge12core'
export AKRR_TIMESTAMP='2018.12.31.13.33.16.469128'
export AKRR_APP_STDOUT_FILE='$AKRR_TASK_WORKDIR/appstdout'
export AKRR_APPKERNEL_INPUT='/projects/ccrstaff/general/appker/edge12core/inputs'
export AKRR_APPKERNEL_EXECUTABLE='/projects/ccrstaff/general/appker/edge12core/execs'
export AKRR_NODELIST='`srun -l --ntasks-per-node=$AKRR_CORES_PER_NODE -n $AKRR_CORES hostname -s|sort -n| awk '{printf "%s ",$2}' `'
export PATH='$AKRR_APPKER_DIR/execs/bin:$PATH'
export AKRR_TMP_WORKDIR='`mktemp -d /gpfs/scratch/xdtas/edge12core/namd.XXXXXXXXX`'
export I_MPI_PMI_LIBRARY='/usr/lib64/libpmi.so'
export I_MPI_FABRICS_LIST='tcp'

export AKRR_NODES=8
export AKRR_CORES=96
export AKRR_CORES_PER_NODE=12
export AKRR_NETWORK_SCRATCH="/gpfs/scratch/xdtas/edge12core"
export AKRR_LOCAL_SCRATCH="$SLURMTMPDIR"
export AKRR_TASK_WORKDIR="/gpfs/scratch/xdtas/edge12core/xdmod.benchmark.io.mdtest/2018.12.31.13.33.16.469128"
export AKRR_APPKER_DIR="/projects/ccrstaff/general/appker/edge12core"
export AKRR_AKRR_DIR="/gpfs/scratch/xdtas/edge12core"
export AKRR_APPKER_NAME="xdmod.benchmark.io.mdtest"
export AKRR_RESOURCE_NAME="edge12core"
export AKRR_TIMESTAMP="2018.12.31.13.33.16.469128"
export AKRR_APP_STDOUT_FILE="$AKRR_TASK_WORKDIR/appstdout"
export AKRR_APPKERNEL_INPUT="/projects/ccrstaff/general/appker/edge12core/inputs"
export AKRR_APPKERNEL_EXECUTABLE="/projects/ccrstaff/general/appker/edge12core/execs"
source "$AKRR_APPKER_DIR/execs/bin/akrr_util.bash"
export AKRR_NODELIST=`srun -l --ntasks-per-node=$AKRR_CORES_PER_NODE -n $AKRR_CORES hostname -s|sort -n| awk '{printf "%s ",$2}' `
export PATH="$AKRR_APPKER_DIR/execs/bin:$PATH"
cd "$AKRR_TASK_WORKDIR"
akrr_perform_common_tests
akrr_write_to_gen_info "start_time" "`date`"
akrr_write_to_gen_info "node_list" "$AKRR_NODELIST"
export AKRR_TMP_WORKDIR=`mktemp -d /gpfs/scratch/xdtas/edge12core/namd.XXXXXXXXX`
echo "Temporary working directory: $AKRR_TMP_WORKDIR"
cd $AKRR_TMP_WORKDIR
case $AKRR_NODES in
1)
    ITER=20
    ;;
2)
    ITER=10
    ;;
4)
    ITER=5
    ;;
8)
    ITER=2
    ;;
*)
    ITER=1
    ;;
esac
module load intel/16.0 intel-mpi/5.1.1
module list
ulimit -s unlimited
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi.so
export I_MPI_FABRICS_LIST="tcp"
EXE=/projects/ccrstaff/general/appker/edge12core/execs/mdtest/mdtest
RUNMPI="srun"
appsigcheck.sh $EXE $AKRR_TASK_WORKDIR/.. > $AKRR_APP_STDOUT_FILE
akrr_write_to_gen_info "appkernel_start_time" "`date`"
echo "#Testing single directory" >> $AKRR_APP_STDOUT_FILE 2>&1
$RUNMPI $EXE -v -I 32 -z 0 -b 0 -i $ITER >> $AKRR_APP_STDOUT_FILE 2>&1
echo "#Testing single directory per process" >> $AKRR_APP_STDOUT_FILE 2>&1
$RUNMPI $EXE -v -I 32 -z 0 -b 0 -i $ITER -u >> $AKRR_APP_STDOUT_FILE 2>&1
echo "#Testing single tree directory" >> $AKRR_APP_STDOUT_FILE 2>&1
$RUNMPI $EXE -v -I 4 -z 4 -b 2 -i $ITER >> $AKRR_APP_STDOUT_FILE 2>&1
echo "#Testing single tree directory per process" >> $AKRR_APP_STDOUT_FILE 2>&1
$RUNMPI $EXE -v -I 4 -z 4 -b 2 -i $ITER -u >> $AKRR_APP_STDOUT_FILE 2>&1
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
