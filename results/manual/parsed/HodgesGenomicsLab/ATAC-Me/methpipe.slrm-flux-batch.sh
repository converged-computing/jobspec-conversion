#!/bin/bash
#FLUX: --job-name="MethPipe"
#FLUX: -t=57600
#FLUX: --priority=16

export LC_ALL='C'

export LC_ALL=C
MAPPED=`basename $SAM _val_1.fq.sam`
module load Intel/2016.3.210-GCC-5.4.0-2.26 SAMtools/1.6
samtools view -Sb  ${SAM}  >  ${PROCESSED_DIR}/${MAPPED}.bam
to-mr -o ${PROCESSED_DIR}/${MAPPED}.mr -m general ${PROCESSED_DIR}/${MAPPED}.bam
sort -k 1,1 -k 2,2n -k 3,3n -k 6,6 -T ${PROCESSED_DIR} ${PROCESSED_DIR}/${MAPPED}.mr -o ${PROCESSED_DIR}/${MAPPED}.sort.mr
duplicate-remover -s -A -S ${PROCESSED_DIR}/${MAPPED}.dupstats -o ${PROCESSED_DIR}/${MAPPED}.mr.dremove ${PROCESSED_DIR}/${MAPPED}.sort.mr
bsrate  -c ${CHROM_DIR} ${PROCESSED_DIR}/${MAPPED}.mr.dremove -o ${PROCESSED_DIR}/${MAPPED}.bsrate
methstates -c ${CHROM_DIR} ${PROCESSED_DIR}/${MAPPED}.mr.dremove -o ${PROCESSED_DIR}/${MAPPED}.epiread
methcounts -c ${CHROM_DIR} -o ${PROCESSED_DIR}/${MAPPED}.all.meth ${PROCESSED_DIR}/${MAPPED}.mr.dremove
levels -o ${PROCESSED_DIR}/${MAPPED}.levels  ${PROCESSED_DIR}/${MAPPED}.all.meth
symmetric-cpgs -m -o ${PROCESSED_DIR}/${MAPPED}.meth ${PROCESSED_DIR}/${MAPPED}.all.meth
hmr -o ${PROCESSED_DIR}/${MAPPED}.hmr  -p ${PROCESSED_DIR}/${MAPPED}.hmrparams  ${PROCESSED_DIR}/${MAPPED}.meth
awk '{OFS="\t"; print $1,$2,$2+1,$6}' < ${PROCESSED_DIR}/${MAPPED}.meth | wigToBigWig /dev/stdin ${SIZES_DIR} ${TRACK_DIR}/${MAPPED}.read.bw
awk '{OFS="\t"; print $1,$2,$2+1,$5}' < ${PROCESSED_DIR}/${MAPPED}.meth | wigToBigWig /dev/stdin ${SIZES_DIR} ${TRACK_DIR}/${MAPPED}.meth.bw
cut -f 1-3 ${PROCESSED_DIR}/${MAPPED}.hmr > ${PROCESSED_DIR}/${MAPPED}.hmr.tmp
bedToBigBed ${PROCESSED_DIR}/${MAPPED}.hmr.tmp ${SIZES_DIR} ${TRACK_DIR}/${MAPPED}.hmr.bb && rm ${PROCESSED_DIR}/${MAPPED}.hmr.tmp
