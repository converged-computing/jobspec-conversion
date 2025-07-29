#!/bin/bash
#SBATCH --job-name=STAR_index
#SBATCH --output=%x.%j.out
#SBATCH --mail-user=sm3679@georgetown.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100G
#SBATCH --time=12:00:00

module load star/2.7.1a
refgen_dir=/home/sm3679/culex_biting/culex_genome
refgen_index=/home/sm3679/culex_biting/culex_genome/index_genome
STAR --runMode genomeGenerate \
        --genomeDir ${refgen_index} \
        --genomeFastaFiles ${refgen_dir}/GCF_015732765.1_VPISU_Cqui_1.0_pri_paternal_genomic.fna \
        --sjdbGTFfile ${refgen_dir}/GCF_015732765.1_VPISU_Cqui_1.0_pri_paternal_genomic.gtf \
        --sjdbOverhang 135 \
        --genomeSAindexNbases 13
