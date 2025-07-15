#!/bin/bash
#FLUX: --job-name=UCE_petiolaris 
#FLUX: -t=86400
#FLUX: --urgency=16

source activate phyluce167
illumiprocessor \
    --input raw-fastq/ \
    --output clean-fastq \
    --config illumiprocessor.conf \
    --cores 4
cd clean-fastq/
for i in *;
do
    phyluce_assembly_get_fastq_lengths --input $i/split-adapter-quality-trimmed/ --csv;
done
cd uce-tutorial
module unuse /opt/rit/spack-modules/lmod/linux-rhel7-x86_64/Core
module use /opt/rit/modules
module load java/1.7.0_55
module load bowtie/1.1.2
phyluce_assembly_assemblo_trinity \
    --conf assembly.conf \
    --output trinity-assemblies \
    --clean \
    --cores 12
