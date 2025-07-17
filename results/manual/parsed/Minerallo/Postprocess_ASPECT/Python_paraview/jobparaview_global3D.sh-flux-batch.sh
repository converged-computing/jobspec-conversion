#!/bin/bash
#FLUX: --job-name=frigid-citrus-4945
#FLUX: --urgency=16

export SRUN_CPUS_PER_TASK='$SLURM_CPUS_PER_TASK'

module load gcc/9.2.0 openmpi/gcc.9 anaconda3 llvm/9.0.0 paraview
export SRUN_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK
mpirun --map-by socket:pe=$OMP_NUM_THREADS pvbatch /scratch/usr/bbkponsm/model/globalscale/Potsprocess/postprocess_scripts/Model_extract_global_3D_auto.py
