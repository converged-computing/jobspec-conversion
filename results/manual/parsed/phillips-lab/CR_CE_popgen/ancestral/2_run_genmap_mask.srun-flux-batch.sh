#!/bin/bash
#FLUX: --job-name=genmap
#FLUX: -c=16
#FLUX: --queue=phillips
#FLUX: -t=360000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
workdir="/projects/phillipslab/ateterina/ANCESTRAL/CR"
genmap="/projects/phillipslab/ateterina/scripts/genmap/genmap-build/bin/genmap"
module load cmake/3.9.4 gcc/5.4 bedtools
PX506="/projects/phillipslab/ateterina/ANCESTRAL/CR/genomes/GCA_010183535.1_CRPX506_genomic.chromosomes.fna"
PX439="/projects/phillipslab/ateterina/ANCESTRAL/CR/genomes/GCA_002259225.1_CaeRem1.0_genomic.fna"
PX356="/projects/phillipslab/ateterina/ANCESTRAL/CR/genomes/GCA_001643735.2_ASM164373v2_genomic.fna"
PB4641="/projects/phillipslab/ateterina/ANCESTRAL/CR/genomes/GCA_000149515.1_ASM14951v1_genomic.fna"
latens="/projects/phillipslab/ateterina/ANCESTRAL/CR/genomes/GCA_002259235.1_CaeLat1.0_genomic.fna"
indexfolder="/projects/phillipslab/ateterina/ANCESTRAL/CR/MASKS"
k=50
m=4
LISTFILES=(PX506 PX439 PX356 PB4641 latens)
file=${LISTFILES[$SLURM_ARRAY_TASK_ID]}
echo ${!file}
echo $file
echo ${!file/.fna/.masked.fna}
$genmap index -F ${!file} -I $indexfolder/$file
$genmap map -K $k -E $m -I $indexfolder/$file -O $indexfolder/${file}-genmap-${k}-${m} -bg --threads 16
awk '{ if ($4 <= 0.5) print $1"\t"$2"\t"$3;}' ${file}-genmap-${k}-${m}.bedgraph |bedtools merge -i  - -d 100 > ${file}-genmap-${k}-${m}.2.bed
bedtools maskfasta -fi ${!file} -bed ${file}-genmap-${k}-${m}.2.bed -fo ${!file/.fna/.masked.fna}
mv ${!file/.fna/.masked.fna} /projects/phillipslab/ateterina/ANCESTRAL/CR/genomes/
