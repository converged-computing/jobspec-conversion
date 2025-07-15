#!/bin/bash
#FLUX: --job-name=blank-snack-7361
#FLUX: -t=86400
#FLUX: --priority=16

module load cmake/3.25.0 intel/2020 intel-rtl/2020 ffmpeg/4.2.1 openmpi/4.1.0-intel hdf5/1.10.7-intel-mpi
conda activate ost
CODE=$SLURM_JOB_NAME
NODE=$SLURM_JOB_NUM_NODES
PER=$SLURM_TASKS_PER_NODE
LMPCMD="'srun --mpi=pmix_v3 -n 192 /users/qzhu8/GitHub/lammps/build_cpu_intel/lmp -in cycle.in > cycle.out'"
CMD="python demo_mt.py -d dataset/mech.db -c ${CODE} -n ${NODE} -p ${PER} -l ${LMPCMD} > log_${CODE}"
echo $CMD
eval $CMD
