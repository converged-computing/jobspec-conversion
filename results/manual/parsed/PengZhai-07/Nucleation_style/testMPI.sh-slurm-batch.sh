#!/bin/bash
#SBATCH --job-name=test_MPI
#SBATCH --account=yiheh1
#SBATCH --output=log/%x-%a.log
#SBATCH --error=log/error-%x-%a.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=5gb
#SBATCH --time=2-00:00:00
#SBATCH --array=20

export MPIRUN_OPTIONS='--bind-to core --map-by node:PE=${SLURM_CPUS_PER_TASK} -report-bindings'
export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'
export NUM_CORES='${SLURM_NTASKS}*${SLURM_CPUS_PER_TASK}'

date
echo "$SLURM_ARRAY_TASK_ID"
module load gcc/10.3.0
module load ${MPI_MODULE}
module list
export MPIRUN_OPTIONS="--bind-to core --map-by node:PE=${SLURM_CPUS_PER_TASK} -report-bindings"
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
export NUM_CORES=${SLURM_NTASKS}*${SLURM_CPUS_PER_TASK}
echo "${EXECUTABLE} running on ${NUM_CORES} cores with ${SLURM_NTASKS} MPI-tasks and ${OMP_NUM_THREADS} threads"
startexe="mpirun -n ${SLURM_NTASKS} ${MPIRUN_OPTIONS} ${EXECUTABLE} ${FILE} ${SLURM_ARRAY_TASK_ID} ${TEST}"
echo $startexe
exec $startexe
