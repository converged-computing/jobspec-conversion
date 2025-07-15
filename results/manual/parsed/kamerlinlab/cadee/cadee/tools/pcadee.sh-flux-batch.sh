#!/bin/bash
#FLUX: --job-name=conspicuous-kitty-9257
#FLUX: --urgency=16

export CORES='4'
export MACHINE_NAME='$(hostname)'
export SCRATCH_FOLDER='/tmp'
export BACKUPINTERVAL='540 # DEFAULT: 540, 9 minutes'
export MAXTASK='$(($SLURM_NTASKS/$CORES))'

SLURM_NTASKS=4      # number of cores to use
SLURM_NNODES=1      # number of nodes to use (only 1 supported)
export CORES=4
export MACHINE_NAME="$(hostname)"
export SCRATCH_FOLDER=/tmp
export BACKUPINTERVAL=540 # DEFAULT: 540, 9 minutes
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "This is $MACHINE_NAME. Loading Modules:"
case "$MACHINE_NAME" in
"rackham")
    ml intel/17.1 intelmpi/17.1 python/2.7.11
    export QPATH="/home/fabst747/qsource/bin"
    export EXE="mpiexec -n $CORES -bind-to none $QPATH/Qdyn6p"
    ;;
"abisko")
    if [ $CORES -ne 6 ]
    then
        echo "WARNING: You run a computation with \$CORES=$CORES on abisko."
        echo "This is discouraged. You should run it with 6 CORES."
        exit
    fi
    module -v load pgi/14.3-0
    module -v load openmpi/pgi/1.8.1
    export EXE="srun -n $CORES Qdyn6p"
    ;;
"")
    echo "This job is not running in SNIC environment."
    ;;
*)
    echo "THIS CLUSTER IS UNKNOWN!"
    echo "I will not add modules"
    export EXE="mpiexec -n $CORES $(which Qdyn6p)"
    ;;
esac
echo "Adjusted Q PATH! Executables:"
echo $(/bin/ls $QPATH)
if [ -z "$EXE" ]
then
    echo "FATAL:"
    echo "      You must configure the pcadee script properly."
    echo "      \$EXE is not defined."
    exit 1
fi
if [ -z $SLURM_NTASKS ]
then
    echo "Fatal: Need SLURM environment. Stop."
    exit 1
fi
if [ $SLURM_NNODES -ne 1 ]
then
    echo "FATAL: User Error"
    echo "       This script can distribute jobs to up to 1 nodes, you asked for $SLURM_NNODES ."
    echo "       The scrpit stops now, so you do not waste compute time. Bye!."
    exit 1
fi
if [ -z $1 ]
then
    echo "Fatal: Missing Argument: Folder with Simpacks. Stop."
    echo "Usage:"
    echo "       $0 /path/to/folder/with/simpacks/"
    exit 1
fi
export MAXTASK=$(($SLURM_NTASKS/$CORES))
SIMPACK_FOLDER=$(readlink -f "$1")
echo "Simpack Folder $SIMPACK_FOLDER"
echo "Will use $CORES per simpack."
echo "Will run at most $MAXTASK simpacks at one time."
echo "This will use $(($CORES*$MAXTASK)) cores from $SLURM_NTASKS"
echo ""
echo ""
echo "   Will Distribute Jobs and Start Work in 1 Second"
echo "   ==============================================="
echo ""
sleep 1
find $SIMPACK_FOLDER -name "*.tar" | xargs -i --max-procs=$MAXTASK bash -c "echo {}; $DIR/srunq.sh {}; echo {}; exit"
echo ""
echo ""
echo ""
echo "No Simpacks left. Terminating after $SECONDS."
