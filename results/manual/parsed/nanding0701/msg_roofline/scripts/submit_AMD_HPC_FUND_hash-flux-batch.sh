#!/bin/bash
#FLUX: --job-name=persnickety-parsnip-8570
#FLUX: --priority=16

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
