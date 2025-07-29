#!/bin/bash
#FLUX: --job-name=2_1_L125E
#FLUX: -N=2
#FLUX: -c=4
#FLUX: -t=172800
#FLUX: --urgency=16

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
