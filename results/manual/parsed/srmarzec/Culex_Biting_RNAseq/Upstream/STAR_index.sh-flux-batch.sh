#!/bin/bash
#FLUX: --job-name=STAR_index
#FLUX: -t=43200
#FLUX: --urgency=16

module load star/2.7.1a
refgen_dir=/home/sm3679/culex_biting/culex_genome
refgen_index=/home/sm3679/culex_biting/culex_genome/index_genome
STAR --runMode genomeGenerate \
        --genomeDir ${refgen_index} \
        --genomeFastaFiles ${refgen_dir}/GCF_015732765.1_VPISU_Cqui_1.0_pri_paternal_genomic.fna \
        --sjdbGTFfile ${refgen_dir}/GCF_015732765.1_VPISU_Cqui_1.0_pri_paternal_genomic.gtf \
        --sjdbOverhang 135 \
        --genomeSAindexNbases 13
