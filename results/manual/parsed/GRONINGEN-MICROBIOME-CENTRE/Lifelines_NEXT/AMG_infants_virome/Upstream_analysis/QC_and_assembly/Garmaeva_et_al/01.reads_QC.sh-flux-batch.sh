#!/bin/bash
#FLUX: --job-name=garmaeva_rQC
#FLUX: -c=2
#FLUX: -t=32340
#FLUX: --urgency=16

SAMPLE_LIST=$1
echo ${SAMPLE_LIST}
SAMPLE_ID=$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${SAMPLE_LIST})
echo "SAMPLE_ID=${SAMPLE_ID}"
mkdir -p ${TMPDIR}/${SAMPLE_ID}/filtering_data/
echo "> copying files to tmpdir"
cp ../SAMPLES/${SAMPLE_ID}/raw_reads/${SAMPLE_ID}_1.fastq.gz ${TMPDIR}/${SAMPLE_ID}/filtering_data/
cp ../SAMPLES/${SAMPLE_ID}/raw_reads/${SAMPLE_ID}_2.fastq.gz ${TMPDIR}/${SAMPLE_ID}/filtering_data/
module purge
module load BBMap
echo "> Trimming adapters" 
bbduk.sh \
        in1=${TMPDIR}/${SAMPLE_ID}/filtering_data/${SAMPLE_ID}_1.fastq.gz \
        in2=${TMPDIR}/${SAMPLE_ID}/filtering_data/${SAMPLE_ID}_2.fastq.gz \
        out1=${TMPDIR}/${SAMPLE_ID}/filtering_data/${SAMPLE_ID}_AdaptTr_1.fastq.gz \
        out2=${TMPDIR}/${SAMPLE_ID}/filtering_data/${SAMPLE_ID}_AdaptTr_2.fastq.gz \
        ref=/scratch/p309176/amg_paper/adapters_UPD_IDT.fa \
        ktrim=r k=23 mink=11 hdist=1 tpe tbo 2>&1 \
        threads=${SLURM_CPUS_PER_TASK} \
        -Xmx$((${SLURM_MEM_PER_NODE} / 1024))g | tee -a ../SAMPLES/${SAMPLE_ID}/${SAMPLE_ID}_bbduk.log
echo "> Removing raw reads"
rm ${TMPDIR}/${SAMPLE_ID}/filtering_data/${SAMPLE_ID}_1.fastq.gz
rm ${TMPDIR}/${SAMPLE_ID}/filtering_data/${SAMPLE_ID}_2.fastq.gz
echo "> Check pairedness of adapter-trimmed fastqs"
reformat.sh \
	in=${TMPDIR}/${SAMPLE_ID}/filtering_data/${SAMPLE_ID}_AdaptTr_1.fastq.gz \
	in2=${TMPDIR}/${SAMPLE_ID}/filtering_data/${SAMPLE_ID}_AdaptTr_2.fastq.gz \
	vpair 2>&1 | tee -a ../SAMPLES/${SAMPLE_ID}/${SAMPLE_ID}_bbduk.log
echo "> Loading Anaconda3 and conda environment"
module load Anaconda3/2022.05
conda activate /scratch/hb-tifn/condas/conda_biobakery3/
kneaddata \
	--input ${TMPDIR}/${SAMPLE_ID}/filtering_data/${SAMPLE_ID}_AdaptTr_1.fastq.gz \
        --input ${TMPDIR}/${SAMPLE_ID}/filtering_data/${SAMPLE_ID}_AdaptTr_2.fastq.gz \
        --threads ${SLURM_CPUS_PER_TASK} \
        --processes 4 \
        --output-prefix ${SAMPLE_ID}_kneaddata \
        --output ${TMPDIR}/${SAMPLE_ID}/filtering_data \
        --log ../SAMPLES/${SAMPLE_ID}/${SAMPLE_ID}_kneaddata.log \
        -db /scratch/hb-tifn/DBs/human_genomes/GRCh38p13  \
        --trimmomatic /scratch/hb-tifn/condas/conda_biobakery4/share/trimmomatic-0.39-2/ \
        --run-trim-repetitive \
        --fastqc fastqc \
        --sequencer-source none \
        --trimmomatic-options "LEADING:20 TRAILING:20 SLIDINGWINDOW:4:20 MINLEN:50" \
        --bypass-trf \
        --reorder
echo "> Removing kneaddata byproducts and adapter-trimmed fastqs"
rm ${TMPDIR}/${SAMPLE_ID}/filtering_data/${SAMPLE_ID}_AdaptTr_1.fastq.gz
rm ${TMPDIR}/${SAMPLE_ID}/filtering_data/${SAMPLE_ID}_AdaptTr_2.fastq.gz
rm ${TMPDIR}/${SAMPLE_ID}/filtering_data/${SAMPLE_ID}_kneaddata_GRCh38p13_bowtie2_paired_contam_1.fastq
rm ${TMPDIR}/${SAMPLE_ID}/filtering_data/${SAMPLE_ID}_kneaddata_GRCh38p13_bowtie2_paired_contam_2.fastq
rm ${TMPDIR}/${SAMPLE_ID}/filtering_data/${SAMPLE_ID}_kneaddata_GRCh38p13_bowtie2_unmatched_1_contam.fastq
rm ${TMPDIR}/${SAMPLE_ID}/filtering_data/${SAMPLE_ID}_kneaddata_GRCh38p13_bowtie2_unmatched_2_contam.fastq
rm ${TMPDIR}/${SAMPLE_ID}/filtering_data/${SAMPLE_ID}_kneaddata.trimmed.1.fastq
rm ${TMPDIR}/${SAMPLE_ID}/filtering_data/${SAMPLE_ID}_kneaddata.trimmed.2.fastq
rm ${TMPDIR}/${SAMPLE_ID}/filtering_data/${SAMPLE_ID}_kneaddata.trimmed.single.1.fastq
rm ${TMPDIR}/${SAMPLE_ID}/filtering_data/${SAMPLE_ID}_kneaddata.trimmed.single.2.fastq
echo "> Check pairedness of kneaddata-filtered reads"
reformat.sh \
        in=${TMPDIR}/${SAMPLE_ID}/filtering_data/${SAMPLE_ID}_kneaddata_paired_1.fastq \
        in2=${TMPDIR}/${SAMPLE_ID}/filtering_data/${SAMPLE_ID}_kneaddata_paired_2.fastq \
        vpair 2>&1 | tee -a ../SAMPLES/${SAMPLE_ID}/${SAMPLE_ID}_bbduk.log
echo "> Moving resulting clean reads to scratch"
if [ -f ../SAMPLES/${SAMPLE_ID}/${SAMPLE_ID}_kneaddata.log ] && ! grep -qi 'error' ../SAMPLES/${SAMPLE_ID}/${SAMPLE_ID}_kneaddata.log; then
	echo "Kneaddata is done"
	mkdir -p ../SAMPLES/${SAMPLE_ID}/clean_reads/
	mv ${TMPDIR}/${SAMPLE_ID}/filtering_data/${SAMPLE_ID}_kneaddata_paired_1.fastq ../SAMPLES/${SAMPLE_ID}/clean_reads/
	mv ${TMPDIR}/${SAMPLE_ID}/filtering_data/${SAMPLE_ID}_kneaddata_paired_2.fastq ../SAMPLES/${SAMPLE_ID}/clean_reads/
	mv ${TMPDIR}/${SAMPLE_ID}/filtering_data/${SAMPLE_ID}_kneaddata_unmatched_1.fastq ../SAMPLES/${SAMPLE_ID}/clean_reads/
	mv ${TMPDIR}/${SAMPLE_ID}/filtering_data/${SAMPLE_ID}_kneaddata_unmatched_2.fastq ../SAMPLES/${SAMPLE_ID}/clean_reads/
else
	echo "Kneaddata processing or an earlier step is corrupted"
fi
echo "> Removing data from tmpdir"
rm -r ${TMPDIR}/${SAMPLE_ID}/filtering_data
if [ -f ../SAMPLES/${SAMPLE_ID}/clean_reads/${SAMPLE_ID}_kneaddata_paired_1.fastq ]; then
	cat ../SAMPLES/${SAMPLE_ID}/clean_reads/${SAMPLE_ID}_kneaddata_unmatched_1.fastq \
	../SAMPLES/${SAMPLE_ID}/clean_reads/${SAMPLE_ID}_kneaddata_unmatched_2.fastq > \
	../SAMPLES/${SAMPLE_ID}/clean_reads/${SAMPLE_ID}_kneaddata_unmatched.fastq
	echo ">Compressing reads"
	pigz -p ${SLURM_CPUS_PER_TASK} ../SAMPLES/${SAMPLE_ID}/clean_reads/*.fastq
	echo "> Generating md5sums"
	md5sum ../SAMPLES/${SAMPLE_ID}/clean_reads/${SAMPLE_ID}_kneaddata_paired_1.fastq > ../SAMPLES/${SAMPLE_ID}/MD5.txt
	md5sum ../SAMPLES/${SAMPLE_ID}/clean_reads/${SAMPLE_ID}_kneaddata_paired_2.fastq >> ../SAMPLES/${SAMPLE_ID}/MD5.txt
	md5sum ../SAMPLES/${SAMPLE_ID}/clean_reads/${SAMPLE_ID}_kneaddata_unmatched_1.fastq >> ../SAMPLES/${SAMPLE_ID}/MD5.txt
	md5sum ../SAMPLES/${SAMPLE_ID}/clean_reads/${SAMPLE_ID}_kneaddata_unmatched_2.fastq >> ../SAMPLES/${SAMPLE_ID}/MD5.txt
	module load FastQC
        fastqc -o ../FastQC_reports/ -t ${SLURM_CPUS_PER_TASK} ../SAMPLES/${SAMPLE_ID}/clean_reads/${SAMPLE_ID}_kneaddata_paired_1.fastq.gz
        fastqc -o ../FastQC_reports/ -t ${SLURM_CPUS_PER_TASK} ../SAMPLES/${SAMPLE_ID}/clean_reads/${SAMPLE_ID}_kneaddata_paired_2.fastq.gz
        fastqc -o ../FastQC_reports/ -t ${SLURM_CPUS_PER_TASK} ../SAMPLES/${SAMPLE_ID}/clean_reads/${SAMPLE_ID}_kneaddata_unmatched_1.fastq.gz
        fastqc -o ../FastQC_reports/ -t ${SLURM_CPUS_PER_TASK} ../SAMPLES/${SAMPLE_ID}/clean_reads/${SAMPLE_ID}_kneaddata_unmatched_2.fastq.gz
	echo "> Launching sc assembly"
	bash runAllSamples_02.bash ${SAMPLE_ID}
fi
module list
module purge
