#!/bin/bash
#FLUX: --job-name=clustergenomes
#FLUX: --queue=standard
#FLUX: -t=72000
#FLUX: --priority=16

export PATH='$PATH:"$PWD'

source /etc/profile.d/http_proxy.sh
echo $SLURM_JOB_NODELIST
cd /nfs/turbo/cee-kwigg/hegartyb/SnakemakeAssemblies3000/Scripts/bin 
export PATH=$PATH:"$PWD"
Cluster_genomes.py -f /scratch/kwigg_root/kwigg/hegartyb/SnakemakeAssemblies3000/CompetitiveMapping/ViralSeqsTrimmed/merged_3000_trimmed_viruses_only_20211112.fa -c 85 -i 95 -o /scratch/kwigg_root/kwigg/hegartyb/SnakemakeAssemblies3000/CompetitiveMapping/ClusterGenomes
