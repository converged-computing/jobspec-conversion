#!/bin/bash
#FLUX: --job-name=_HATK
#FLUX: --queue=cardio
#FLUX: -t=432000
#FLUX: --priority=16

export analysis='~/Caprion/analysis'
export cookhla='${HPC_WORK}/CookHLA'
export snp2hla='~/genetics/SNP2HLA_package_v1.0.3/SNP2HLA'
export hatk='~/hpc-work/HATK/'

export analysis=~/Caprion/analysis
export cookhla=${HPC_WORK}/CookHLA
export snp2hla=~/genetics/SNP2HLA_package_v1.0.3/SNP2HLA
export hatk=~/hpc-work/HATK/
. /etc/profile.d/modules.sh
module purge
module load rhel7/default-peta4
module load gcc/6
function SNP2HLA()
{
  cd ${snp2hla}
  csh SNP2HLA.csh ${analysis}/work/hla \
                  ${snp2hla}/1000G_REF.EUR.chr6.hg18.29mb-34mb.inT1DGC \
                  ${analysis}/HLA/SNP2HLA/hla_SNP2HLA plink 250000 100
  plink --dosage ${analysis}/HLA/SNP2HLA/hla_SNP2HLA.dosage noheader format=1 \
        --fam ${analysis}/HLA/SNP2HLA/hla_SNP2HLA.fam \
        --pheno ${analysis}/work/hla.pheno \
        --out ${analysis}/HLA/SNP2HLA/hla_SNP2HLA.dosage
}
function CookHLA()
{
  cd ${cookhla}
  module load python/3.7
  source ~/COVID-19/py37/bin/activate
  python -m MakeGeneticMap \
         -i ${analysis}/work/hla \
         -hg 19 \
         -ref ${cookhla}/1000G_REF/1000G_REF.EUR.chr6.hg18.29mb-34mb.inT1DGC \
         -o ${analysis}/HLA/CookHLA/hla_IMPUTED
  python CookHLA.py \
         -i ${analysis}/work/hla \
         -hg 19 \
         -o ${analysis}/HLA/CookHLA/hla_CookHLA \
         -ref ${cookhla}/1000G_REF/1000G_REF.EUR.chr6.hg18.29mb-34mb.inT1DGC \
         -gm ${analysis}/HLA/CookHLA/hla_IMPUTED.mach_step.avg.clpsB \
         -ae ${analysis}/HLA/CookHLA/hla_IMPUTED.aver.erate \
         -mem 250g
  deactivate
}
function HIBAG()
{
  export hlaId=$(echo A B C DRB1 DQA1 DQB1 DPB1 | cut -d' ' -f${SLURM_ARRAY_TASK_ID})
  Rscript -e '
    caprion <- "~/Caprion"
    load(file.path(caprion,"analysis","work","hla.rda"))
    hlaId <- Sys.getenv("hlaId")
    model.list <- get(load(file.path(caprion,"analysis","HLA","HIBAG","AffyAxiomUKB-European-HLA4-hg19.RData")))
    suppressMessages(library(HIBAG))
    model <- hlaModelFromObj(model.list[[hlaId]])
    summary(model)
    pred <- predict(model, interval.geno, type="response+prob")
    save(pred,file=file.path(caprion,"analysis","work",paste0("hla-",hlaId,".rda")))
  '
}
function hatk()
{
  module load python/3.7
  source ~/COVID-19/py37/bin/activate
  ln -sf ${hatk}/IMGT2Seq
  ln -sf ${hatk}/bMarkerGenerator
  python3 ${hatk}/HATK.py \
          --logistic \
          --variants ${analysis}/HLA/CookHLA/hla.COPY.LiftDown_hg18 \
          --hped ${analysis}/HLA/CookHLA/hla_CookHLA.MHC.HLA_IMPUTATION_OUT.hped \
          --2field \
          --pheno ${analysis}/work/hla.pheno \
          --pheno-name sex \
          --out ${analysis}/work/hla_assoc \
          --imgt 3320 \
          --hg 18 \
          --imgt-dir ${hatk}/example/IMGTHLA3320 \
          --multiprocess 8
  deactivate
}
hatk
