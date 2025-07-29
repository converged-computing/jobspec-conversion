#!/bin/bash
#SBATCH --job-name=FC_NucintronPASupandDown
#SBATCH --account=pi-yangili1
#SBATCH --output=FC_NucintronPASupandDown.out
#SBATCH --error=FC_NucintronPASupandDown.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=36G
#SBATCH --time=1-12:00:00
#SBATCH --partition=broadwl

source ~/activate_anaconda.sh
conda activate three-prime-env
featureCounts -a ../data/intronRNAratio/NuclearIntronicPAS_intronUpstream.SAF -F SAF -o ../data/intronRNAratio/NuclearUpstreamIntron.fc ../data/NascentRNA/NascentRNAMerged.sort.bam
featureCounts -a ../data/intronRNAratio/NuclearIntronicPAS_intronDownstream.SAF -F SAF -o ../data/intronRNAratio/NuclearDownstreamIntron.fc ../data/NascentRNA/NascentRNAMerged.sort.bam
