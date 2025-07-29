#!/bin/bash
#SBATCH --job-name=cbai_guppy_nanopore_20102558-2729
#SBATCH --account=srlab-ckpt
#SBATCH --mail-user=samwhite@uw.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:P100:1
#SBATCH --mem=120G
#SBATCH --time=01:00:00
#SBATCH --partition=ckpt
#SBATCH --constraint=gpu_default
#SBATCH --chdir=/gscratch/scrubbed/samwhite/outputs/20200110_cbai_guppy_nanopore_20102558-2729

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
