#!/bin/bash
#FLUX: --job-name=anxious-dog-8231
#FLUX: -c=8
#FLUX: --queue=defq
#FLUX: -t=86400
#FLUX: --urgency=16

export PATH='`pwd`/software/bin/:$PATH'

    ## load modules
module load Java/11.0.2; 
module load BCFtools/1.10.2-foss-2019b;
module load SAMtools/1.12-GCC-10.2.0; 
export PATH=`pwd`/software/bin/:$PATH
bamdir="bam_cnodups"
outdir="bam_cnodups_BAQ_nodups"
j="SRP149534"
mkdir vcf_${outdir}/
  ## check if mutserve is installed
if [ -f "software/bin/mutserve" ]; then 
  echo "mutserve already installed";
else
  echo "Mutserve is not installed, installing mutserve...";
  source install_software.sh;
fi
  ## Variant call
readarray -t rts < data/group_${j}_SRRs.txt;
if test -f "nuc/parent_consensus.fa"; then
  ref="nuc/parent_chrM_consensus.fa"
else
  ref="software/bin/rCRS.fasta"
fi
echo "Reference fasta file: ${ref}"
    ###############  Pileups  ##################
mkdir mpileups_${outdir}/
samtools faidx ${ref};
for rt in "${rts[@]}"
do
  echo ${rt};
  if [ -f "mpileups_${outdir}/${rt}_calls.vcf" ]; then
    echo "${rt} already called";
  else 
    echo "Creating mpileup for ${rt}...";
    samtools view ${bamdir}/${rt}.bam chrM -h -u -F DUP | bcftools mpileup - --max-depth 999999 --fasta-ref ${ref} -q 18 -Q 30 --annotate FORMAT/SP,FORMAT/AD,FORMAT/ADF,FORMAT/ADR --threads 8 -Ou | bcftools norm -f ${ref} -m -any -Ov --output mpileups_${outdir}/${rt}_mpileup.vcf 
    # separate final column with AD, ADF, ADR and SP info into separate columns: replace ";" separator with tabs (\t) 
    #sed "s/;/\t/g" -i mpileups_${bamdir}/${rt}_mpileup.vcf
    grep -v -P '\t<\*>' mpileups_${outdir}/${rt}_mpileup.vcf > mpileups_${outdir}/${rt}_mpileup_nodels.vcf
    # replace "-" in #headers row with tab separated names of columns
    #sed "s/INFO    FORMAT  -/INFO    FORMAT  AD	ADF	ADR	SP/g" -i mpileups_${bamdir}/${rt}_mpileup.vcf
    #echo "Calling point mutations (bcftools call) for ${rt}...";
    #bgzip -i -c mpileups_${bamdir}/${rt}_mpileup.vcf --threads 8 | 
    #bcftools call mpileups_${bamdir}/${rt}_mpileup.vcf --multiallelic-caller --keep-alts --skip-variants indels --regions chrM -Ov --ploidy 1 --output bcf_calls_${bamdir}/${rt}_calls.vcf;
  fi
done
module purge;
