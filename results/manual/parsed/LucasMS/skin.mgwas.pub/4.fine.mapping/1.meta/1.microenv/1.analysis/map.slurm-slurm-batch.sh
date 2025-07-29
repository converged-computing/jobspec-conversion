#!/bin/bash
#SBATCH --output=/work_ifs/sukmb447/projects/skin.mgwas/results/4.fine.mapping/1.meta/1.microenv/1.analysis/log/%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4gb
#SBATCH --time=4-04:00:00

cd $SLURM_SUBMIT_DIR
INDEX="/work_ifs/sukmb447/projects/skin.mgwas/results/4.fine.mapping/1.meta/1.microenv/1.analysis/paths.txt"
WORKDIR=$(head -${SLURM_ARRAY_TASK_ID} $INDEX | tail -1)
INPUTDIR=${WORKDIR}"/input"
TEMPDIR=${WORKDIR}"/temp"
OUTPUTDIR=${WORKDIR}"/results"
PLINK="/work_ifs/sukmb447/projects/skin.mgwas/kora.popgen.pca/PopGen_and_KORA.harmonized.all"
GENOME="/work_ifs/sukmb447/apps/locus.db/locuszoom_hg19.db"
BETA='typebeta'
FINEMAP='/work_ifs/sukmb447/apps/finemapping.onlylocus/finemapping/main.nf' 
cd $WORKDIR
mkdir $TEMPDIR
cd $TEMPDIR
module load nextflow singularity
if [[ "$INPUTDIR" == *"$BETA"* ]]
then
nextflow run $FINEMAP -profile standard --locus ${INPUTDIR}/chunks.olap --snps ${INPUTDIR}/snps.sorted --reference ${PLINK} --sumstats ${INPUTDIR}/summary.tsv --nsum 597 --nsignal 1 --method sss --output ${TEMPDIR}/results  --locuszoomdb ${GENOME} --onlylocus
else
nextflow run $FINEMAP -profile standard --locus ${INPUTDIR}/chunks.olap --snps ${INPUTDIR}/snps.sorted --reference ${PLINK} --sumstats ${INPUTDIR}/summary.tsv --nsum 597 --nsignal 1 --method sss --output ${TEMPDIR}/results  --locuszoomdb ${GENOME}
fi
mv ${TEMPDIR}/results/PopGen_and_KORA.harmonized/*/ $OUTPUTDIR/ &&
rm -rf $TEMPDIR
cp $OUTPUTDIR/*_*_*/*.pdf $WORKDIR/
