#!/bin/bash
#FLUX: --job-name=placid-lemon-1171
#FLUX: --queue=defq,long
#FLUX: --priority=16

module load cutadapt
declare -a read_array=("SRR9623676" "SRR9623677" "SRR9623678" "SRR9623679" "SRR9623680" "SRR9623681" "SRR9623682" "SRR9623683" "SRR9623684" "SRR9623685" "SRR9623686" "SRR9623687" "SRR9623688" "SRR9623689" "SRR9623690" "SRR9623691" "SRR9623692" "SRR9623693" "SRR9623694" "SRR9623695" "SRR9623696" "SRR9623697" "SRR9623698" "SRR9623699" "SRR9623700" "SRR9623701" "SRR9623702" "SRR9623703" "SRR9623704" "SRR9623705" "SRR9623706" "SRR9623707" "SRR9623708" "SRR9623709" "SRR9623710" "SRR9623711" "SRR9623712" "SRR9623713" "SRR9623714" "SRR9623715" "SRR9623716" "SRR9623717" "SRR9623718" "SRR9623719" "SRR9623720" "SRR9623721" "SRR9623722" "SRR9623723" "SRR9623724" "SRR9623725" "SRR9623726" "SRR9623727" "SRR9623728" "SRR9623729" "SRR9623730" "SRR9623731" "SRR9623732" "SRR9623733" "SRR9623734" "SRR9623735" "SRR6059540" "SRR6059541" "SRR6059542" "SRR6059543" "SRR6059544" "SRR6059545" "SRR6059546" "SRR6059547" "SRR6059548" "SRR6059549" "SRR6059550" "SRR6059551" "SRR6059552" "SRR6059553" "SRR6059554" "SRR6059555" "SRR6059556" "SRR6059557" "SRR6059558" "SRR6059559" "SRR6059560" "SRR6059561" "SRR6059562" "SRR6059563" "SRR6059564" "SRR6059565" "SRR6059566" "SRR6059567" "SRR6059568" "SRR6059569" "SRR6059570" "SRR6059571" "SRR6059572" "SRR6059573" "SRR6059574" "SRR6059575" "SRR6059576" "SRR6059577" "SRR6059578" "SRR6059579" "SRR6059580" "SRR6059581" "SRR6059582" "SRR6059583" "SRR6059584" "SRR6059585" "SRR6059586" "SRR6059587" "SRR6059588" "SRR6059589" "SRR6059590" "SRR6059591" "SRR6059592" "SRR6059593" "SRR6059594" "SRR6059595" "SRR6059596" "SRR6059597" "SRR6059598" "SRR6059599" "SRR6059600" "SRR6059601" "SRR6059602" "SRR6059603")
source ~/.bashrc
cd $READ_DIRECTORY
conda activate rnaseqpipe
trim_galore -j $CORES -q 30 --basename ${read_array[$SLURM_ARRAY_TASK_ID]} --paired --fastqc_args "--outdir fastqc_output" ${read_array[$SLURM_ARRAY_TASK_ID]}*1.fastq.gz ${read_array[$SLURM_ARRAY_TASK_ID]}*2.fastq.gz
STAR --genomeDir $STAR_INDEX --readFilesIn ${read_array[$SLURM_ARRAY_TASK_ID]}_val_1.fq.gz ${read_array[$SLURM_ARRAY_TASK_ID]}_val_2.fq.gz --outReadsUnmapped None --runThreadN $CORES --outTmpDir $TMPDIR --outFileNamePrefix $STAR_OUTPUT/${read_array[$SLURM_ARRAY_TASK_ID]}_ --twopassMode Basic --readFilesCommand "gunzip -c" --outSAMstrandField intronMotif --outSAMunmapped Within --chimSegmentMin 12 --chimJunctionOverhangMin 8 --chimOutJunctionFormat 1 --alignSJDBoverhangMin 10 --alignMatesGapMax 100000 --alignIntronMax 100000 --alignSJstitchMismatchNmax 5 -1 5 5 --outSAMattrRGline ID:GRPundef --chimMultimapScoreRange 3 --chimScoreJunctionNonGTAG -4 --chimMultimapNmax 20 --chimNonchimScoreDropMin 10 --peOverlapNbasesMin 12 --peOverlapMMp 0.1 --alignInsertionFlush Right --alignSplicedMateMapLminOverLmate 0 --alignSplicedMateMapLmin 30 
samtools sort -@ $CORES $STAR_OUTPUT/${read_array[$SLURM_ARRAY_TASK_ID]}_Aligned.out.sam -o ${read_array[$SLURM_ARRAY_TASK_ID]}.sorted.bam  
mv ${read_array[$SLURM_ARRAY_TASK_ID]}.sorted.bam $STAR_OUTPUT/sorted_bams/
stringtie ${read_array[$SLURM_ARRAY_TASK_ID]}.sorted.bam \
-eB \
-l ${read_array[$SLURM_ARRAY_TASK_ID]}
-G $GTF \
-o ${read_array[$SLURM_ARRAY_TASK_ID]}
STAR-Fusion --genome_lib_dir $CTAT_LIB -J $STAR_OUTPUT/${read_array[$SLURM_ARRAY_TASK_ID]}_Chimeric.out.junction --output_dir $FUSION_OUTPUT/${read_array[$SLURM_ARRAY_TASK_ID]} 
FusionInspector --fusions $FUSION_OUTPUT/${read_array[$SLURM_ARRAY_TASK_ID]}/star-fusion.fusion_predictions.abridged.tsv  --out_prefix ${read_array[$SLURM_ARRAY_TASK_ID]} --min_junction_reads 1  --min_novel_junction_support 3 --min_spanning_frags_only 5 --vis --max_promiscuity 10 --output_dir $FUSION_OUTPUT/${read_array[$SLURM_ARRAY_TASK_ID]}/FusionInspector --genome_lib_dir $CTAT_LIB --CPU $CORES --include_Trinity  --annotate --left_fq reads_dir/${read_array[$SLURM_ARRAY_TASK_ID]}_val_1.fq.gz --right_fq reads_dir/${read_array[$SLURM_ARRAY_TASK_ID]}_val_2.fq.gz
conda deactivate
conda activate majiq
majiq build -j $CORES -c config.cfg -o $MAJIQ_OUT $GFF3
voila view splicegraph.sql $MAJIQ_OUT/normal_tumour.deltapsi.voila
