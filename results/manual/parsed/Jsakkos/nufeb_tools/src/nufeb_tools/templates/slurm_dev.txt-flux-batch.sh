#!/bin/bash
#FLUX: --job-name=loopy-staircase-8766
#FLUX: --exclusive
#FLUX: --priority=16

export LAMMPS='~/NUFEB-dev/src/lmp_png'

date
module purge
module load PE-gnu/3.0
export LAMMPS=~/NUFEB-dev/src/lmp_png
ldd $LAMMPS
python3 ~/NUFEB-dev/nufeb-tools/GenerateAtom.py --n 10
if [ $? -ne 0 ]
then
    echo "Something went wrong in the previous step, exiting"
    exit
fi
for f in Inputscript_*.lmp
do
mpirun -np 32 $LAMMPS -in $f > ${f}.log
done
date
