#!/bin/bash
#FLUX: --job-name=gassy-taco-7460
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_NTASKS'
export SINGULARITY_BINDPATH='/nfs/work/td/,/lustre/lorenzic/'

export OMP_NUM_THREADS=$SLURM_NTASKS
threads=$SLURM_NTASKS
export SINGULARITY_BINDPATH="/nfs/work/td/,/lustre/lorenzic/"
module purge
module load singularity/3.3
task_n="$SLURM_ARRAY_TASK_ID"
mkdir -p ./DE_results/
script_name=$(realpath ./analysis.R )
source_file=$(realpath ../training.tsv )
results_folder=$(realpath ../../salmon_counts )
output_folder=$(realpath ./DE_salmon_results)
tx2genes=$(realpath ../../tx2gene.gencode.v29.tsv )
singularity_image=$(realpath /nfs/work/td/DE.img )
mkdir -p ${output_folder} 
base_command="singularity exec $singularity_image ${script_name} ${source_file} ${results_folder}"
type_of_data="Reads TPM"
type_of_read="genes txs"
method_names="DESeq2 edgeR limmaVoom"
step=1
for tod in $type_of_data ; do
	for tor in $type_of_read ; do
		for met in $method_names; do
			if [[ $step -eq $task_n ]]; then
				echo "${tod}_${tor}_${met}"
				$base_command ${output_folder}/${tod}_${tor}_${met}.tsv ${tod} ${met} ${tor} ${tx2genes}
			fi
			step=$(( step + 1 ));
		done
	done
done
