#!/bin/bash
#FLUX: --job-name=makesnps
#FLUX: -c=4
#FLUX: -t=14400
#FLUX: --urgency=16

export LDr2='0.1'
export PLINK2='singularity exec --home $PWD:/home /ess/p697/data/durable/s3-api/github/norment/ofrei_repo/2023_03_27/mixer.sif plink2'
export DATAROOT='/ess/p697/cluster/users/ofrei/ukbdata/projects/plsa_mixer/ukb_genetics_qc/ukb_bed'
export OUTDIR='/ess/p697/cluster/users/ofrei/2023_02_06_GSA_MiXeR_natgen_revisions/simu_snps'
export REP='${SLURM_ARRAY_TASK_ID}'
export REFERENCE='/ess/p697/data/durable/s3-api/github/precimed/mixer_private_docker/reference'
export MAF='0.05'
export OUT='${OUTDIR}/mafBelow10_maf=${MAF}_LDr2=${LDr2}_rep=${REP}'

source /cluster/bin/jobsetup
export LDr2="0.1"
test $SCRATCH && module load singularity/3.7.1 
export PLINK2="singularity exec --home $PWD:/home /ess/p697/data/durable/s3-api/github/norment/ofrei_repo/2023_03_27/mixer.sif plink2"
export DATAROOT="/ess/p697/cluster/users/ofrei/ukbdata/projects/plsa_mixer/ukb_genetics_qc/ukb_bed"
export OUTDIR="/ess/p697/cluster/users/ofrei/2023_02_06_GSA_MiXeR_natgen_revisions/simu_snps"
export REP=${SLURM_ARRAY_TASK_ID}
export REFERENCE="/ess/p697/data/durable/s3-api/github/precimed/mixer_private_docker/reference"
get_seeded_random()
{
  seed="$1"
  openssl enc -aes-256-ctr -pass pass:"$seed" -nosalt </dev/zero 2>/dev/null
}
export MAF="0.05"
export OUT="${OUTDIR}/base_maf=${MAF}_LDr2=${LDr2}_rep=${REP}"
cat ${OUTDIR}/base.snps | shuf --random-source=<(get_seeded_random $REP) | head -n 6000000 > $OUT.tmp1.snps
for i in {1..22}; do $PLINK2 --bfile ${DATAROOT}/ukb_imp_chr${i}_v3_qc_keep1k --maf $MAF --extract $OUT.tmp1.snps --indep-pairwise 3000 1500 $LDr2 --out $OUT.tmp2.chr${i}; done
cat $OUT.tmp2.chr*.prune.in > $OUT.snps
rm $OUT.tmp1.snps $OUT.tmp2.chr*.prune.in $OUT.tmp2.chr*.prune.out $OUT.tmp2.chr*.log
export OUT="${OUTDIR}/CodingUCSC_maf=${MAF}_LDr2=${LDr2}_rep=${REP}"
cat ${OUTDIR}/Coding_UCSC.snps | shuf --random-source=<(get_seeded_random $REP) | head -n 100000 > $OUT.tmp1.snps
for i in {1..22}; do $PLINK2 --bfile ${DATAROOT}/ukb_imp_chr${i}_v3_qc_keep1k --maf $MAF --extract $OUT.tmp1.snps --indep-pairwise 3000 1500 $LDr2 --out $OUT.tmp2.chr${i}; done
cat $OUT.tmp2.chr*.prune.in > $OUT.snps
rm $OUT.tmp1.snps $OUT.tmp2.chr*.prune.in $OUT.tmp2.chr*.prune.out $OUT.tmp2.chr*.log
export OUT="${OUTDIR}/PromoterUCSC_maf=${MAF}_LDr2=${LDr2}_rep=${REP}"
cat ${OUTDIR}/Promoter_UCSC.snps | shuf --random-source=<(get_seeded_random $REP) | head -n 300000 > $OUT.tmp1.snps
for i in {1..22}; do $PLINK2 --bfile ${DATAROOT}/ukb_imp_chr${i}_v3_qc_keep1k --maf $MAF --extract $OUT.tmp1.snps --indep-pairwise 3000 1500 $LDr2 --out $OUT.tmp2.chr${i}; done
cat $OUT.tmp2.chr*.prune.in > $OUT.snps
rm $OUT.tmp1.snps $OUT.tmp2.chr*.prune.in $OUT.tmp2.chr*.prune.out $OUT.tmp2.chr*.log
export OUT="${OUTDIR}/tldBelow50_maf=${MAF}_LDr2=${LDr2}_rep=${REP}"
cat ${OUTDIR}/tldBelow50.snps | shuf --random-source=<(get_seeded_random $REP) | head -n 2600000 > $OUT.tmp1.snps
for i in {1..22}; do $PLINK2 --bfile ${DATAROOT}/ukb_imp_chr${i}_v3_qc_keep1k --maf $MAF --extract $OUT.tmp1.snps --indep-pairwise 3000 1500 $LDr2 --out $OUT.tmp2.chr${i}; done
cat $OUT.tmp2.chr*.prune.in > $OUT.snps
rm $OUT.tmp1.snps $OUT.tmp2.chr*.prune.in $OUT.tmp2.chr*.prune.out $OUT.tmp2.chr*.log
export OUT="${OUTDIR}/tldBelow25_maf=${MAF}_LDr2=${LDr2}_rep=${REP}"
cat ${OUTDIR}/tldBelow25.snps | shuf --random-source=<(get_seeded_random $REP) | head -n 1700000 > $OUT.tmp1.snps
for i in {1..22}; do $PLINK2 --bfile ${DATAROOT}/ukb_imp_chr${i}_v3_qc_keep1k --maf $MAF --extract $OUT.tmp1.snps --indep-pairwise 3000 1500 $LDr2 --out $OUT.tmp2.chr${i}; done
cat $OUT.tmp2.chr*.prune.in > $OUT.snps
rm $OUT.tmp1.snps $OUT.tmp2.chr*.prune.in $OUT.tmp2.chr*.prune.out $OUT.tmp2.chr*.log
export MAF="0.05"
export OUT="${OUTDIR}/mafBelow10_maf=${MAF}_LDr2=${LDr2}_rep=${REP}"
cat ${OUTDIR}/mafBelow10.snps | shuf --random-source=<(get_seeded_random $REP) | head -n 3900000 > $OUT.tmp1.snps
for i in {1..22}; do $PLINK2 --bfile ${DATAROOT}/ukb_imp_chr${i}_v3_qc_keep1k --maf $MAF --extract $OUT.tmp1.snps --indep-pairwise 3000 1500 $LDr2 --out $OUT.tmp2.chr${i}; done
cat $OUT.tmp2.chr*.prune.in > $OUT.snps
rm $OUT.tmp1.snps $OUT.tmp2.chr*.prune.in $OUT.tmp2.chr*.prune.out $OUT.tmp2.chr*.log
