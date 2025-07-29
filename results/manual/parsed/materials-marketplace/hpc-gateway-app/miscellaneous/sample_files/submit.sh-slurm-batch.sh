#!/bin/bash
#SBATCH --job-name=lammps-colloid
#SBATCH --account=mrcloud
#SBATCH --mail-user=jusong.yu@epfl.ch
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=debug
#SBATCH --constraint=ntasks-per-node=4,mc

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module load daint-mc/20.08
module load LAMMPS/03Mar20-CrayGNU-20.08
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
'srun' '-n' '4' '/apps/daint/UES/jenkins/7.0.UP02/mc/easybuild/software/LAMMPS/03Mar20-CrayGNU-20.08/bin/lmp_mpi' '-in' 'colloid.in'
