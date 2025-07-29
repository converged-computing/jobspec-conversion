#!/bin/bash
#SBATCH --job-name=test
#SBATCH --output=job.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=mi1008x

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
