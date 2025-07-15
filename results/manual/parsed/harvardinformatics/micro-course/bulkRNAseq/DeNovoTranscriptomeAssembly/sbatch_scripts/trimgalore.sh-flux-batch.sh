#!/bin/bash
#FLUX: --job-name=bumfuzzled-caramel-4715
#FLUX: --priority=16

module purge
module load cutadapt/1.8.1-fasrc01
/n/scratchlfs/informatics/nanocourse/rna-seq/denovo_assembly/util/TrimGalore/trim_galore --paired  --illumina --retain_unpaired  --phred33  --output_dir $(pwd) --length 36 -q 5 --stringency 1 -e 0.1 $1 $2
