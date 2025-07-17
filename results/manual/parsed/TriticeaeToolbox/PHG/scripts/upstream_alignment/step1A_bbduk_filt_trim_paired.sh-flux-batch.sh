#!/bin/bash
#FLUX: --job-name=bbduk-filt
#FLUX: -n=10
#FLUX: --queue=short
#FLUX: -t=18000
#FLUX: --urgency=16

module load bbtools/37.02
fastq_dir="/project/genolabswheatphg/raw_data/wheatCAP_parents"
adapt_fasta="/project/genolabswheatphg/Truseq_paired_adapters.fa"
samples="/project/genolabswheatphg/wheatCAP_samples.tsv"
out_dir="/project/genolabswheatphg/filt_fastqs/wheatCAP_parents"
ncores=10
date
mkdir "${out_dir}"
shopt -s globstar nullglob
fastqs=( "$fastq_dir"/**/*.fastq.gz )
samps=( $(cut -f1 "${samples}") )
ad_len=$(head -n 2 "${adapt_fasta}" | tail -n -1 | wc -c)
for i in "${samps[@]}"; do
    ## Now we have to go through the usual insane shell syntax to get all the unique
    ## lanes for sample i
    lanes=($(printf '%s\n' "${fastqs[@]}" | grep "$i" | sed 's/_R[12].*$//' | sort -u))
    #echo "***"    
    #printf '%s\n' "${lanes[@]}"
    ## Loop through each lane
    for j in "${lanes[@]}"; do
	base=$(basename "${j}")
	#echo "samp: ${i}"
        echo "lane: ${j}"
        ## Assign yet another new array, holding each of the two mated fastqs for lane i    
        mates=($(printf '%s\n' "${fastqs[@]}" | grep $j))    
        fq1="${mates[0]}"
        fq2="${mates[1]}"
        #echo "***"
        #echo $fq1
        #echo $fq2
        ## Run BBDuk
        ## Setting maq will remove entire reads based on their average qual
        ## maq=10 average error is 10%
        ## maq=13 ~5%
        ## maq=15 ~3%
        ## maq=20 1%
        bbduk.sh -Xmx10g t=$ncores \
                   in1="${fq1}" in2="${fq2}" out1="${out_dir}"/"${base}"_R1.fastq.gz out2="${out_dir}"/"${base}"_R2.fastq.gz \
                   ref="${adapt_fasta}" ktrim=r k=$ad_len mink=10 hdist=3 hdist2=1 ftm=5 maq=13 minlen=75 tpe tbo
    done
done
date
