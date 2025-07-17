#!/bin/bash
#FLUX: --job-name=comb-gvcfs
#FLUX: --queue=mem
#FLUX: -t=129600
#FLUX: --urgency=16

set -e
  ##SBATCH --ntasks=22  #Number of overall tasks - overrides tasks per node
in_dir="/project/genolabswheatphg/gvcfs/SRW_single_samp_bw2_excap_GBS_mq20"
ref_gen="/project/genolabswheatphg/v1_refseq/whole_chroms/Triticum_aestivum.IWGSC.dna.toplevel.fa"
out_gvcf="/project/genolabswheatphg/gvcfs/SRW_multisamp_bw2_excap_GBS/SRW_multisamp_bw2_excap_GBS.g.vcf.gz"
ncores=22
module load parallel
module load samtools
module load bcftools
module load miniconda
source activate gatk4
echo
echo "Start time:"
date
out_dir=$(dirname "${out_gvcf}")
mkdir -p "${out_dir}"
cd "${out_dir}"
mkdir -p chrom_gvcfs
printf '%s\n' "${in_dir}"/*.g.vcf.gz > in_gvcfs.list
if [[ ! -f "${ref_gen}".fai ]]; then samtools faidx "${ref_gen}"; fi
cut -f 1 "${ref_gen}".fai > chrom_list.txt
cat chrom_list.txt | 
    parallel --compress --jobs $ncores "gatk \
        --java-options '-Xmx10g' CombineGVCFs \
        --reference ${ref_gen} \
        --variant in_gvcfs.list \
        --intervals {} \
        --output chrom_gvcfs/chrom_{}.g.vcf.gz"
printf '%s\n' chrom_gvcfs/*.g.vcf.gz > chr_gvcfs.list
gatk --java-options "-Xmx10g" GatherVcfs --INPUT chr_gvcfs.list --OUTPUT "${out_gvcf}"
bcftools index "${out_gvcf}"
source deactivate
echo
echo "End time:"
date
