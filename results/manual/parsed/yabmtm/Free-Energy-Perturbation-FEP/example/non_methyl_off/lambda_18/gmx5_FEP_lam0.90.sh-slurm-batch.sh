#!/bin/bash
#SBATCH --job-name=g_methyl_lam0.90.pf
#SBATCH --account=TG-MCB140270
#SBATCH --output=g_methyl_lam0.90.%j.out
#SBATCH --error=errors.%j.out
#SBATCH --mail-user=tud16919@temple.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu

export OMP_NUM_THREADS='16'

module load boost
module load gromacs/5.0.4
module load cuda/6.0
export OMP_NUM_THREADS=16
mdrun_gpu -s topol.tpr -maxh 23.5
