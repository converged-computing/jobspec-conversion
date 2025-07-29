#!/bin/bash
#SBATCH --account=lc_dvc
#SBATCH --output=./logs/j03_mergeALL.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16GB
#SBATCH --time=01:00:00

REF=/auto/pmd-02/figi/PCA
OUT=/staging/dvc/andreeki/pca_ibd
cd ${OUT}
batch_list="axiom_acs_aus_nf_backbone \
axiom_mecc_cfr_ky_backbone \
ccfr_1m_1mduo_reimpute_backbone \
ccfr_omni_backbone \
corect_oncoarray_backbone \
corect_oncoarray_nonEUR_reimpute_backbone \
corsa_axiom_backbone \
cytosnp_comb_backbone \
dachs3_backbone \
initial_comb_datasets_backbone \
mecc_backbone \
newfoundland_omniquad_backbone \
omni_comb_backbone \
omniexpress_exomechip_backbone \
oncoarray_to_usc_backbone \
plco_3_backbone \
reach_backbone \
ukbiobank_backbone"
for batch in ${batch_list}
do 
    echo ${REF}/${batch}
done > ${OUT}/tmp/mergelist_all.txt
plink --merge-list ${OUT}/tmp/mergelist_all.txt --make-bed --out ${OUT}/TMP1
plink --bfile ${OUT}/TMP1 --keep FIGI_PCA_GwasSet.txt --make-bed --out ${OUT}/FIGI_GwasSet
plink --bfile ${OUT}/TMP1 --keep FIGI_PCA_GxESet.txt --make-bed --out ${OUT}/FIGI_GxESet
