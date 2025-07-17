#!/bin/bash
#FLUX: --job-name=bloated-soup-8049
#FLUX: -N=4
#FLUX: -c=16
#FLUX: --queue=hpib
#FLUX: --urgency=16

export FI_PROVIDER='verbs'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export FI_PROVIDER=verbs
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load lammps/201812/lmp_intelcpu_intelmpi
srun -n $SLURM_NTASKS --cpu-bind=cores lmp_intelcpu_intelmpi -in in.8sinter_1.lmp -sf intel -pk intel 0 omp $OMP_NUM_THREADS mode double
