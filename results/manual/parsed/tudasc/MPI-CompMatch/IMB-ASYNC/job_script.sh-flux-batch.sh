#!/bin/bash
#FLUX: --job-name=MPI-ASYNC-BENCHMARK
#FLUX: -n=2
#FLUX: -c=96
#FLUX: -t=300
#FLUX: --priority=16

export OMPI_MCA_osc='ucx'
export OMPI_MCA_pml='ucx'
export UCX_WARN_UNUSED_ENV_VARS='n'
export UCX_UNIFIED_MODE='y'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/home/tj75qeje/mpi-comp-match/IMB-ASYNC/src_cpp/ASYNC/thirdparty/lib/'

OUTPATH=/work/scratch/tj75qeje/mpi-comp-match/output/measurement_$SLURM_NPROCS
NUM_PARAMS=12
TIMEOUT_CMD="/usr/bin/timeout -k 120 120"
ml purge
ml gcc/8.3.1
ml hwloc/2.5.0 clang/11.1.0
ml openucx/1.12.0
export OMPI_MCA_osc=ucx
export OMPI_MCA_pml=ucx
export UCX_WARN_UNUSED_ENV_VARS=n
export UCX_UNIFIED_MODE=y
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/tj75qeje/mpi-comp-match/IMB-ASYNC/src_cpp/ASYNC/thirdparty/lib/
mkdir -p $OUTPATH
MOD=$(( SLURM_ARRAY_TASK_ID % 4 ))
MOD_PARAM=$(( ((SLURM_ARRAY_TASK_ID / 4 ) % NUM_PARAMS ) + 1 ))
PARAM=$(sed "${MOD_PARAM}q;d" /home/tj75qeje/mpi-comp-match/IMB-ASYNC/parameters.txt)
CALCTIME=$(echo $PARAM | cut -d' ' -f2)
if [[ "$MOD" -eq 0 ]]; then
ml openmpi/normal
$TIMEOUT_CMD srun ./IMB-ASYNC_orig async_persistentpt2pt -cper10usec 64 -workload calc -thread_level single -datatype char -ncycles 64 -nwarmup 10 $PARAM -output $OUTPATH/normal_calctime_${CALCTIME}.$SLURM_JOB_ID.$SLURM_ARRAY_TASK_ID.$I.yaml >& /dev/null
elif [[ "$MOD" -eq 1 ]]; then
ml openmpi/rendevouz1
$TIMEOUT_CMD srun ./IMB-ASYNC async_persistentpt2pt -cper10usec 64 -workload calc -thread_level single -datatype char -ncycles 64 -nwarmup 10 $PARAM -output $OUTPATH/rendevouz1_calctime_${CALCTIME}.$SLURM_JOB_ID.$SLURM_ARRAY_TASK_ID.$I.yaml >& /dev/null
elif [[ "$MOD" -eq 2 ]]; then
ml openmpi/rendevouz2
$TIMEOUT_CMD srun ./IMB-ASYNC async_persistentpt2pt -cper10usec 64 -workload calc -thread_level single -datatype char -ncycles 64 -nwarmup 10 $PARAM -output $OUTPATH/rendevouz2_calctime_${CALCTIME}.$SLURM_JOB_ID.$SLURM_ARRAY_TASK_ID.$I.yaml >& /dev/null
else
ml openmpi/eager
$TIMEOUT_CMD srun ./IMB-ASYNC async_persistentpt2pt -cper10usec 64 -workload calc -thread_level single -datatype char -ncycles 64 -nwarmup 10 $PARAM -output $OUTPATH/eager_calctime_${CALCTIME}.$SLURM_JOB_ID.$SLURM_ARRAY_TASK_ID.$I.yaml >& /dev/null
fi
