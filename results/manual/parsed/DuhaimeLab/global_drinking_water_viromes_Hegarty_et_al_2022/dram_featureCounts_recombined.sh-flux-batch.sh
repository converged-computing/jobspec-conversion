#!/bin/bash
#FLUX: --job-name=featureCounts
#FLUX: --queue=standard
#FLUX: -t=691200
#FLUX: --priority=16

echo $SLURM_JOB_NODELIST
if [ -n "$SLURM_SUBMIT_DIR" ]; then cd $SLURM_SUBMIT_DIR; fi
pwd
module load singularity
cd /scratch/kwigg_root/kwigg/hegartyb/SnakemakeAssemblies3000/CompetitiveMapping
singularity exec /nfs/turbo/lsa-dudelabs/containers/subreads/subreads.sif featureCounts -p -t CDS -g ID -a ./DRAM/genes.annotated.gff -o ./Feat\
ureCounts/genes.annotated.counted.txt ./Bowtie2/Results/AllContigsRecombinedMapping/Mapped_Reads_align_on_all_recombined_*.bam
