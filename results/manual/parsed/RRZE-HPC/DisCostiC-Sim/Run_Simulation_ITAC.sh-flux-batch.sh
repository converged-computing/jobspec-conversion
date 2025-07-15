#!/bin/bash
#FLUX: --job-name=discostic
#FLUX: -N=2
#FLUX: --queue=multinode
#FLUX: -t=3600
#FLUX: --priority=16

export VT_LOGFILE_FORMAT='SINGLESTF'
export VT_LOGFILE_NAME='simulation'
export VT_LOGFILE_PREFIX='$SLURM_SUBMIT_DIR'
export VT_FLUSH_PREFIX='/tmp'

unset SLURM_EXPORT_ENV 
echo "Starting: $(date)"
export 
cd $SLURM_SUBMIT_DIR
module load python git intel cmake intelmpi likwid itac
module list
conda activate XYZ
PROCNUMBERS=$(cat config.cfg | grep "number_of_processes" | head -1 | sed 's/[^0-9]*//g')
PROCNUMBERS=$(( PROCNUMBERS + 1 ))
export VT_LOGFILE_FORMAT=SINGLESTF
export VT_LOGFILE_NAME=simulation
export VT_LOGFILE_PREFIX=$SLURM_SUBMIT_DIR
export VT_FLUSH_PREFIX=/tmp
MODE=$(cat config.cfg | grep "kernel_mode" | cut -d"=" -f 2 | cut -d"#" -f 1 | tr -d ' ')
FILENAME=$(cat config.cfg | grep "benchmark_kernel" | cut -d"=" -f 2 | cut -d"#" -f 1 | tr -d ' ')
FILEMODE=$FILENAME"_"$MODE".hpp"
FILEMODE=$(echo $FILEMODE | tr -d " ")
if test -f "./test/$FILEMODE"; then
    cp ./test/$FILEMODE ./test/P2P.hpp
else
    echo ""
    echo "TestCase not present !!"
    echo "Exiting from Simulation !!"
    exit 1
fi
HETEROGENEOUS=$(cat config.cfg | grep "heteregeneous" | cut -d"#" -f1 $1 | sed 's/[^0-9]*//g')
if [ "$HETEROGENEOUS" -eq "0" ]; then
    TOTALPROCS=$(( $PROCNUMBERS ))
else
    SECONDARYSYSTEMNUMBERPROCS=$(cat config.cfg | grep "secondary_number_of_processes" | sed 's/[^0-9]*//g')
    TOTALPROCS=$(( $PROCNUMBERS+$SECONDARYSYSTEMNUMBERPROCS ))
fi
srun -n $TOTALPROCS ./discostic
