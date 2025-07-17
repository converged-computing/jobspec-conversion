#!/bin/bash
#FLUX: --job-name=prep_ref
#FLUX: -t=43200
#FLUX: --urgency=16

                                                                    														# or ALL (equivalent to BEGIN, END, FAIL, INVALID_DEPEND, REQUEUE, and STAGE_OUT), 
                                                                    														# Multiple type values may be specified in a comma separated list. 
echo ""
echo "                   Create, Split, and Merge Reference VCFs - HPC version"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "..... > loading required conda environment containing the gwaslab and associated packages installation..."
eval "$(conda shell.bash hook)"
conda activate gwas
REF_loc="/hpc/dhl_ec/data/references"
REF1Kgp3v5_loc="${REF_loc}/1000G/Phase3"
VCF_loc="${REF1Kgp3v5_loc}/VCF_format"
echo "References:     ${REF_loc}"
echo "1000G, phase 3: ${REF1Kgp3v5_loc}"
echo "VCF-files:      ${VCF_loc}"
echo "Extracting sample list per population."
awk '{print $1}' "${REF1Kgp3v5_loc}"/integrated_call_samples_v3.20130502.ALL.panel | tail -n +2 > "${REF1Kgp3v5_loc}"/integrated_call_samples_v3.20130502.ALL.sample
for pop in ALL; do # AFR AMR SAS EAS EUR were already processed
echo "Processing data for ${pop}."
	# merge
	echo "> merging and sorting all data."
	bcftools concat -a -d both -f "${VCF_loc}"/"${pop}".concat_list.txt -Ob | bcftools sort -Oz  > "${VCF_loc}"/"${pop}".ALL.split_norm_af.1kgp3v5.hg19.vcf.gz
	tabix -p vcf "${VCF_loc}"/"${pop}".ALL.split_norm_af.1kgp3v5.hg19.vcf.gz
done
