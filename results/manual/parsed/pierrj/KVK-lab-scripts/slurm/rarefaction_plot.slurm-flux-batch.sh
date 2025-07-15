#!/bin/bash
#FLUX: --job-name=rarefaction_plot
#FLUX: --queue=savio2
#FLUX: -t=259200
#FLUX: --priority=16

cd /global/scratch/users/pierrj/eccDNA/magnaporthe_pureculture/rawdata/illumina/pureculture_samples/G3_1A/
cd rarefaction_plot
for i in $(seq 0.1 0.1 1.0); do
    # mkdir $i
    cd $i
    sample=G3_1A_${i}
    # samtools view -bh -s ${i} /global/scratch/users/pierrj/eccDNA/magnaporthe_pureculture/rawdata/illumina/pureculture_samples/G3_1A/only_mappedreads.mergedandpe.G3_1A_bwamem.bam > mergedandpe.${sample}_bwamem.bam
    # /global/home/users/pierrj/git/bash/ecc_callerv2_upstream.sh ${sample}
    # ipcluster start -n $SLURM_NTASKS --cluster-id="slurm-${SLURM_JOBID}" &
    # sleep 45
    # ipython /global/home/users/pierrj/git/python/ecc_callerv2.py samechromosome.exactlytwice.all.mergedandpe.${sample}_bwamem.bam outwardfacing.mergedandpe.${sample}_bwamem.bed genomecoverage.mergedandpe.${sample}_bwamem.bed ${sample} 56
    # ipcluster stop --cluster-id="slurm-${SLURM_JOBID}"
    awk '{ if ($6 == "hconf") print $0}' ecccaller_output.${sample}.details.tsv | wc -l >> /global/scratch/users/pierrj/eccDNA/magnaporthe_pureculture/rawdata/illumina/pureculture_samples/G3_1A/rarefaction_plot/rarefaction_plot_hconf
    wc -l ecccaller_output.${sample}.details.tsv >> /global/scratch/users/pierrj/eccDNA/magnaporthe_pureculture/rawdata/illumina/pureculture_samples/G3_1A/rarefaction_plot/rarefaction_plot
    cd ..
done
