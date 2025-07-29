#!/bin/bash
#FLUX: --job-name=gmx_bench
#FLUX: -n=32
#FLUX: --queue=skylake
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export I_MPI_PIN_DOMAIN='omp:compact # Domains are $OMP_NUM_THREADS cores in size'
export I_MPI_PIN_ORDER='scatter # Adjacent domains have minimal sharing of caches/sockets'

numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load rhel7/default-peta4                   # REQUIRED - loads the basic environment
module load gcc-7.2.0-gcc-4.8.5-pqn7o2k
workdir="$SLURM_SUBMIT_DIR"  # The value of SLURM_SUBMIT_DIR sets workdir to the directory
                             # in which sbatch is run.
export OMP_NUM_THREADS=1
np=$[${numnodes}*${mpi_tasks_per_node}]
export I_MPI_PIN_DOMAIN=omp:compact # Domains are $OMP_NUM_THREADS cores in size
export I_MPI_PIN_ORDER=scatter # Adjacent domains have minimal sharing of caches/sockets
cat $0
nodes=1
casename="benchmark"
cpn=32
mdrun="/home/hpcturn1/software/gromacs-2016.4/build_mpi1/bin/mdrun_mpi"
cores=$(( nodes * cpn ))
timestamp=$(date '+%Y%m%d%H%M')
resfile="${casename}_${nodes}nodes_${timestamp}"
MPI_LAUNCH=mpirun
${MPI_LAUNCH} -n ${cores} -ppn ${cpn} ${mdrun} -s ${casename}.tpr -g ${resfile} -noconfout
rm ener.edr
