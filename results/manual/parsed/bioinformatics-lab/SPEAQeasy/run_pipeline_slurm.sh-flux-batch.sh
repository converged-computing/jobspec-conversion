#!/bin/bash
#FLUX: --job-name=pusheena-avocado-6165
#FLUX: --priority=16

export _JAVA_OPTIONS='-Xms8g -Xmx10g'

ORIG_DIR=$PWD
export _JAVA_OPTIONS="-Xms8g -Xmx10g"
$ORIG_DIR/Software/nextflow main.nf \
    --sample "single" \
    --reference "hg19" \
    --strand "unstranded" \
    --small_test \
    --annotation "$ORIG_DIR/Annotation" \
    -with-report execution_reports/pipeline_report.html \
    -profile slurm
echo "Generating per-sample logs for debugging..."
bash $ORIG_DIR/scripts/generate_logs.sh $PWD/SPEAQeasy_output.log
