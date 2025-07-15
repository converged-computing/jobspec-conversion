#!/bin/bash
#FLUX: --job-name=FC_NucintronPASupandDown
#FLUX: --queue=broadwl
#FLUX: -t=129600
#FLUX: --priority=16

source ~/activate_anaconda.sh
conda activate three-prime-env
featureCounts -a ../data/intronRNAratio/NuclearIntronicPAS_intronUpstream.SAF -F SAF -o ../data/intronRNAratio/NuclearUpstreamIntron.fc ../data/NascentRNA/NascentRNAMerged.sort.bam
featureCounts -a ../data/intronRNAratio/NuclearIntronicPAS_intronDownstream.SAF -F SAF -o ../data/intronRNAratio/NuclearDownstreamIntron.fc ../data/NascentRNA/NascentRNAMerged.sort.bam
