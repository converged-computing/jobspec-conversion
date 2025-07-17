#!/bin/bash
#FLUX: --job-name=sdp-iotest
#FLUX: --exclusive
#FLUX: --queue=skylake
#FLUX: -t=1800
#FLUX: --urgency=16

export I_MPI_JOB_RESPECT_PROCESS_PLACEMENT='0'
export I_MPI_PIN_DOMAIN='omp:compact'
export OMP_NUM_THREADS='$num_threads'
export OMP_PROC_BIND='true'
export OMP_PLACES='sockets'

num_threads=$1
outdir=$DW_JOB_STRIPED
workdir=$HOME/cam/imaging-iotest/src
if [ -z "$2" ]; then
    freq_chunk=128
else
    freq_chunk=$2
fi
if [ -z "$3" ]; then
    time_chunk=128
else
    time_chunk=$3
fi
options="--rec-set=128k-32k-2k" # 256 GiB, 25 facets
options+=" --vis-set=lowbd2 --time=-460:460/512/$time_chunk --freq=260e6:300e6/8192/$freq_chunk"
facet_workers=$[1*${SLURM_JOB_NUM_NODES}]
options+=" --facet-workers=$facet_workers --send-queue=32 --subgrid-queue=128"
options+=" --source-count=10"
if [ ! -z "$outdir" ]; then
    options+=" $outdir/out%d.h5"
fi
export I_MPI_JOB_RESPECT_PROCESS_PLACEMENT=0
MAPPING_PARAMS="-ppn 1 -np $SLURM_NTASKS"
CMD="mpirun -prepend-rank $MCA_PARAMS $MAPPING_PARAMS $workdir/iotest $options"
export I_MPI_PIN_DOMAIN=omp:compact
export OMP_NUM_THREADS=$num_threads
export OMP_PROC_BIND=true
export OMP_PLACES=sockets
cd $workdir
echo -e "JobID: $SLURM_JOB_ID\n======"
echo "Time: `date`"
echo "Running on master node: `hostname`"
echo "Current directory: `pwd`"
echo "Output directory: $outdir"
echo -e "OMP_PROC_BIND=$OMP_PROC_BIND, OMP_PLACES=$OMP_PLACES"
echo -e "\nnumtasks=$SLURM_NTASKS, numnodes=$SLURM_JOB_NUM_NODES, OMP_NUM_THREADS=$OMP_NUM_THREADS"
df -h $outdir
if [ ! -z $outdir ]; then
    echo -e "\n==================\nCleaning $outdir...\n"
    if [ $SLURM_NODEID = 0 ]; then
        mkdir -p $outdir
        rm -f $outdir/out*.h5
    fi
    df -h $outdir
    sleep 2
fi
echo -e "\nExecuting command:\n==================\n$CMD\n"
eval $CMD
echo -e "\n=================="
echo "Finish time: `date`"
if [ ! -z "$outdir" -a $SLURM_NODEID = 0 ]; then
    echo -e "\n==================\nCleaning $outdir...\n"
    df -h $outdir
    rm -f $outdir/out*.h5
fi
