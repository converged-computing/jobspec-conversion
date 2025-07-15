#!/bin/bash
#FLUX: --job-name=picard
#FLUX: --urgency=16

module load picard/2.18.27
bam_dir=$1
for f in $bam_dir/*.sort.bam; do
	java -Xms20g -Xmx90g -jar /usr/local/easybuild/software/picard/2.18.27/picard.jar MarkDuplicates \
	INPUT=$f \
	OUTPUT=${f%.*}.markdup.bam \
	METRICS_FILE=${f%.*}.markdup.metrics \
	AS=TRUE VALIDATION_STRINGENCY=LENIENT MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=8000 REMOVE_DUPLICATES=TRUE
	rm $f
done
