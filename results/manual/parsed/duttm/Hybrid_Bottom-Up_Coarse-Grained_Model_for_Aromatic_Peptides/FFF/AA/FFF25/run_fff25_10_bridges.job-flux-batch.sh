#!/bin/bash
#FLUX: --job-name=BRIDGES_fff25_200
#FLUX: --queue=RM
#FLUX: -t=172800
#FLUX: --priority=16

export I_MPI_JOB_RESPECT_PROCESS_PLACEMENT='0'

set echo
set -x
source /opt/packages/gromacs-CPU-2018/bin/GMXRC.bash
module load gromacs/2018_cpu
module mpi/pgi_openmpi/19.10
cd $SLURM_SUBMIT_DIR
export  I_MPI_JOB_RESPECT_PROCESS_PLACEMENT=0
rsync -aP $PWD $LOCAL/
mpirun -np $SLURM_NPROCS gmx_mpi grompp -f minim.mdp -c fff25.gro -p topol.top -o fff25em.tpr
mpirun -np $SLURM_NPROCS gmx_mpi mdrun -v -deffnm fff25em
mpirun -np $SLURM_NPROCS gmx_mpi solvate -cp fff25em.gro -cs spc216.gro -o fff25_solv.gro -p topol.top
mpirun -np $SLURM_NPROCS gmx_mpi grompp -f minim.mdp -c fff25_solv.gro -p topol.top -o fff25_solv_em.tpr
mpirun -np $SLURM_NPROCS gmx_mpi mdrun -v -deffnm fff25_solv_em
mpirun -np $SLURM_NPROCS gmx_mpi grompp -f nvt.mdp -c fff25_solv_em.gro -r fff25_solv_em.gro -p topol.top -o nvt.tpr
mpirun -np $SLURM_NPROCS gmx_mpi mdrun -v -deffnm nvt
mpirun -np $SLURM_NPROCS gmx_mpi grompp -f npt.mdp -c nvt.gro -r nvt.gro -t nvt.cpt -p topol.top -o npt.tpr
mpirun -np $SLURM_NPROCS gmx_mpi mdrun -v -deffnm npt
mpirun -np $SLURM_NPROCS gmx_mpi grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o md_200.tpr
mpirun -np $SLURM_NPROCS gmx_mpi mdrun -v -deffnm md_200
rsync -aP $LOCAL/ /pylon5/mr560ip/hooten/fff25_200/output
sacct --format MaxRSS,Elapsed -j $SLURM_JOBID
