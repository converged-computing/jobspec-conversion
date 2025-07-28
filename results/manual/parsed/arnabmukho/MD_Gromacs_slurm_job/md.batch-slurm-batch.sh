#!/bin/bash
#FLUX: --job-name=gromacs_md
#FLUX: -c=2
#FLUX: --queue=xyz
#FLUX: -t=259200
#FLUX: --urgency=16

export OMP_NUM_THREADS='32'
export OMP_PLACES='cores'
export OMP_PROC_BIND='spread'
export UCX_NET_DEVICES='mlx5_0:1'

module purge
module load  apps/gromacs/2020.3/mpich+gcc_10.2.0/gpu        # Depends on availble module of gromacs in the server
export OMP_NUM_THREADS=32
export OMP_PLACES=cores
export OMP_PROC_BIND=spread
export UCX_NET_DEVICES=mlx5_0:1
cd $SLURM_SUBMIT_DIR
mpirun -np 40 gmx_mpi grompp -f minimization.mdp -c input.gro -r input.gro -p topol.top -o em.tpr && gmx_mpi mdrun -deffnm em && gmx_mpi grompp -f  equilibration.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr -n index.ndx && gmx_mpi mdrun -deffnm nvt && gmx_mpi grompp -f npt.mdp -c nvt.gro -r nvt.gro -t nvt.cpt -p topol.top -o npt.tpr -n index.ndx && gmx_mpi mdrun -deffnm npt && gmx_mpi grompp -f production.mdp -c npt.gro -t npt.cpt -p topol.top -o md_new.tpr -n index.ndx && gmx_mpi mdrun -deffnm md_new
