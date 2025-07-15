#!/bin/bash
#FLUX: --job-name=spicy-rabbit-7948
#FLUX: -t=36000
#FLUX: --priority=16

source ./GLOBAL_VAR.sh
group="$1"
geneset=topGene5
gsea_dir=/work-zfs/abattle4/heyuan/tissue_spec_eQTL_v8/datasets/annotations/TFmotif/
gsea_fn=c5.bp.v6.2.symbols.gmt.txt
file1=${LMfn}_${geneset}_${group}.txt
file3=/work-zfs/abattle4/heyuan/tissue_spec_eQTL_v8/datasets/cbset_datasets/input_pairs/tested_genes_in_cbset/Group${group/group/}_genes.txt
outdir=/work-zfs/abattle4/heyuan/tissue_spec_eQTL_v8/downstream/enrichmentTest/GSEA
outfn=${outdir}/${file1%.txt}_enrichment_${gsea_fn}
echo $outfn
module load python/2.7
python run_enrichment.py ${pairdir}/${file1} ${file3} ${gsea_dir}/${gsea_fn} ${outfn}
cat ${outfn} | head -n5 | cut -d'	' -f1-7,9
