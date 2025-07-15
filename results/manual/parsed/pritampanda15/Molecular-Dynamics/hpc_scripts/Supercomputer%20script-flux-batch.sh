#!/bin/bash
#FLUX: --job-name=phat-spoon-0908
#FLUX: --exclusive
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='4'

export OMP_NUM_THREADS=4
module load GROMACS/2019.6-nsc1-gcc-7.3.0-bare
echo -e "1\n1" | gmx_mpi pdb2gmx -f *.pdb -o peptide.gro
gmx_mpi editconf -f peptide.gro -o pep_box.gro -c -d 1.0 -bt cubic
gmx_mpi solvate -cp pep_box.gro -cs spc216.gro -o solv.gro -p topol.top
echo -e "13\n1" | gmx_mpi grompp -f ions.mdp -c solv.gro -p topol.top -o ions.tpr -maxwarn -1
gmx_mpi grompp -f minim.mdp -c solv.gro -p topol.top -o em.tpr -maxwarn -1
mpprun --pass="--map-by
ppr:$((16/OMP_NUM_THREADS)):socket:PE=${OMP_NUM_THREADS}" \
	gmx_mpi mdrun -v -deffnm em
	gmx_mpi grompp -f nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr -maxwarn -1
mpprun --pass="--map-by
ppr:$((16/OMP_NUM_THREADS)):socket:PE=${OMP_NUM_THREADS}" \
	gmx_mpi mdrun -deffnm nvt
	gmx_mpi grompp -f npt.mdp -c nvt.gro -r nvt.gro -t nvt.cpt -p topol.top -o npt.tpr -maxwarn -1
mpprun --pass="--map-by
ppr:$((16/OMP_NUM_THREADS)):socket:PE=${OMP_NUM_THREADS}" \
	gmx_mpi mdrun -deffnm npt
	gmx_mpi grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o md_0_1.tpr -maxwarn -1
mpprun --pass="--map-by
ppr:$((16/OMP_NUM_THREADS)):socket:PE=${OMP_NUM_THREADS}" \
	gmx_mpi mdrun -deffnm md_0_1
gmx_mpi trjconv -s md_0_1.tpr -f md_0_1.xtc -o md_0_1_center.xtc -center -pbc mol -ur compact
