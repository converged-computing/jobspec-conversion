#!/bin/bash
#FLUX: --job-name=wmpi
#FLUX: -N=3
#FLUX: --exclusive
#FLUX: --queue=EPYC
#FLUX: -t=7200
#FLUX: --urgency=16

export OMP_PLACES='cores'
export OMP_PROC_BIND='close'
export OMP_NUM_THREADS='64'

date
pwd
hostname
module load architecture/AMD
module load openMPI/4.1.4/gnu/12.2.1
make
export OMP_PLACES=cores
export OMP_PROC_BIND=close
export OMP_NUM_THREADS=64
k=4000
echo size,cores,sockets,time >> wmpi$k.csv
for i in {1..6}
do
	let size=$(($k*$i))
	./main.x -i -k $size -f init$size.pbm
	let ncores=$((64*i))
	for j in {1..5}
	do
		echo -n $size,$ncores,$i, >> wmpi$k.csv
		mpirun -np $i --map-by socket ./main.x -r -n 100 -f init$size.pbm >> wmpi$k.csv
	done
done
make clean
make image
