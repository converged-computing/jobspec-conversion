#!/bin/bash
#FLUX: --job-name=strawberry-knife-2797
#FLUX: --priority=16

export OMP_NUM_THREADS='$ntomp'

ml purge
ml ABINIT/8.10.3 Armadillo/9.700.2 CDO/1.9.5 GOTM/5.3-221-gac7ec88d NCO/4.8.1 NCO/4.9.2 OpenFOAM/6 OpenFOAM/7 OpenFOAM/v1912 Rosetta/3.7 Siesta/4.1-MaX-1.0 Siesta/4.1-b4 Singular/4.1.2 XCrySDen/1.5.60 XCrySDen/1.6.2 deal.II/9.1.1-gcc deal.II/9.1.1-intel
ml gromacs/2019.6.th
gmx grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o md_0_1.tpr
if [ $SLURM_JOB_NUM_NODES -gt 1 ]; then
    GMX="gmx_mpi"
    MPIRUN="mpirun"
    ntmpi=""
else
    GMX="gmx"
    MPIRUN=""
    ntmpi="-ntmpi $SLURM_NTASKS"
fi
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
    ntomp="$SLURM_CPUS_PER_TASK"
else
    ntomp="1"
fi
export OMP_NUM_THREADS=$ntomp
$MPIRUN $GMX mdrun $ntmpi -ntomp $ntomp -deffnm md_0_1
