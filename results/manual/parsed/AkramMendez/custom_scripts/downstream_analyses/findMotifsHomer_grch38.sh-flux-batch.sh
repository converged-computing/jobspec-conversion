#!/bin/bash
#FLUX: --job-name=ornery-fork-9681
#FLUX: --urgency=16

module load bioinfo-tools
module load HOMER/4.11
inputdir=$(realpath $1)
outdir=$(realpath $2)
cd ${SNIC_TMP}
for i in $(find ${inputdir} -type f -iname "*.narrowPeak")
do
    echo "Copying file to ${SNIC_TMP}"
    cp ${i} .
done
for peaks_file in $(ls *.narrowPeak)
do
    name=$(echo "homerMotifs_${peaks_file%.narrowPeak}")
    echo "Finding motifs for ${peaks_file}"
    findMotifsGenome.pl ${peaks_file} hg38 ${outdir}/homerMotifs_${name} -size 75 -len 6 -basic -rna -p ${SLURM_NTASKS}
done
echo "Done."
