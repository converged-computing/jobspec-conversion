#!/bin/bash
#FLUX: --job-name=loopy-muffin-6543
#FLUX: --exclusive
#FLUX: --urgency=16

export LAMMPS='~/NUFEB/lammps/src/lmp_png'

date
module purge
module load PE-gnu/3.0
export LAMMPS=~/NUFEB/lammps/src/lmp_png
ldd $LAMMPS
base=$PWD
for dir in runs/*/
do
cd "$dir"
mpirun -np 32 $LAMMPS -in *.lammps > nufeb.log
cd "$base"
done
if [ $? -ne 0 ]
then
    echo "Something went wrong while running simulations, exiting"
    exit
fi
date
if ${VTK}
then
    for dir in runs/*/
    do
    cd "$dir"
    tar -zcf VTK.tar.gz *.vtr *.vtu *.vti
    rm *.vtr *.vtu *.vti
    cd "$base"
    done
fi
if [ $? -ne 0 ]
then
    echo "Something went wrong while creating tarballs, exiting"
    exit
fi
