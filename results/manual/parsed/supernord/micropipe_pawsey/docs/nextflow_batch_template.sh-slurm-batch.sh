#!/bin/bash
#SBATCH --job-name=micropipe
#SBATCH --output=s%A.micropipe_guppy3.6.1_cpu_12samples_72h.out
#SBATCH --error=s%A.micropipe_guppy3.6.1_cpu_12samples_72h.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=4-00:00:00

module load nextflow/20.07.1-multi
module load singularity/3.6.4 
dir=/scratch/director2172/vmurigneux/micropipe
cd ${dir}
datadir=${dir}/Illumina
out_dir=${dir}/results_3.6.1_cpu
fast5_dir=${dir}/fast5_pass
csv=${dir}/test_data/samples_all_basecalling.csv
nextflow main.nf --gpu false --basecalling --guppy_num_callers 16 -profile zeus --slurm_account='director2172' --demultiplexing --samplesheet ${csv} --outdir ${out_dir} --fast5 ${fast5_dir} --datadir ${datadir}
