#!/bin/bash
#FLUX: --job-name=fuzzy-lettuce-6714
#FLUX: --queue=wholenode
#FLUX: -t=174600
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

module purge
module load gcc
module load openmpi
conda activate ost
export OMP_NUM_THREADS=1
CODE=$SLURM_JOB_NAME
NODE=$SLURM_JOB_NUM_NODES
PER=$SLURM_TASKS_PER_NODE
LMPCMD="'srun --mpi=pmi2 -n 384 --cpus-per-task=1 ~/Github/lammps/src/lmp_mpi -in cycle.in > cycle.out'"
CMD="python demo_mt.py -d dataset/mech.db -c ${CODE} -n ${NODE} -p ${PER} -l ${LMPCMD} > log_${CODE}"
echo $CMD
eval $CMD
