#!/bin/bash
#SBATCH --job-name=STAR_map_twopass
#SBATCH --output=%x.%j.out
#SBATCH --mail-user=sm3679@georgetown.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100G
#SBATCH --time=1-00:00:00

module load star/2.7.1a
trim_dir=/home/sm3679/culex_biting/trim_dir
splice_junctions=/home/sm3679/culex_biting/sam_dir
out_dir=/home/sm3679/culex_biting/sam_dir/twopass
refgen_dir=/home/sm3679/culex_biting/culex_genome/index_genome
files=(${trim_dir}/*_1_PE.fastq.gz)
for file in ${files[@]}
do
base=`basename ${file} _L005_1_PE.fastq.gz`
STAR --genomeDir ${refgen_dir} \
        --readFilesCommand gunzip -c \
        --readFilesIn ${trim_dir}/${base}_L005_1_PE.fastq.gz ${trim_dir}/${base}_L005_2_PE.fastq.gz \
        --sjdbFileChrStartEnd ${splice_junctions}/*_SJ.out.tab \
        --outFileNamePrefix ${out_dir}/${base}_  
done
