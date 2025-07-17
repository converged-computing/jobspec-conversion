#!/bin/bash
#FLUX: --job-name=hairy-peanut-9314
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --queue=arm8xlarge
#FLUX: --urgency=16

export HPCC_VERSION='1.5.0'
export OMP_NUM_THREADS='1'

export HPCC_VERSION=1.5.0
PREFIX=/fsx
source ${PREFIX}/scripts/env.sh 7 1
LOGDIR=${PREFIX}/log
HPCC_LOG=${LOGDIR}/mpirun_${SARCH}_${HPC_COMPILER}_${HPC_MPI}_hpcc-${HPCC_VERSION}.log
mkdir -p ${LOGDIR}
JOBDIR=${PREFIX}/spooler/hpcc
mkdir -p ${JOBDIR}
cd ${JOBDIR}
if [ "X$SLURM_JOB_NUM_NODES" = "X" ]
then
        SLURM_JOB_NUM_NODES=1
fi
if [ "X$MPI_NUM_THREADS" = "X" ]
then
        MPI_NUM_THREADS=$(($(nproc) * $SLURM_JOB_NUM_NODES))
fi
echo $SLURM_JOB_NUM_NODES >> /fsx/log/slurm.log
PQ=0
P=$(echo "scale=0;sqrt($MPI_NUM_THREADS)" |bc -l)
SYS_MEMORY_MB=$(free -m | grep ^Mem: | awk '{print $2}')
Q=$P
PQ=$(($P*$Q))
while [ $PQ -ne $MPI_NUM_THREADS ]; do
    Q=$(($MPI_NUM_THREADS/$P))
    PQ=$(($P*$Q))
    if [ $PQ -ne $MPI_NUM_THREADS ] && [ $P -gt 1 ]; then P=$(($P-1)); fi
done
if [ "X$N" = "X" ] || [ "X$NB" = "X" ]
then
        # SYS_MEMORY * about .62% of that, go from MB to bytes and divide by 8
        N=$(echo "scale=0;sqrt(${SYS_MEMORY_MB}*${SLURM_JOB_NUM_NODES}*0.62*1048576/8)" |bc -l)
        NB=$((256 - 256 % $MPI_NUM_THREADS))
        N=$(($N - $N % $NB))
fi
echo "HPLinpack benchmark input file
Innovative Computing Laboratory, University of Tennessee
HPL.out      output file name (if any)
6            device out (6=stdout,7=stderr,file)
1            # of problems sizes (N)
$N
1            # of NBs
$NB          NBs
0            PMAP process mapping (0=Row-,1=Column-major)
1            # of process grids (P x Q)
$P           Ps
$Q           Qs
16.0         threshold
1            # of panel fact
2            PFACTs (0=left, 1=Crout, 2=Right)
1            # of recursive stopping criterium
4            NBMINs (>= 1)
1            # of panels in recursion
2            NDIVs
1            # of recursive panel fact.
2            RFACTs (0=left, 1=Crout, 2=Right)
1            # of broadcast
1            BCASTs (0=1rg,1=1rM,2=2rg,3=2rM,4=Lng,5=LnM)
1            # of lookahead depth
0            DEPTHs (>=0)
1            SWAP (0=bin-exch,1=long,2=mix)
64           swapping threshold
0            L1 in (0=transposed,1=no-transposed) form
0            U  in (0=transposed,1=no-transposed) form
1            Equilibration (0=no,1=yes)
8            memory alignment in double (> 0)
0                               Number of additional problem sizes for PTRANS
1200 10000 30000                values of N
0                               number of additional blocking sizes for PTRANS
40 9 8 13 13 20 16 32 64        values of NB
" > HPL.dat
cp HPL.dat hpccinf.txt
ulimit -s unlimited
export OMP_NUM_THREADS=1
HPC_MPI_DEBUG=1
source ${PREFIX}/scripts/mpi_settings.sh
echo "Running hpcc on $(date)"
START_DATE=$(date)
echo "zzz *** ${START_DATE} *** - JobStart - hpcc - ${HPC_COMPILER} - ${HPC_MPI}" >> ${HPCC_LOG} 2>&1
ln -sfn ${HPC_PREFIX}/${HPC_COMPILER}/${HPC_MPI}/hpcc-${HPCC_VERSION}/hpcc .
mpirun -n ${MPI_NUM_THREADS} ${MPI_SHOW_BIND_OPTS} ./hpcc >> ${HPCC_LOG} 2>&1
mv hpccoutf.txt hpccoutf_$(date +'%Y-%m-%d_%H-%M-%S').txt
END_DATE=$(date)
echo "zzz *** ${END_DATE} *** - JobEnd - hpcc - ${HPC_COMPILER} - ${HPC_MPI}" >> ${HPCC_LOG} 2>&1
JOB_FINISH_TIME=$(($(date -d "${END_DATE}" +%s)-$(date -d "${START_DATE}" +%s)))
echo "zzz *** $(date) *** - Job hpcc took ${JOB_FINISH_TIME} seconds($(echo "scale=5;${JOB_FINISH_TIME}/3600" | bc) hours)." >> ${HPCC_LOG} 2>&1
