#!/bin/bash
#FLUX: --job-name=10Mg7
#FLUX: -c=8
#FLUX: -t=7200
#FLUX: --urgency=16

module purge
module load gcc/8.4.1
module load cuda/11.2
module load openmpi/4.1.1-cuda
module load gromacs/2022.2-mpi-cuda
gmx_mpi grompp -f eql2.mdp -c ../../NVT/eql.gro -p ../../prepare_system/topol.top -o eql2.tpr -pp eql2.top -po eql2.mdp 
srun gmx_mpi mdrun -s eql2.tpr -o eql2.trr -x eql2.xtc -c eql2.gro -e eql2.edr -g eql2.log -ntomp ${SLURM_CPUS_PER_TASK}
gmx_mpi grompp -f prd.mdp -c eql2.gro -p ../../prepare_system/topol.top -o prd.tpr -pp prd.top -po prd.mdp
srun gmx_mpi mdrun -s prd.tpr -o prd.trr -x prd.xtc -c prd.gro -e prd.edr -g prd.log -ntomp ${SLURM_CPUS_PER_TASK}
