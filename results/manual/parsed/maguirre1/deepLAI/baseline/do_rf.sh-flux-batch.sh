#!/bin/bash
#FLUX: --job-name=rfmix
#FLUX: --queue=normal,owners
#FLUX: -t=172800
#FLUX: --urgency=16

if [ "$#" -lt 1 ]; then 
	echo "usage: bash do_rf.sh input.vcf [out_prefix]"
	exit 1
else
	in_vcf=$1
fi
autout=$(basename $in_vcf | awk '{gsub(".vcf",""); gsub(".gz",""); print}')
if [ "$#" -gt 1 ]; then 
	output=$2
else 
	mkdir -p "$(dirname $in_vcf)/rf_out"
	output="$(dirname $in_vcf)/rf_out/${autout}"
fi
if [ $(hostname) = "galangal.stanford.edu" ]; then 
	traing="/home/magu/deepmix/data/reference_panel/vcf/panel_chr20.no-OCE-WAS.vcf.gz"
else
	traing="/scratch/users/magu/deepmix/data/vcf/panel_chr20.no-OCE-WAS.vcf.gz"
	if ! command -v rfmix &> /dev/null; then 
		export PATH="${PATH}:/home/users/magu/miniconda3/envs/popgen/bin/"
	fi
fi
labels="../data/reference-panel/split/train.superpop.rfmix.txt"
ref_ld="../data/admixture-sim/hapmap-phase2-genetic-map.tsv.gz"
which rfmix
echo """
input: $in_vcf
train set: $traing
train labels: $labels
reference panel: $ref_ld
out: $output
running:
rfmix -f $in_vcf -r $traing -m $labels -g $ref_ld -o $output 
"""
rfmix -f $in_vcf -r $traing -m $labels -g <(zcat $ref_ld | awk '$1==20') \
      -o $output --n-threads=12 --chromosome=20
