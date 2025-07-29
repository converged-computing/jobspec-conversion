#!/bin/bash
#SBATCH --job-name=vcontact
#SBATCH --account=kwigg1
#SBATCH --mail-user=hegartyb@umich.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50gb
#SBATCH --time=2-00:00:00
#SBATCH --partition=standard
#SBATCH --constraint=ntasks-per-node=1

echo $SLURM_JOB_NODELIST
if [ -n "$SLURM_SUBMIT_DIR" ]; then cd $SLURM_SUBMIT_DIR; fi
pwd
module load singularity
cd /nfs/turbo/cee-kwigg/hegartyb/SnakemakeAssemblies3000/vContact2
singularity exec /nfs/turbo/lsa-dudelabs/containers/vcontact2/vcontact2.sif vcontact2 --raw-proteins /nfs/turbo/cee-kwigg/hegartyb/SnakemakeAssemblies3000/DRAM/Annotation/genes.faa --rel-mode 'Diamond' --proteins-fp all_gene_to_genome.tsv --db 'ProkaryoticViralRefSeq94-Merged' --pcs-mode MCL --vcs-mode ClusterONE --c1-bin /nfs/turbo/cee-kwigg/hegartyb/SnakemakeAssemblies3000/vContact2/cluster_one-1.0.jar --output-dir vConTACT2_Results_final
