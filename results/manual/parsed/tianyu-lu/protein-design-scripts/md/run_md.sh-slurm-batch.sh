#!/bin/bash
#SBATCH --job-name=2_1_L125E
#SBATCH --account=account-name
#SBATCH --mail-user=email@domain.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:2
#SBATCH --mem=0
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=8

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK:-1}'

module purge
module load gcc/7.3.0  openmpi/3.1.2  gromacs/2019.3
export OMP_NUM_THREADS="${SLURM_CPUS_PER_TASK:-1}"
gmx grompp -f nvt.mdp -c em.gro -r em.gro -p 2_1_L125E.pdb.top -n -o nvt.tpr
srun gmx_mpi mdrun -v -s -deffnm nvt
gmx grompp -f npt.mdp -c nvt.gro -r nvt.gro -p 2_1_L125E.pdb.top -n -o npt.tpr
srun gmx_mpi mdrun -v -s -deffnm npt
gmx grompp -f production.mdp -c npt.gro -p 2_1_L125E.pdb.top -o md_0_1.tpr
srun gmx_mpi mdrun -v -s -deffnm md_0_1
