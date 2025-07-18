#!/bin/bash
#FLUX: --job-name=NPB_BT-MZ
#FLUX: --exclusive
#FLUX: --queue=cpu_dev
#FLUX: -t=600
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

echo "Cluster configuration:"
echo "==="
echo "Partition: " $SLURM_JOB_PARTITION
echo "Number of nodes: " $SLURM_NNODES
echo "Number of MPI processes: " $SLURM_NTASKS " (" $SLURM_NNODES " nodes)"
echo "Number of MPI processes per node: " $SLURM_NTASKS_PER_NODE
echo "Number of threads per MPI process: " $SLURM_CPUS_PER_TASK
echo "NPB Benchmark: " $1
echo "Bechmark class problem: " $2
module load openmpi/gnu/2.0.4.2
module load hpctoolkit/5.3.2_4712
module load papi/5.5.1.0
module load papi-devel/5.5.1.0
bench=${1}
class=${2}
executable="${bench}.${class}.$SLURM_NTASKS"
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
srun --resv-ports -n $SLURM_NTASKS \
hpcrun -t -e WALLCLOCK@5000 \
./${executable}
hpcstruct ${executable}
hpcprof \
 -I ../BT-MZ/+ \
 -S ${executable}.hpcstruct hpctoolkit-${executable}-measurements-${SLURM_JOBID}
hpctoolkitresultdir=profiling/hpctoolkit/NUMNODES-$SLURM_JOB_NUM_NODES/${bench}_${class}_MPI-${SLURM_NTASKS}_OMP-${SLURM_CPUS_PER_TASK}_JOBID-${SLURM_JOBID}
mkdir -p ${hpctoolkitresultdir}
mv slurm-${SLURM_JOBID}.out ${hpctoolkitresultdir}/
mv hpctoolkit-${executable}-database-${SLURM_JOBID} ${hpctoolkitresultdir}/
mv hpctoolkit-${executable}-measurements-${SLURM_JOBID} ${hpctoolkitresultdir}/
mv ${executable}.hpcstruct ${hpctoolkitresultdir}/
