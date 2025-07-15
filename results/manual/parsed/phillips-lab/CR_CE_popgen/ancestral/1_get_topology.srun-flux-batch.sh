#!/bin/bash
#FLUX: --job-name=topology
#FLUX: -c=8
#FLUX: --queue=phillips
#FLUX: -t=360000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
workdir="/projects/phillipslab/ateterina/ANCESTRAL/CR/genomes"
chrname="X"
module load bedtools
bedtools getfasta -fi /projects/phillipslab/ateterina/ANCESTRAL/CR/genomes/GCA_010183535.1_CRPX506_genomic.chromosomes.fna -bed 1mb_region.${chrname}.bed -fo PX506.${chrname}.1Mb.fasta
module load easybuild ifort/2017.1.132-GCC-6.3.0-2.27 impi/2017.1.132 NCBI-Toolkit/18.0.0
makeblastdb -in PX506.${chrname}.1Mb.fasta -parse_seqids -dbtype nucl
for seq in GCA_000149515.1_ASM14951v1_genomic.fna GCA_001643735.2_ASM164373v2_genomic.fna GCA_002259235.1_CaeLat1.0_genomic.fna GCA_002259225.1_CaeRem1.0_genomic.fna;do
    blastn -db PX506.${chrname}.1Mb.fasta -num_threads 8 -outfmt 6  -query $workdir/$seq -out ${seq/.fna/.blast_1Mb_${chrname}.out};
done
for i in *blast*_${chrname}.*out*;do
    awk '{if ($4>500) print;}' $i |cut -f1 - | uniq -c | sed -E "s/^( )*[0-9]+//" - > ${i/out/list.txt};
done
sed -i  's/ //g' *list.txt
for seq in GCA_000149515.1_ASM14951v1_genomic.fna GCA_001643735.2_ASM164373v2_genomic.fna GCA_002259235.1_CaeLat1.0_genomic.fna GCA_002259225.1_CaeRem1.0_genomic.fna;do
    perl -ne 'if(/^>(\S+)/){$c=$i{$1}}$c?print:chomp;$i{$_}=1 if @ARGV' ${seq/fna/blast_1Mb_${chrname}.list.txt} $workdir/$seq > ${seq/.fna/.SUBSET.${chrname}.1Mb.fasta}
done
PX506="PX506.${chrname}.1Mb.fasta"
PX356="GCA_001643735.2_ASM164373v2_genomic.SUBSET.${chrname}.1Mb.fasta"
PB4641="GCA_000149515.1_ASM14951v1_genomic.SUBSET.${chrname}.1Mb.fasta"
CL="GCA_002259235.1_CaeLat1.0_genomic.SUBSET.${chrname}.1Mb.fasta"
PX439="GCA_002259225.1_CaeRem1.0_genomic.SUBSET.${chrname}.1Mb.fasta"
progressiveMauve="/projects/phillipslab/ateterina/scripts/mauve_snapshot_2015-02-13/linux-x64/progressiveMauve"
out="CR_${chrname}_1Mb.pmauve"
$progressiveMauve --output=$out.xmfa --output-guide-tree=$out.tree --backbone-output=$out.backbone $PX506 $PX356 $PB4641 $PX439 $CL
