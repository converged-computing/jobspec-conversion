#!/bin/bash
#FLUX: --job-name=milky-chip-8347
#FLUX: --exclusive
#FLUX: --urgency=16

export parent='/pfs/nobackup/home/p/pojedama/benchmarks/charmm-gui/gromacs'

ml purge
ml GCC/8.2.0-2.31.1  CUDA/10.1.105  OpenMPI/3.1.3
ml GROMACS/2019.2
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
    mdargs="-ntomp $SLURM_CPUS_PER_TASK"
else
    mdargs="-ntomp 1"
fi
export parent=/pfs/nobackup/home/p/pojedama/benchmarks/charmm-gui/gromacs
mkdir /scratch/test
rsync -avzh $parent/scratch/ /scratch/test/
cd /scratch/test 
gmx grompp -f step4.1_equilibration.mdp -o step4.1_equilibration.tpr -c step4.0_minimization.gro -r step3_charmm2gmx.pdb -n index.ndx -p topol.top
gmx mdrun -ntmpi 4 $mdargs -deffnm step4.1_equilibration
cd $parent
rsync -avzh /scratch/test/ $parent/scratch/
rm -rf /scratch/test
exit 0
