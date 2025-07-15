#!/bin/bash
#FLUX: --job-name=phyluce_trinity_au
#FLUX: -t=777600
#FLUX: --urgency=16

source activate phyluce162
​
module unuse /opt/rit/spack-modules/lmod/linux-rhel7-x86_64/Core
module use /opt/rit/modules
​
module load java/1.7.0_55
module load bowtie/1.1.2
​
​
phyluce_assembly_assemblo_trinity \
    --conf /ptmp/kevinq/assembly_conf/assembly_Feb2020_au.conf \
    --output /ptmp/kevinq/trinity-assemblies \
    --log /ptmp/kevinq/logs \
    --clean \
    --cores 16
