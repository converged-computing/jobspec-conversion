#!/bin/bash
#FLUX: --job-name=SPEAQeasy
#FLUX: --urgency=16

export NXF_JVM_ARGS='-Xms8g -Xmx10g'

ORIG_DIR=$PWD
module load nextflow/23.10.0
export NXF_JVM_ARGS="-Xms8g -Xmx10g"
nextflow run $ORIG_DIR/main.nf \
    --sample "paired" \
    --reference "hg38" \
    --strand "forward" \
    --small_test \
    --annotation "/dcs04/lieber/lcolladotor/annotationFiles_LIBD001/SPEAQeasy/Annotation" \
    -with-report execution_reports/JHPCE_run.html \
    -profile jhpce
bash $ORIG_DIR/scripts/track_runs.sh $PWD/SPEAQeasy_output.log
echo "Generating per-sample logs for debugging..."
bash $ORIG_DIR/scripts/generate_logs.sh $PWD/SPEAQeasy_output.log
