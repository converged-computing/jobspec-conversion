#!/bin/bash
#FLUX: --job-name="mmm"
#FLUX: --queue=general
#FLUX: --priority=16

module ()
{
    eval `/nfs/apps/Modules/3.2.10/bin/modulecmd bash $*`
}
module load gnu/8.2.0 openmpi/3.1.6_gnu8.2 plumed/2.8.0 gromacs/2021.4
which gmx_mpi
pwd
sim=$PWD
topo=$sim/topo
sim_folder=equil_sim
production_dir=sim_pr
cd $production_dir
mpirun gmx_mpi mdrun    -s md.tpr -cpi md.cpt  -deffnm md
