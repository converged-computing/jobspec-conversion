#!/bin/bash
#FLUX: --job-name=test
#FLUX: -n=8
#FLUX: --queue=mi1008x
#FLUX: -t=1800
#FLUX: --urgency=16

module use /share/bpotter/modulefiles/
module load rocshmem/1.6.3
module list
blocks=(8)
threads=(512)
iters=(1000)
for myblock in ${blocks[@]}
do 
	for mythread in ${threads[@]}
	do
		for myiter in ${iters[@]}
		do
			echo $myblock, $mythread, $myiter
			#srun -N1 -n8 -c4 ./shmem_putfence_bw_loopallgpu 1 ${myblock} ${mythread} ${myiter} |& tee log_putfence_B${myblock}_T${mythread}_I${myiter}
			srun -N1 -n8 -c4 ./shmem_putfencesig_bw_loopallgpu 1 ${myblock} ${mythread} ${myiter} |& tee log_putfencesig_B${myblock}_T${mythread}_I${myiter}
			#srun -N1 -n8 -c4 ./shmem_put_bw_loopallgpu 1 ${myblock} ${mythread} ${myiter} |& tee log_put_B${myblock}_T${mythread}_I${myiter} 
		done
	done
done
