#!/bin/bash
#FLUX: --job-name=htstream
#FLUX: -n=9
#FLUX: --queue=gc
#FLUX: -t=3600
#FLUX: --urgency=16

start=`date +%s`
echo $HOSTNAME
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" samples.txt`
outpath='01-HTS_Preproc'
[[ -d ${outpath} ]] || mkdir ${outpath}
[[ -d ${outpath}/${sample} ]] || mkdir ${outpath}/${sample}
echo "SAMPLE: ${sample}"
module load htstream
call="hts_Stats -O -L ${outpath}/${sample}/${sample}_htsStats.log -1 00-RawData/${sample}/*R1* -2 00-RawData/${sample}/*R2* | \
      hts_SeqScreener -S -O -A -L ${outpath}/${sample}/${sample}_htsStats.log | \
      hts_SuperDeduper -e 250000 -S -O -A -L ${outpath}/${sample}/${sample}_htsStats.log | \
      hts_SeqScreener -s ref/rrna.fasta -r -S -O -A -L ${outpath}/${sample}/${sample}_htsStats.log | \
      hts_AdapterTrimmer -n -S -O -A -L ${outpath}/${sample}/${sample}_htsStats.log | \
      hts_QWindowTrim -n -S -O -A -L ${outpath}/${sample}/${sample}_htsStats.log | \
      hts_NTrimmer -n -S -O -A -L ${outpath}/${sample}/${sample}_htsStats.log | \
      hts_CutTrim -n -m 50 -S -O -A -L ${outpath}/${sample}/${sample}_htsStats.log | \
      hts_Stats -S -A -L ${outpath}/${sample}/${sample}_htsStats.log -g -p ${outpath}/${sample}/${sample}"
echo $call
eval $call
end=`date +%s`
runtime=$((end-start))
echo $runtime
