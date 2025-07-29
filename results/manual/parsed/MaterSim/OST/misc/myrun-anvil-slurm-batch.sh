#!/bin/bash
#SBATCH --account=dmr180040
#SBATCH --output=%x.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=96G
#SBATCH --time=2-00:30:00
#SBATCH --partition=wholenode
#SBATCH --constraint=ntasks-per-node=128

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
