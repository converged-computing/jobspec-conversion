#!/bin/bash
#FLUX: --job-name=ibs_anxdefs
#FLUX: -c=24
#FLUX: --queue=compute
#FLUX: -t=518400
#FLUX: --urgency=16

CCS=(final_cc.diag final_cc.sr final_cc.Q final_cc.Q.prev.diag.yes final_cc.any final_cc.male final_cc.female final_cc.sub.C final_cc.sub.U final_cc.sub.M
 final_cc.sub.D final_quant.hard final_quant.loose final_quant.daily final_quant.SSS final_quant.daily.max final_quant.weekly.min final_cc.any.conts.relaxed final_cc.diag.conts.relaxed final_cc.sr.conts.relaxed
 final_cc.Q.conts.relaxed final_cc.Q.prev.diag.yes.conts.relaxed final_cc.Qonly.Qbased final_cc.Qonly.any final_quant.daily.mauro final_quant.daily.max.mauro final_quant.weekly.min.mauro
 final_cc.respondent final_cc.Qnon.any final_cc.all final_quant.phq.tired
final_cc.diag_ONE final_cc.diag_TWO final_cc.sr_ONE final_cc.sr_TWO final_cc.Q_ONE final_cc.Q_TWO final_cc.Q.prev.diag.yes_ONE final_cc.Q.prev.diag.yes_TWO final_cc.Qonly.any_ONE final_cc.Qonly.any_TWO final_cc$
final_cc.sub.any.C final_cc.sub.any.D final_cc.sub.any.M final_cc.sub.any.U final_cc.any.DvsC final_cc.DvsC
final_cc.post.infective final_cc.nomauro.sub.any.C.female
final_cc.nomauro.sub.any.C.female final_cc.likemauro.sub.any.C.female final_cc.nomauro.any.female final_cc.likemauro.any.female
final_cc.nobonfiglio.sub.any.C.female final_cc.likebonfiglio.sub.any.C.female final_cc.nobonfiglio.any.female final_cc.likebonfiglio.any.female
final_cc.anx final_cc.anx.no.ibs final_cc.Qonly.no.anx final_cc.Qnon.no.anx
final_cc.func.C final_cc.func.D final_quant.caseSSS final_cc.any.fhx
final_cc.anxbroad final_cc.anxbroad.no.ibs final_cc.no.anxbroad
final_cc.Qonly.any.severe final_cc.Qonly.any.twoplus final_cc.Qnon.any.twoplus
final_cc.Q.female.mauroreq final_cc.sub.C.female.mauroreq final_cc.sub.D.female.mauroreq final_cc.sub.M.female.mauroreq
final_cc.sr.female.mauroreq final_cc.Q.prev.diag.yes.female.mauroreq final_cc.diag.female.mauroreq final_cc.Qnon.sr.female.mauroreq final_cc.Qonly.sr.female.mauroreq
final_cc.likebonfiglio.any.female.female.mauroreq final_cc.nobonfiglio.any.female.female.mauroreq final_cc.likebonfiglio.sub.any.C.female.female.mauroreq
final_cc.nobonfiglio.sub.any.C.female.female.mauroreq final_cc.female.female.mauroreq final_cc.nobonfiglio.sub.any.C.female.female.mauroreq final_cc.female.female.mauroreq
final_cc.anxbroad_casesfrom_diag.interest_F40_or_F41 final_cc.anxbroad_casesfrom_diag.interest_F40 final_cc.anxbroad_casesfrom_diag.interest_F41
final_cc.anxbroad_casesfrom_sr.interest_1287 final_cc.anxbroad_casesfrom_Q_treatment.anx final_cc.anxbroad_casesfrom_GAD7.anx
)
CC_ID=${CCS[${SLURM_ARRAY_TASK_ID}-1]}
mkdir /gfs/work/ceijsbouts/ibs/gwas/${CC_ID}
/gfs/apps/bio/BOLT-LMM-2.3.2/bolt \
--bed=/gfs/work/ceijsbouts/ibs/plink/ukb_chr{1:22}_geno_qc.bed \
--bim=/gfs/work/ceijsbouts/ibs/plink/ukb_chr{1:22}_geno_qc.bim \
--fam=/gfs/work/ceijsbouts/ibs/plink/ukb_chr22_geno_qc.fam \
--phenoFile=/gfs/work/ceijsbouts/ibs/covar/cc_cov.sample \
--phenoCol=${CC_ID} \
--covarFile=/gfs/work/ceijsbouts/ibs/covar/cc_cov.sample \
--qCovarCol=sex \
--qCovarCol=age \
--qCovarCol=agesq \
--qCovarCol=sexage \
--qCovarCol=sexagesq \
--qCovarCol=PC{1:20} \
--LDscoresFile=/gfs/apps/bio/BOLT-LMM-2.3.2/tables/LDSCORE.1000G_EUR.tab.gz \
--geneticMapFile=/gfs/apps/bio/BOLT-LMM-2.3.2/tables/genetic_map_hg19_withX.txt.gz \
--bgenFile=/gfs/archive/jostins/ukbb/v3/imputation/ukb_imp_chr{1:22}_v3.bgen \
--sampleFile=/gfs/work/ceijsbouts/ibs/sample/ukb17670_imp_chr22_v3_s487327.sample \
--bgenMinMAF=0.01 \
--bgenMinINFO=0.3 \
--numThreads=24 \
--statsFile=/gfs/work/ceijsbouts/ibs/gwas/${CC_ID}/blmm_output.stats.gz \
--statsFileBgenSnps=/gfs/work/ceijsbouts/ibs/gwas/${CC_ID}/blmm_output.bgen.stats.gz \
--verboseStats \
--remove=/gfs/work/ceijsbouts/ibs/remove/bolt.in_plink_but_not_imputed.FID_IID.968.txt \
--noBgenIDcheck \
--lmmForceNonInf
