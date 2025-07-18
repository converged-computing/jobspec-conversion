#!/bin/bash
#FLUX: --job-name=butterscotch-diablo-9998
#FLUX: -c=36
#FLUX: --queue=dev,gpu,intel,assembly
#FLUX: -t=10800
#FLUX: --urgency=16

start=`date +%s`
hostname
echo "My SLURM_JOB_ID"
echo $SLURM_JOB_ID
module load bcl2fastq
runfolder=$1
outfolder=$2
scriptfolder=$3
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
samplesheet=`sed "${SLURM_ARRAY_TASK_ID}q;d" ${outfolder}/all_sample_sheets.txt`
projectfolder=${samplesheet%.SampleSheet.csv}
ln -s ${outfolder}/slurm_${SLURM_ARRAY_TASK_ID}.out ${projectfolder}.slurm.out
echo run_bcl2fastq.pl $runfolder/RunInfo.xml $samplesheet $runfolder $outfolder
${scriptfolder}/run_bcl2fastq.pl $runfolder/RunInfo.xml $samplesheet $runfolder $outfolder
if [ $? -ne 0 ]
then
    touch ${outfolder}/flags/error_flag$SLURM_ARRAY_TASK_ID
fi
cp ${samplesheet} ${projectfolder}
touch ${outfolder}/flags/done_flag$SLURM_ARRAY_TASK_ID
end=`date +%s`
runtime=$((end-start))
echo $runtime
