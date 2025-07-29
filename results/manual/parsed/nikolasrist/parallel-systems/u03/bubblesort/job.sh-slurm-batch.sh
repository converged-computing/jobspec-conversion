#!/bin/bash
#SBATCH --output=slurm.%N.%j.out
#SBATCH --error=slurm.%N.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=3-00:00:00
#SBATCH --partition=hpc

export PIN_ON_SOCKET='$PORT'

set -x
module load gcc pin dinero4
TOOL=/usr/local/pin/pin-3.7/source/tools/memtrace/obj-intel64/memtrace.so
echo "Running with PORT=$PORT,PROGRAM=$PROGRAM,PROGRAM_ARGS=$PROGRAM_ARGS,DIR=$DIR,FILE=$FILE,DINERO_ARGS=$DINERO_ARGS" >&2
mkdir -p output/$DIR
cd output/$DIR
export PIN_ON_SOCKET=$PORT
ulimit -s 10000000
pin -t $TOOL -- $SLURM_SUBMIT_DIR/$PROGRAM $PROGRAM_ARGS &
sleep 10
time memtrace_client.exe localhost $PIN_ON_SOCKET | \
	 dineroIV $DINERO_ARGS > $FILE
exit
