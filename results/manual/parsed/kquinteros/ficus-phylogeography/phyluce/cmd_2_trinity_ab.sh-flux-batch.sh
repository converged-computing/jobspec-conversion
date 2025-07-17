#!/bin/bash
#FLUX: --job-name=phyluce_trinity_ab
#FLUX: -n=16
#FLUX: -t=432000
#FLUX: --urgency=16

source activate phyluce
module unuse /opt/rit/spack-modules/lmod/linux-rhel7-x86_64/Core
module use /opt/rit/modules
module load java/1.7.0_55
module load bowtie/1.1.2
phyluce_assembly_assemblo_trinity \
    --conf /ptmp/LAS/phylo-lab/jsatler/phyluce/assembly_conf/assembly_rd23_ab.conf \
    --output /ptmp/LAS/phylo-lab/jsatler/phyluce/trinity-assemblies \
    --clean \
    --cores 16
