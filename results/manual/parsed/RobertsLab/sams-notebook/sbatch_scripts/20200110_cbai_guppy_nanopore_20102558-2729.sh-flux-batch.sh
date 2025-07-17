#!/bin/bash
#FLUX: --job-name=cbai_guppy_nanopore_20102558-2729
#FLUX: --queue=ckpt
#FLUX: -t=3600
#FLUX: --urgency=16

wd=$(pwd)
declare -A programs_array
programs_array=(
[guppy_basecaller]="/gscratch/srlab/programs/ont-guppy_4.0.15_linux64/bin/guppy_basecaller"
)
fast5_dir=/gscratch/srlab/sam/data/C_bairdi/DNAseq/ont_FAL58500_94244ffd_20102558-2729
out_dir=${wd}
threads=28
flowcell="FLO-MIN106"
kit="SQK-RAD004"
GPU_devices=auto
records_per_fastq=0
set -e
module load intel-python3_2017
module load cuda/10.1.105_418.39
${programs_array[guppy_basecaller]} \
--input_path ${fast5_dir} \
--save_path ${out_dir} \
--flowcell ${flowcell} \
--kit ${kit} \
--device ${GPU_devices} \
--records_per_fastq ${records_per_fastq} \
--num_callers ${threads}
{
date
echo ""
echo "System PATH for $SLURM_JOB_ID"
echo ""
printf "%0.s-" {1..10}
echo "${PATH}" | tr : n
} >> system_path.log
for program in "${!programs_array[@]}"
do
	{
  echo "Program options for ${program}: "
	echo ""
	${programs_array[$program]} --help
	echo ""
	echo ""
	echo "----------------------------------------------"
	echo ""
	echo ""
} &>> program_options.log || true
done
