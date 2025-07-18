#!/bin/bash
#FLUX: --job-name=run_smoove
#FLUX: -n=2
#FLUX: --queue=serial_requeue
#FLUX: -t=60
#FLUX: --urgency=16

WELL=$(sed -n ${SLURM_ARRAY_TASK_ID}'{p;q}' ../../accessory_files/Wells.txt)
MYBAMS=""
for ((i=1;i<540;i++));
do
    SAMP=$(sed -n ${i}'{p;q}' ../../accessory_files/bam_map_combined_option.txt | awk '{print $1}')
    BAMPATH=$(sed -n ${i}'{p;q}' ../../accessory_files/bam_map_combined_option.txt | awk '{print $2}')
    if [[ $SAMP == *$WELL* ]]; then
        echo " ${BAMPATH}"
        MYBAMS+=" ../${BAMPATH}"
    fi
done
singularity exec ~/smoove_latest.sif smoove call --outdir ../../../Output/WGS/smoove_output/ --name ${WELL} --fasta ../../../Output/WGS/reference/w303_vlte.fasta -p 1 --genotype ${MYBAMS}
