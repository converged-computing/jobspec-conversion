#!/bin/bash
#FLUX: --job-name=valgrind_massif
#FLUX: -n=12
#FLUX: -c=4
#FLUX: -t=61500
#FLUX: --priority=16

export OMP_NUM_THREADS='4'

DIR=map
mkdir massif12
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
export OMP_NUM_THREADS=4
valgrind --tool=massif mpirun -n 12 ./nest $1 
cd massif12
mkdir map$i
mv ../massif.out.* map$i
cd ../
done 
exit
