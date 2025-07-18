#!/bin/bash
#FLUX: --job-name=REMD-stage2
#FLUX: -t=60
#FLUX: --urgency=16

export GMXLIB='/project/projects/def-plotkin/shared_projects:/cvmfs/soft.computecanada.ca/easybuild/software/2017/avx2/MPI/intel2016.4/openmpi2.1/gromacs/4.6.7/share/gromacs/top'

module load gromacs/4.6.7
export GMXLIB=/project/projects/def-plotkin/shared_projects:/cvmfs/soft.computecanada.ca/easybuild/software/2017/avx2/MPI/intel2016.4/openmpi2.1/gromacs/4.6.7/share/gromacs/top
append=""
	(for dir in equil{1..32}; do cd $dir; grompp$append -f nvt.mdp -c prot-solv-ion-em.gro -p topol.top -o nvt.tpr; cd ..; done)
        srun mdrun_mpi -s nvt.tpr -o nvt.trr -c prot-solv-ion-em-nvt.gro -g nvt.log -e nvt.edr -v -multidir equil{1..32}
        # Equilibrate solvent to set pressure
	(for dir in equil{1..32}; do cd $dir; grompp$append -f npt.mdp -c prot-solv-ion-em-nvt.gro -t state.cpt -p topol.top -o npt.tpr; cd ..; done)
        srun mdrun_mpi -s npt.tpr -o npt.trr -c prot-solv-ion-em-nvt-npt.gro -g npt.log -e npt.edr -v -multidir equil{1..32}
        # Equilibrate entire system
