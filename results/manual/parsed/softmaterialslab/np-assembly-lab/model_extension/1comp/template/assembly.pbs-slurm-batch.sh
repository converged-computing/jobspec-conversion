#!/bin/bash
#SBATCH --job-name=USERVLP_USERSALTCONC
#SBATCH --account=r00312
#SBATCH --output=out.log
#SBATCH --error=err.log
#SBATCH --mail-user=cfaccini@iu.edu
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=03:00:00
#SBATCH --constraint=ntasks-per-node=48

module load lammps/29Oct20
cd      $SLURM_SUBMIT_DIR
time srun -n 48 lmp_mpi < in.1comp.template
