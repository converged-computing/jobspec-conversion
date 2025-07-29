#!/bin/bash
#SBATCH --job-name=featureCounts
#SBATCH --account=kwigg1
#SBATCH --mail-user=hegartyb@umich.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1gb
#SBATCH --time=8-00:00:00
#SBATCH --partition=standard
#SBATCH --constraint=ntasks-per-node=1

echo $SLURM_JOB_NODELIST
if [ -n "$SLURM_SUBMIT_DIR" ]; then cd $SLURM_SUBMIT_DIR; fi
pwd
module load singularity
cd /scratch/kwigg_root/kwigg/hegartyb/SnakemakeAssemblies3000/CompetitiveMapping
singularity exec /nfs/turbo/lsa-dudelabs/containers/subreads/subreads.sif featureCounts -p -t CDS -g ID -a ./DRAM/genes.annotated.gff -o ./Feat\
ureCounts/genes.annotated.counted.txt ./Bowtie2/Results/AllContigsRecombinedMapping/Mapped_Reads_align_on_all_recombined_*.bam
