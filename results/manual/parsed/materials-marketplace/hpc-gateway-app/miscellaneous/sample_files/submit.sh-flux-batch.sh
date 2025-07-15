#!/bin/bash
#FLUX: --job-name="lammps-colloid"
#FLUX: --queue=debug
#FLUX: -t=600
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module load daint-mc/20.08
module load LAMMPS/03Mar20-CrayGNU-20.08
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
'srun' '-n' '4' '/apps/daint/UES/jenkins/7.0.UP02/mc/easybuild/software/LAMMPS/03Mar20-CrayGNU-20.08/bin/lmp_mpi' '-in' 'colloid.in'
