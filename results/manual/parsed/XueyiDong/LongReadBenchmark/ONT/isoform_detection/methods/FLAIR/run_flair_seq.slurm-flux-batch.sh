#!/bin/bash
#FLUX: --job-name=buttery-noodle-2573
#FLUX: -c=16
#FLUX: -t=172800
#FLUX: --urgency=16

module load anaconda3
source activate
conda activate flair_env
FLAIR_DIR=/stornext/General/data/user_managed/grpu_mritchie_1/Mei/long_read_benchmark/FLAIR
REF=/stornext/General/data/user_managed/grpu_mritchie_1/Mei/long_read_benchmark/references
FQ_DIR=/stornext/Projects/promethion/promethion_access/lab_ritchie/transcr_bench/long_term/transcr_bench/guppy_4_rebasecall_Oct20/barcode01-06
SUB_FQ_DIR=/stornext/General/data/user_managed/grpu_mritchie_1/Mei/long_read_benchmark/ONT_aligned/subsample_fq
OUT=/vast/scratch/users/du.m/FLAIR
python $FLAIR_DIR/flair.py align \
-g $REF/genome_rnasequin_decoychr_2.4.fa \
-r $FQ_DIR/barcode01.fq.gz $FQ_DIR/barcode02.fq.gz $FQ_DIR/barcode03.fq.gz $FQ_DIR/barcode04.fq.gz $FQ_DIR/barcode05.fq.gz $FQ_DIR/barcode06.fq.gz \
-t 16 \
-v1.3
python $FLAIR_DIR/flair.py correct \
-q $OUT/flair.aligned.bed \
-f $REF/genome_rnasequin_decoychr_2.4_edited_seqremoved.gtf \
-g $REF/genome_rnasequin_decoychr_2.4.fa \
--nvrna \
-t 16
python $FLAIR_DIR/flair.py collapse -g $REF/genome_rnasequin_decoychr_2.4.fa \
-f $REF/genome_rnasequin_decoychr_2.4_edited_seqremoved.gtf \
-r $FQ_DIR/barcode01.fq.gz $FQ_DIR/barcode02.fq.gz $FQ_DIR/barcode03.fq.gz $FQ_DIR/barcode04.fq.gz $FQ_DIR/barcode05.fq.gz $FQ_DIR/barcode06.fq.gz \
-q $OUT/flair_all_corrected.bed \
-s 10 \
-t 16 \
--trust_ends \
--temp_dir $OUT/tmp
python $FLAIR_DIR/flair.py quantify \
-r $OUT/reads_manifest.tsv \
-i $OUT/flair.collapse.isoforms.fa \
--trust_ends \
-t 16 \
--temp_dir $OUT/tmp
