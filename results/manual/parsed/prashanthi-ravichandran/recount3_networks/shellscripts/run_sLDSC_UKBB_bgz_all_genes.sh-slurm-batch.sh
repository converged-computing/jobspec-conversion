#!/bin/bash
#SBATCH --job-name=run_ldsc_UKBB_bgz_all_genes
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=60G
#SBATCH --time=02:00:00
#SBATCH --partition=defq

module load anaconda
conda activate ldsc 
STUDY=$1
CENTRALITY=$2
TRAIT=$3
echo $STUDY
echo $CENTRALITY
echo $TRAIT
python /data/abattle4/prashanthi/recount3_paper/src/08_stratified_LDSC/ldsc.py --h2 "/data/abattle4/prashanthi/recount3_paper/data/s_LDSC/UKBB/"$TRAIT".ldsc.imputed_v3.both_sexes.tsv.bgz" --w-ld-chr /data/abattle4/prashanthi/recount3_paper/data/s_LDSC/1000G_Phase3_weights_hm3_no_MHC/weights.hm3_noMHC. --ref-ld-chr /data/abattle4/prashanthi/recount3_paper/data/s_LDSC/all-genes/SAMGENIC.,"/data/abattle4/prashanthi/recount3_paper/results/s_LDSC/"$STUDY"/"$CENTRALITY"/ldscore/"$STUDY"." --overlap-annot --frqfile-chr /data/abattle4/prashanthi/recount3_paper/data/s_LDSC/1000G_Phase3_frq/1000G.EUR.QC. --out "/data/abattle4/prashanthi/recount3_paper/results/s_LDSC/"$STUDY"/"$CENTRALITY"/results/UKBB/"$TRAIT"_all_genes" --print-coefficients
