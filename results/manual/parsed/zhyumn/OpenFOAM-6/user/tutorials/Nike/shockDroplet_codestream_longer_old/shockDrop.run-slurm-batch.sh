#!/bin/bash
#SBATCH --output=job.out
#SBATCH --error=job.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=6-04:00:00
#SBATCH --constraint=ntasks-per-node=128

. /home/zhan6305/OpenFOAM/cleanOpenFOAM/OpenFOAM-6/etc/bashrc
. /home/zhan6305/OpenFOAM/cleanOpenFOAM/OpenFOAM-6/user/bashrc
. /home/zhan6305/OpenFOAM/cleanOpenFOAM/OpenFOAM-6/user/etc/bashrc
blockMesh
cp -r 0.orig 0
decomposePar -latestTime -force
mpirun -np 128 rhoCentralRealgasFoam  -parallel
reconstructPar -latestTime
rm -r 0
mv  0.0005 0
setFields
decomposePar -latestTime   -force
sed -i 's/endTime         0.0005;/endTime         0.005;/' system/controlDict 
mpirun -np 128 rhoCentralRealgasFoam  -parallel
reconstructPar -newTimes
