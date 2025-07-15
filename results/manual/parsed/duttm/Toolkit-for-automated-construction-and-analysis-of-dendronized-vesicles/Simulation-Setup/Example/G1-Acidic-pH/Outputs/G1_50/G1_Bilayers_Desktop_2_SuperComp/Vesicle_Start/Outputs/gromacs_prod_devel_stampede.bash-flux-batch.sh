#!/bin/bash
#FLUX: --job-name=sticky-latke-1095
#FLUX: --urgency=16

tar xvf package.tar.gz
module load gromacs
STAMPEDE2PROCS=512
MPI_GMX_EXEC=/opt/apps/intel18/impi18_0/gromacs/2018.3/bin/gmx_knl
MPI_MDRUN_EXEC=/opt/apps/intel18/impi18_0/gromacs/2018.3/bin/mdrun_mpi_knl
extra_pins="-pin on -resethway"
start=26
skip=2
i=$((start+skip-2))
echo $i
GRO=$i-input.gro
tpr=$((++i))-input
minim=npt_5fs_long.mdp
top=system.top
out=$((++i))-input
$MPI_GMX_EXEC grompp -f package/$minim  -c $GRO -p $top -o $tpr
ibrun -n $STAMPEDE2PROCS $MPI_MDRUN_EXEC -v -deffnm $out -s $tpr $extra_pins
