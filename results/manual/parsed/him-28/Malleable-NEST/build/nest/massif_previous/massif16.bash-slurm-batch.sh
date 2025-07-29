#!/bin/bash
#SBATCH --job-name=valgrind_massif
#SBATCH --output=massif16_%j.out
#SBATCH --error=massif16_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=3
#SBATCH --time=17:05:00
#SBATCH --chdir=.

export OMP_NUM_THREADS='3'

DIR=map
mkdir massif16
file="massif.out.*"
if [ -f $file ]; then
   rm $file
fi
for i in {1..10}; 
do 
if [ -d "$DIR$i" ]; then
    printf '%s\n' "Removing Lock ($DIR)"
    rm -r "$DIR$i"
fi
export OMP_NUM_THREADS=3
valgrind --tool=massif mpirun -n 16 ./nest $1 
cd massif16
mkdir map$i
mv ../massif.out.* map$i
cd ../
done 
exit
