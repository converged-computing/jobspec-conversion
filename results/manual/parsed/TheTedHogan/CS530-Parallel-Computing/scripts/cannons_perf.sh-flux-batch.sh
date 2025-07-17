#!/bin/bash
#FLUX: --job-name=hogan
#FLUX: -n=28
#FLUX: --queue=defq
#FLUX: -t=2700
#FLUX: --urgency=16

module load gcc/10.2.0
module load cmake/gcc/3.18.0
module load openmpi/gcc/64/1.10.7
cd build
rm -rf *
cmake ..
make
rm ../out/perf/cannons/cannons.txt
touch ../out/perf/cannons/cannons.txt
echo -ne "size\t4800\tprocs\t25\t" >> ../out/perf/cannons/cannons.txt
mpirun -n 25 ./matrixmatrixcannon  4800  ../out/cannon_out.mtx >> ../out/perf/cannons/cannons.txt
echo -ne "size\t4800\tprocs\t16\t" >> ../out/perf/cannons/cannons.txt
mpirun -n 16 ./matrixmatrixcannon  4800  ../out/cannon_out.mtx >> ../out/perf/cannons/cannons.txt
echo -ne "size\t4800\tprocs\t9\t" >> ../out/perf/cannons/cannons.txt
mpirun -n 9 ./matrixmatrixcannon  4800  ../out/cannon_out.mtx >> ../out/perf/cannons/cannons.txt
echo -ne "size\t4800\tprocs\t4\t" >> ../out/perf/cannons/cannons.txt
mpirun -n 4 ./matrixmatrixcannon  4800  ../out/cannon_out.mtx >> ../out/perf/cannons/cannons.txt
echo -ne "size\t4800\tprocs\t1\t" >> ../out/perf/cannons/cannons.txt
mpirun -n 1 ./matrixmatrixcannon  4800  ../out/cannon_out.mtx >> ../out/perf/cannons/cannons.txt
echo -ne "size\t240\tprocs\t1\t" >> ../out/perf/cannons/cannons.txt
mpirun -n 1 ./matrixmatrixcannon  240  ../out/cannon_out.mtx >> ../out/perf/cannons/cannons.txt
echo -ne "size\t240\tprocs\t4\t" >> ../out/perf/cannons/cannons.txt
mpirun -n 4 ./matrixmatrixcannon  240  ../out/cannon_out.mtx >> ../out/perf/cannons/cannons.txt
echo -ne "size\t240\tprocs\t9\t" >> ../out/perf/cannons/cannons.txt
mpirun -n 9 ./matrixmatrixcannon  240  ../out/cannon_out.mtx >> ../out/perf/cannons/cannons.txt
echo -ne "size\t240\tprocs\t16\t" >> ../out/perf/cannons/cannons.txt
mpirun -n 16 ./matrixmatrixcannon  240  ../out/cannon_out.mtx >> ../out/perf/cannons/cannons.txt
echo -ne "size\t240\tprocs\t25\t" >> ../out/perf/cannons/cannons.txt
mpirun -n 25 ./matrixmatrixcannon  240  ../out/cannon_out.mtx >> ../out/perf/cannons/cannons.txt
echo -ne "size\t1600\tprocs\t1\t" >> ../out/perf/cannons/cannons.txt
mpirun -n 1 ./matrixmatrixcannon  1600  ../out/cannon_out.mtx >> ../out/perf/cannons/cannons.txt
echo -ne "size\t1600\tprocs\t4\t" >> ../out/perf/cannons/cannons.txt
mpirun -n 4 ./matrixmatrixcannon  1600  ../out/cannon_out.mtx >> ../out/perf/cannons/cannons.txt
echo -ne "size\t1599\tprocs\t9\t" >> ../out/perf/cannons/cannons.txt
mpirun -n 9 ./matrixmatrixcannon  1599  ../out/cannon_out.mtx >> ../out/perf/cannons/cannons.txt
echo -ne "size\t1600\tprocs\t16\t" >> ../out/perf/cannons/cannons.txt
mpirun -n 16 ./matrixmatrixcannon  1600  ../out/cannon_out.mtx >> ../out/perf/cannons/cannons.txt
echo -ne "size\t1600\tprocs\t25\t" >> ../out/perf/cannons/cannons.txt
mpirun -n 25 ./matrixmatrixcannon  1600  ../out/cannon_out.mtx >> ../out/perf/cannons/cannons.txt
