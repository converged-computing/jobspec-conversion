#!/bin/bash
#FLUX: --job-name=valgrind_massif
#FLUX: -n=2
#FLUX: -c=24
#FLUX: -t=61500
#FLUX: --urgency=16

export OMP_NUM_THREADS='24'

DIR=map
mkdir massif2
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
export OMP_NUM_THREADS=24
valgrind --tool=massif mpirun -n 2 ./nest $1 
cd massif2
mkdir map$i
mv ../massif.out.* map$i
cd ../
done 
exit
