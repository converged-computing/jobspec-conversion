#!/bin/bash
#SBATCH --job-name=htstream
#SBATCH --account=epigenetics
#SBATCH --output=slurm_out/htstream_%A_%a.out
#SBATCH --error=slurm_out/htstream_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=9
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=15000
#SBATCH --time=12:00:00
#SBATCH --partition=production
#SBATCH --array=1-8

start=`date +%s`
echo $HOSTNAME
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
inpath="00-RawData"
sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" samples.txt | awk -F '\t'  '{print $1}'`
r1=${inpath}/${sample}/${sample}*_R1*.fastq.gz
r2=${inpath}/${sample}/${sample}*_R2*.fastq.gz
outpath='01-HTS_Preproc'
[[ -d ${outpath} ]] || mkdir ${outpath}
[[ -d ${outpath}/${sample} ]] || mkdir ${outpath}/${sample}
echo "SAMPLE: ${sample}"
module load htstream/1.3.2
call="hts_Stats -L ${outpath}/${sample}/${sample}_htsStats.log -1 ${r1} -2 ${r2} -N 'initial Stats' | \
      hts_SeqScreener -A  ${outpath}/${sample}/${sample}_htsStats.log -N 'PhiX check' | \
      hts_SuperDeduper -e 250000 -A  ${outpath}/${sample}/${sample}_htsStats.log -N 'Remove PCR duplicates' | \
      hts_AdapterTrimmer -p 4 -A  ${outpath}/${sample}/${sample}_htsStats.log -N 'Overlap and remove adapters' | \
      hts_NTrimmer -A ${outpath}/${sample}/${sample}_htsStats.log -N 'Remove all Ns' | \
      hts_QWindowTrim -A ${outpath}/${sample}/${sample}_htsStats.log -N 'Quality trim' | \
      hts_LengthFilter -n -m 50 -A ${outpath}/${sample}/${sample}_htsStats.log -N 'Remove too short' | \
      hts_Stats -A ${outpath}/${sample}/${sample}_htsStats.log -F -f ${outpath}/${sample}/${sample} -N 'end Stats'"
echo $call
eval $call
end=`date +%s`
runtime=$((end-start))
echo $runtime
