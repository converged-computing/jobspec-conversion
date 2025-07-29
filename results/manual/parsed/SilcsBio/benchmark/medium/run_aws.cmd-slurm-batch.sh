#!/bin/bash
#FLUX: --job-name=m_202X.Y
#FLUX: -n=8
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

export GMX_MAXBACKUP='-1'

nproc=8
GMXDIR="/shared/apps/gromacs/2021.4/bin"
charmmff="charmm36.ff"
mpirun="mpirun --leave-session-attached"
mdrun="${GMXDIR}/gmx mdrun -nt $nproc"  # gmx mdrun command
env
nvidia-smi
export GMX_MAXBACKUP=-1
$GMXDIR/gmx grompp -f emin.mdp -c p38a.pdb -p p38a.top -o min -r p38a.pdb -maxwarn 4
$mdrun -deffnm min -c min.pdb
$GMXDIR/gmx grompp -f equil.mdp -c min.pdb -p p38a.top -o equil -r p38a.pdb -maxwarn 4
$mdrun -deffnm equil -c equil.pdb
$GMXDIR/gmx grompp -f prod.mdp -c equil.pdb -p p38a.top -o prod -r p38a.pdb -maxwarn 4
$mdrun -deffnm prod -c prod.pdb
