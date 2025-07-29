#!/bin/bash
#SBATCH --job-name=fst_epoch{epoch_number}
#SBATCH --account=project_<1234567>
#SBATCH --output=output.txt
#SBATCH --mail-user=<erkki.esimerkki@domain.com>
#SBATCH --mail-type=END
#SBATCH --nodes=20
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-12:00:00
#SBATCH --constraint=ntasks-per-node=128

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export OMP_PLACES='cores'

module load gcc/9.4.0
module load openmpi/4.1.2
module load gromacs/2020.5
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_PLACES=cores
srun gmx_mpi mdrun  -deffnm mdrun -multidir rep* -maxh 36
