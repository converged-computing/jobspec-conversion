#!/bin/bash
#FLUX: --job-name=atac2BigWig
#FLUX: --queue=kellis
#FLUX: --urgency=16

export sample='$(< "samples_celltypes.tsv" awk -v TASK=${TASK} 'NR == TASK { print $1 }')'
export celltype='$(< "samples_celltypes.tsv" awk -v TASK=${TASK} 'NR == TASK { print $2 }')'

source /home/benjames/.compbiorc
cd /home/benjames/data/AD_ATAC/bigWig
type -P bedtools >/dev/null || module load bedtools
export sample=$(< "samples_celltypes.tsv" awk -v TASK=${TASK} 'NR == TASK { print $1 }')
export celltype=$(< "samples_celltypes.tsv" awk -v TASK=${TASK} 'NR == TASK { print $2 }')
echo "Hello world ${TASK} -> ${sample},${celltype}"
frag=$(< "/net/bmc-lab5/data/kellis/group/Benjamin/AD_ATAC/pfc_fragment_files.txt" awk -v sample="${sample}" 'sample == $2 { print $1 }')
bedfile="${sample}_${celltype}.bed.gz"
zgrep -Fw -f <(zgrep "${celltype}\$" ./TSS6_major_cell_type_assignment.tsv.gz | awk -v sample="${sample}" 'sample == $1 { print $2 }') \
      "${frag}" \
    | perl -ane 'print "$F[0]\t$F[1]\t$F[2]\n" x $F[4]' \
    | gzip -c > "${bedfile}"
echo "Running genomecov to generate bedgraph"
bedgraph="${sample}_${celltype}.bedgraph.gz"
bedtools genomecov -bg -i "${bedfile}" -g /home/Genomes/cellranger/refdata-cellranger-arc-GRCh38-2020-A-2.0.0/star/chrNameLength.txt \
    | sort -k1,1 -k2,2n | gzip -c -9 > "${bedgraph}"
rm -f "${bedfile}"
