#!/bin/bash
#FLUX: --job-name=milky-peanut-butter-7628
#FLUX: -c=8
#FLUX: -t=172800
#FLUX: --priority=16

module load anaconda3
source activate
conda activate flair_env
FLAIR_DIR=/stornext/General/data/user_managed/grpu_mritchie_1/Mei/long_read_benchmark/FLAIR
REF=/stornext/General/data/user_managed/grpu_mritchie_1/Mei/long_read_benchmark/references
FQ_DIR=/stornext/General/data/user_managed/grpu_mritchie_1/Mei/long_read_benchmark/ONT_aligned/subsample_fq
OUT=/vast/scratch/users/du.m/subsample/FLAIR
python $FLAIR_DIR/flair.py align \
-g $REF/genome_rnasequin_decoychr_2.4.fa \
-r $FQ_DIR/barcode01_sub_10.fq.gz $FQ_DIR/barcode02_sub_10.fq.gz $FQ_DIR/barcode03_sub_10.fq.gz $FQ_DIR/barcode04_sub_10.fq.gz $FQ_DIR/barcode05_sub_10.fq.gz $FQ_DIR/barcode06_sub_10.fq.gz \
-t 8 \
-v1.3
python $FLAIR_DIR/flair.py correct \
-q $OUT/flair.aligned.bed \
-f $REF/genome_rnasequin_decoychr_2.4_edited_seqremoved.gtf \
-g $REF/genome_rnasequin_decoychr_2.4.fa \
--nvrna \
-t 8
python $FLAIR_DIR/flair.py collapse \
-g $REF/genome_rnasequin_decoychr_2.4.fa \
-f $REF/genome_rnasequin_decoychr_2.4_edited_seqremoved.gtf \
-r $FQ_DIR/barcode01_sub_10.fq.gz $FQ_DIR/barcode02_sub_10.fq.gz $FQ_DIR/barcode03_sub_10.fq.gz $FQ_DIR/barcode04_sub_10.fq.gz $FQ_DIR/barcode05_sub_10.fq.gz $FQ_DIR/barcode06_sub_10.fq.gz \
-q $OUT/flair_all_corrected.bed \
-s 10 \
-t 8 \
--trust_ends \
--temp_dir $OUT/tmp
python $FLAIR_DIR/flair.py quantify \
-r $OUT/reads_manifest_sub.tsv \
-i $OUT/flair.collapse.isoforms.fa \
-t 8 \
--trust_ends \
--temp_dir $OUT/tmp
