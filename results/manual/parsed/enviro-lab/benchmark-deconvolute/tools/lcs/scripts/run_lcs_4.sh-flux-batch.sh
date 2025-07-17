#!/bin/bash
#FLUX: --job-name=butterscotch-mango-8722
#FLUX: --queue=Draco
#FLUX: -t=172800
#FLUX: --urgency=16

module purge &>/dev/null
module load anaconda3 &>/dev/null || source "$(dirname $(which conda))/../etc/profile.d/conda.sh" || (echo 'make sure you have conda installed'; exit 1)
set -eu
plate='05-05-23-V2'
lcs_sw_dir=software/LCS4
data_dir=${lcs_sw_dir}/data
config=${lcs_sw_dir}/rules/config.py
scheme=V4.1
scheme_file=software/primer_schemes/poreCovExternal/V4.1/poreCovExternal.scheme.bed
reference=software/sars-cov-2-reference.fasta
primer_fasta="${data_dir}/${scheme}_primers.fa"
fastq_dir=ont/MixedControl-${plate}-fastqs/output/porechop_kraken_trimmed
temp_outdir=${lcs_sw_dir}/outputs/decompose
outdir=tools/lcs/MixedControl_output/$plate
mkdir -p $outdir
( module load bedtools2
bedtools getfasta -name -fi $reference -bed $scheme_file | sed '/>/{n;s/^/^/}' > $primer_fasta )
current_line="$(grep PRIMERS_FA ${config})"
updated_line="PRIMERS_FA='data/${scheme}_primers.fa'"
sed -i "s,$current_line,$updated_line,g" $config
echo "Running LCS: $plate..."
echo "Creating links to files"
tools/lcs/scripts/link_samples.sh $fastq_dir $data_dir $plate
echo "Running lcs snakemake"
(
    conda activate conda/env-lcs
    cd ${lcs_sw_dir}
    snakemake --config markers=ucsc dataset=${plate}  --cores 16 --resources mem_gb=2000
)
mv ${temp_outdir}/* ${outdir}
tools/lcs/scripts/move_out_old_run.sh ${plate} ${lcs_sw_dir}
conda activate conda/env-plot
agg_dir=tools/lcs/agg
mkdir -p $agg_dir
tools/lcs/scripts/aggregate_predictions.py -f ${outdir}/${plate}.out -o ${agg_dir}/lcs-${plate}.tsv
