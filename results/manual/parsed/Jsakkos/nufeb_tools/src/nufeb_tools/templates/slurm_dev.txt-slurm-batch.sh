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
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=32

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
