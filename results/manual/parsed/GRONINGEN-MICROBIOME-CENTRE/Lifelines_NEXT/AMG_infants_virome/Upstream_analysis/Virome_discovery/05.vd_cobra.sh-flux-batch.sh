#!/bin/bash
#FLUX: --job-name=ViromeDiscovery
#FLUX: -c=8
#FLUX: -t=39540
#FLUX: --urgency=16

SAMPLE_LIST=$1
echo ${SAMPLE_LIST}
SAMPLE_ID=$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${SAMPLE_LIST})
echo "SAMPLE_ID=${SAMPLE_ID}"
mkdir -p ${TMPDIR}/${SAMPLE_ID}/COBRA
module purge
module load Bowtie2
module load SAMtools
module list
cp ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/${SAMPLE_ID}_all_predicted_viral.fasta ${TMPDIR}/${SAMPLE_ID}/COBRA
if [ -s ${TMPDIR}/${SAMPLE_ID}/COBRA/${SAMPLE_ID}_all_predicted_viral.fasta ]; then
	echo "The file has contigs."
else
	echo "The file is empty. Exiting..."
	exit 1
fi
sed -i 's/^[^_]*_/>/' ${TMPDIR}/${SAMPLE_ID}/COBRA/${SAMPLE_ID}_all_predicted_viral.fasta
bowtie2-build \
	../SAMPLES/${SAMPLE_ID}/01_sc_assembly/${SAMPLE_ID}_contigs.fasta \
	${TMPDIR}/${SAMPLE_ID}/COBRA/${SAMPLE_ID}
bowtie2 \
	--very-sensitive \
	-x ${TMPDIR}/${SAMPLE_ID}/COBRA/${SAMPLE_ID} \
	-1 ../SAMPLES/${SAMPLE_ID}/clean_reads/${SAMPLE_ID}_dedup_paired_1.fastq.gz \
	-2 ../SAMPLES/${SAMPLE_ID}/clean_reads/${SAMPLE_ID}_dedup_paired_2.fastq.gz \
	--no-unal \
	--threads ${SLURM_CPUS_PER_TASK} \
	-S ${TMPDIR}/${SAMPLE_ID}/COBRA/${SAMPLE_ID}.sam \
	&> ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/COBRA_bowtie2.log
samtools view \
	-bS \
	${TMPDIR}/${SAMPLE_ID}/COBRA/${SAMPLE_ID}.sam \
	> ${TMPDIR}/${SAMPLE_ID}/COBRA/${SAMPLE_ID}.bam
samtools sort \
	-o ${TMPDIR}/${SAMPLE_ID}/COBRA/${SAMPLE_ID}_sorted.bam \
	${TMPDIR}/${SAMPLE_ID}/COBRA/${SAMPLE_ID}.bam
samtools index \
	-@ $((${SLURM_CPUS_PER_TASK}-1)) \
	${TMPDIR}/${SAMPLE_ID}/COBRA/${SAMPLE_ID}_sorted.bam
module purge
module load Anaconda3
module list
source activate /scratch/hb-llnext/conda_envs/CoverM_env
conda list
coverm contig \
	--coupled ../SAMPLES/${SAMPLE_ID}/clean_reads/${SAMPLE_ID}_dedup_paired_1.fastq.gz ../SAMPLES/${SAMPLE_ID}/clean_reads/${SAMPLE_ID}_dedup_paired_2.fastq.gz \
       	--reference ../SAMPLES/${SAMPLE_ID}/01_sc_assembly/${SAMPLE_ID}_contigs.fasta \
	-o ${TMPDIR}/${SAMPLE_ID}/COBRA/${SAMPLE_ID}_coverage.txt
sed -i '1d' ${TMPDIR}/${SAMPLE_ID}/COBRA/${SAMPLE_ID}_coverage.txt 
conda deactivate
module purge
module load BLAST+
source /home1/p309176/venvs/cobra_env/bin/activate
module list
cobra-meta \
    -f ../SAMPLES/${SAMPLE_ID}/01_sc_assembly/${SAMPLE_ID}_contigs.fasta \
    -q ${TMPDIR}/${SAMPLE_ID}/COBRA/${SAMPLE_ID}_all_predicted_viral.fasta \
    -c ${TMPDIR}/${SAMPLE_ID}/COBRA/${SAMPLE_ID}_coverage.txt \
    -m ${TMPDIR}/${SAMPLE_ID}/COBRA/${SAMPLE_ID}_sorted.bam \
    -a metaspades \
    -mink 21 \
    -maxk 127 \
    -o ${TMPDIR}/${SAMPLE_ID}/COBRA/RESULT
sed "s/^>/>${SAMPLE_ID}_/" ${TMPDIR}/${SAMPLE_ID}/COBRA/RESULT/*.fasta > ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/${SAMPLE_ID}_extended_viral.fasta
N_EXT_CONTIGS=$(grep '>' ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/${SAMPLE_ID}_extended_viral.fasta | wc -l)
N_VIR_CONTIGS=$(grep '>' ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/${SAMPLE_ID}_all_predicted_viral.fasta | wc -l)
if [ $N_EXT_CONTIGS -eq $N_VIR_CONTIGS ]; then
    echo "Number of extended and original viral contigs is equal"
else
    echo "Number of extended and original viral contigs is unequal"
fi
echo "$N_EXT_CONTIGS contigs in the resulting fasta"
mkdir ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/COBRA
cp ${TMPDIR}/${SAMPLE_ID}/COBRA/RESULT/COBRA_joining_summary.txt ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/COBRA/
cp ${TMPDIR}/${SAMPLE_ID}/COBRA/RESULT/log ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/COBRA/COBRA.log
mv ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/COBRA*.log ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/COBRA/
deactivate
mkdir -p ${TMPDIR}/${SAMPLE_ID}/POST_COBRA_Q
module purge
module load QUAST
module list
quast.py \
        ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/${SAMPLE_ID}_all_predicted_viral.fasta \
        -o ${TMPDIR}/${SAMPLE_ID}/POST_COBRA_Q/pre \
        -m $((${SLURM_MEM_PER_NODE} / 1024)) \
        --threads ${SLURM_CPUS_PER_TASK}
cp ${TMPDIR}/${SAMPLE_ID}/POST_COBRA_Q/pre/report.tsv ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/COBRA/pre_report.tsv
quast.py \
        ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/${SAMPLE_ID}_extended_viral.fasta \
        -o ${TMPDIR}/${SAMPLE_ID}/POST_COBRA_Q/post \
        -m $((${SLURM_MEM_PER_NODE} / 1024)) \
        --threads ${SLURM_CPUS_PER_TASK}
cp ${TMPDIR}/${SAMPLE_ID}/POST_COBRA_Q/post/report.tsv ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/COBRA/post_report.tsv
TOTAL_LENGTH_PRE=$(grep 'Total length (>= 0 bp)' ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/COBRA/pre_report.tsv | awk -F '\t' '{print $2}')
echo "TOTAL LENGTH OF VIRUSES: ${TOTAL_LENGTH_PRE}"
TOTAL_LENGTH_POST=$(grep 'Total length (>= 0 bp)' ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/COBRA/post_report.tsv | awk -F '\t' '{print $2}')
echo "TOTAL LENGTH AFTER EXTENSION: ${TOTAL_LENGTH_POST}"
if [ ${TOTAL_LENGTH_PRE} -le ${TOTAL_LENGTH_POST} ]; then
    echo "Length of extended contigs is larger than that of original contigs"
else
    echo "Extension error, extended contigs are shorter"
fi
if [ $(grep 'for joining details of' ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/COBRA/COBRA.log | wc -l) -eq 1 ]; then
	echo "COBRA finished"
else
	echo "COBRA failed"
fi
module purge
