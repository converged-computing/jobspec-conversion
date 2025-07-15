#!/bin/bash
#FLUX: --job-name=adorable-kerfuffle-9178
#FLUX: -c=24
#FLUX: --queue=demultiplexing
#FLUX: --urgency=16

app_version=2.2.0
app_dir=/data/diagnostics/pipelines/TSO500/illumina_app/TSO500_RUO_LocalApp-"$app_version"
pipeline_version=main
pipeline_dir=/data/diagnostics/pipelines/TSO500/TSO500_post_processing-"$pipeline_version"
pipeline_scripts="$pipeline_dir"/scripts
cd $SLURM_SUBMIT_DIR
mkdir Demultiplex_Output
mkdir analysis
module purge
module load singularity
. ~/.bashrc
module load anaconda
set -euo pipefail
ln -s "$app_dir"/trusight-oncology-500-ruo.img .
now=$(date +"%T")
echo "Start time: $now" > timings.txt
"$app_dir"/TruSight_Oncology_500_RUO.sh \
  --resourcesFolder "$app_dir"/resources \
  --analysisFolder "$SLURM_SUBMIT_DIR"/Demultiplex_Output \
  --runFolder "$raw_data" \
  --engine singularity \
  --sampleSheet "$raw_data"/SampleSheet.csv \
  --isNovaSeq \
  --demultiplexOnly
set +u
conda activate TSO500_post_processing
set -u
cp "$raw_data"/SampleSheet.csv .
sed -n -e '/Sample_ID,Sample_Name/,$p' SampleSheet.csv >> SampleSheet_updated.csv
python "$pipeline_scripts"/filter_sample_list.py
set +u
conda deactivate
conda activate read_count
set -u
python /data/diagnostics/scripts/read_count_visualisation.py
set +u
conda deactivate
conda activate TSO500_post_processing
set -u
> completed_samples.txt
dos2unix SampleSheet_updated.csv
for file in *samples_correct_order*_RNA.csv*;
do
if [ -f "$file" ];
then
	cat samples_correct_order*_RNA.csv | while read line; do
	    sample_id=$(echo ${line} | cut -f 1 -d ",")
	    echo kicking off pipeline for $sample_id
	    sbatch \
	      --export=raw_data="$raw_data",sample_id="$sample_id" \
	      --output="$sample_id"_2_TSO500-%j-%N.out \
	      --error="$sample_id"_2_TSO500-%j-%N.err \
	      2_TSO500.sh
	done
fi
done
mkdir DNA_Analysis
cp samples_correct_order_*_DNA.csv ./DNA_Analysis
cd DNA_Analysis
mkdir Raw_Reads
while read samples
do
    sampleID=$(echo ${samples} | cut -f 1 -d ",")
    mkdir Raw_Reads/${sampleID}/
    #Combine L001 to a single fastq file
    cat ../Demultiplex_Output/Logs_Intermediates/FastqGeneration/${sampleID}/${sampleID}_S*_L001_R1_001.fastq.gz ../Demultiplex_Output/Logs_Intermediates/FastqGeneration/${sampleID}/${sampleID}_S*_L002_R1_001.fastq.gz > Raw_Reads/${sampleID}/${sampleID}_R1.fastq.gz
    #Combine L002 to a single fastq file
    cat ../Demultiplex_Output/Logs_Intermediates/FastqGeneration/${sampleID}/${sampleID}_S*_L001_R2_001.fastq.gz ../Demultiplex_Output/Logs_Intermediates/FastqGeneration/${sampleID}/${sampleID}_S*_L002_R2_001.fastq.gz > Raw_Reads/${sampleID}/${sampleID}_R2.fastq.gz
done < samples_correct_order_*_DNA.csv
runid=$(basename "$raw_data")
set +u
conda deactivate
set -u
echo "Kicking off DNA Nextflow"
sbatch /data/diagnostics/pipelines/TSO500/TSO500_post_processing-main/TSO500_DNA_nextflow.sh /data/output/results/${runid}/TSO500/DNA_Analysis/Raw_Reads/ /data/output/results/${runid}/TSO500/DNA_Analysis/samples_correct_order_*_DNA.csv ${runid}
