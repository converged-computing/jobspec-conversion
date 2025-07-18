#!/bin/bash
#FLUX: --job-name=test
#FLUX: -n=8
#FLUX: --queue=mi1008x
#FLUX: -t=7200
#FLUX: --urgency=16

module use /share/bpotter/modulefiles/
module load rocshmem/1.6.3
module list
gpus=(1 2 3 4 5 6 7 8)
ins=4000000
for mygpu in ${gpus[@]}
do
	#my_ins_num=`expr $ins / ${mygpu}`
	#echo ${mygpu}, ${my_ins_num}
	#srun -N1 -n${mygpu} -c4 ./hashtable_rocshmem ${my_ins_num} |& tee log_hash_G${mygpu}_N${my_ins_num}
	srun -N1 -n${mygpu} -c4 ./hashtable_rocshmem ${ins} |& tee log_hash_weak_scale_4e6_G${mygpu}
done
