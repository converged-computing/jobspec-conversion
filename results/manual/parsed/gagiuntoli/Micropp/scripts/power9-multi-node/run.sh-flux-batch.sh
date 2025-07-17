#!/bin/bash
#FLUX: --job-name=micropp
#FLUX: -n=320
#FLUX: --exclusive
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export CUDA_VISIBLE_DEVICES='0,1,2,3'

module purge
module load gcc/6.4.0 bsc/commands pgi/18.10 cuda/10.1 cmake/3.13.2 spectrum/10.2
declare -a hosts=(`scontrol show hostnames $SLURM_NODELIST`)
echo "${hosts[0]}" > ./my_hostfile
echo "${hosts[0]}" >> ./my_hostfile
echo "${hosts[0]}" >> ./my_hostfile
echo "${hosts[0]}" >> ./my_hostfile
echo "${hosts[1]}" >> ./my_hostfile
echo "${hosts[1]}" >> ./my_hostfile
echo "${hosts[1]}" >> ./my_hostfile
echo "${hosts[1]}" >> ./my_hostfile
N=80
NGP=256
STEPS=5
EXEC="../../test/multi-gpu-mpi"
export OMP_NUM_THREADS=1
export CUDA_VISIBLE_DEVICES="0,1,2,3"
rm -rf times.txt
for i in 8; do
	echo "running" $i MPI processes
	fileo="output-${N}-${NGP}-${i}.out"
	time mpirun -np $i --machinefile ./my_hostfile -mca rmaps seq $EXEC $N $NGP $STEPS > $fileo
	#time mpirun -np $i --machinefile ./my_hostfile -mca rmaps seq $EXEC $N $NGP $STEPS > $fileo
	tim=$(awk '/time =/{print $3}' $fileo)
	echo $i $tim >> times.txt
done
