#!/bin/bash
#FLUX: --job-name=groupc_mc
#FLUX: -n=28
#FLUX: --queue=defq
#FLUX: -t=2700
#FLUX: --urgency=16

module load gcc/10.2.0
module load cmake/gcc/3.18.0
module load openmpi/gcc/64/1.10.7
cd build
rm ../out/perf/montecarlo/montecarlo.txt
touch ../out/perf/montecarlo/montecarlo.txt
for i in {1..28}
do
echo -ne "size\t57600\tprocs\t" >> ../out/perf/montecarlo/montecarlo.txt
echo -ne $i  >> ../out/perf/montecarlo/montecarlo.txt
echo -ne "\t"  >> ../out/perf/montecarlo/montecarlo.txt
mpirun -n $i ./montecarlo 57600  >> ../out/perf/montecarlo/montecarlo.txt
done
for i in {1..28}
do
echo -ne "size\t2560000\tprocs\t" >> ../out/perf/montecarlo/montecarlo.txt
echo -ne $i  >> ../out/perf/montecarlo/montecarlo.txt
echo -ne "\t"  >> ../out/perf/montecarlo/montecarlo.txt
mpirun -n $i ./montecarlo 2560000  >> ../out/perf/montecarlo/montecarlo.txt
done
for i in {1..28}
do
echo -ne "size\t23040000\tprocs\t" >> ../out/perf/montecarlo/montecarlo.txt
echo -ne $i  >> ../out/perf/montecarlo/montecarlo.txt
echo -ne "\t"  >> ../out/perf/montecarlo/montecarlo.txt
mpirun -n $i ./montecarlo 23040000 >> ../out/perf/montecarlo/montecarlo.txt
done
