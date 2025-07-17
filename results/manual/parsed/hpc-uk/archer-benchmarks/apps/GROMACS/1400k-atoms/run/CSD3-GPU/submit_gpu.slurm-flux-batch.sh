#!/bin/bash
#FLUX: --job-name=gmx_bench
#FLUX: -n=12
#FLUX: --queue=pascal
#FLUX: -t=10800
#FLUX: --urgency=16

export OMP_NUM_THREADS='${cpucores}'
export I_MPI_PIN_DOMAIN='omp:compact # Domains are $OMP_NUM_THREADS cores in size'
export I_MPI_PIN_ORDER='scatter # Adjacent domains have minimal sharing of caches/sockets'

numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load rhel7/default-gpu
module load gcc/5.3.0
workdir="$SLURM_SUBMIT_DIR"  # The value of SLURM_SUBMIT_DIR sets workdir to the directory
                             # in which sbatch is run.
export OMP_NUM_THREADS=1
np=$[${numnodes}*${mpi_tasks_per_node}]
export I_MPI_PIN_DOMAIN=omp:compact # Domains are $OMP_NUM_THREADS cores in size
export I_MPI_PIN_ORDER=scatter # Adjacent domains have minimal sharing of caches/sockets
cat $0
nodes=1
cpucores=6
casename="benchmark"
mdrun="/home/hpcturn1/software_gpu/gromacs-2016.4/build/bin/gmx mdrun"
timestamp=$(date '+%Y%m%d%H%M')
resfile="${casename}_${nodes}nodes_${timestamp}"
export OMP_NUM_THREADS=${cpucores}
${mdrun} -s ${casename}.tpr -g ${resfile} -noconfout
rm ener.edr
