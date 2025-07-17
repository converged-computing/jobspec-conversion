#!/bin/bash
#FLUX: --job-name=micropipe
#FLUX: --queue=longq
#FLUX: -t=345600
#FLUX: --urgency=16

module load nextflow/20.07.1-multi
module load singularity/3.6.4 
dir=/scratch/director2172/vmurigneux/micropipe
cd ${dir}
datadir=${dir}/Illumina
out_dir=${dir}/results_3.6.1_cpu
fast5_dir=${dir}/fast5_pass
csv=${dir}/test_data/samples_all_basecalling.csv
nextflow main.nf --gpu false --basecalling -profile zeus --slurm_account='director2172' --demultiplexing --samplesheet ${csv} --outdir ${out_dir} --fast5 ${fast5_dir} --datadir ${datadir}
