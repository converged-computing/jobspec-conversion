#!/bin/bash
#SBATCH --job-name=${job}
#SBATCH --account=cnms
#SBATCH --mail-user=${USER}@ornl.gov
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100g
#SBATCH --time=10:00:00
#SBATCH --partition=batch
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=32

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
