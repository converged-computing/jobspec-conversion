#!/bin/bash
#FLUX: --job-name=conspicuous-lemur-7523
#FLUX: --urgency=16

module load gcc/10.2.0
module load cmake/gcc/3.18.0
module load openmpi/gcc/64/1.10.7
cd build
rm ../out/perf/matrixmatrix/matrixmatrix.txt
touch ../out/perf/matrixmatrix/matrixmatrix.txt
for i in {3..28}
do
echo -ne "size\t4800\tprocs\t" >> ../out/perf/matrixmatrix/matrixmatrix.txt
echo -ne $i  >> ../out/perf/matrixmatrix/matrixmatrix.txt
echo -ne "\t"  >> ../out/perf/matrixmatrix/matrixmatrix.txt
mpirun -n $i ./matrixmatrix ../etc/4800by4800.mtx ../etc/4800by4800.mtx ../out/4800mmout.mtx >> ../out/perf/matrixmatrix/matrixmatrix.txt
done
