#!/bin/bash
#FLUX: --job-name=ldhat
#FLUX: -n=2
#FLUX: --queue=quanah
#FLUX: -t=172800
#FLUX: --urgency=16

module load intel R
source activate bcftools
chrom_array=$( head -n${SLURM_ARRAY_TASK_ID} ldhat_helper.txt | tail -n1 | cut -f2 )
start_array=$( head -n${SLURM_ARRAY_TASK_ID} ldhat_helper.txt | tail -n1 | cut -f3 )
end_array=$( head -n${SLURM_ARRAY_TASK_ID} ldhat_helper.txt | tail -n1 | cut -f4 )
workdir=/lustre/scratch/jmanthey/15_contopus/08_ldhat
output=eastern
cat ${output}_header.txt > ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.recode.vcf
tabix ${workdir}/${output}_ldhat.vcf.gz ${chrom_array}:${start_array}-${end_array} >> ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.recode.vcf
bcftools query -f '%POS\t%REF\t%ALT[\t%GT]\n' ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.recode.vcf > ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.simple.vcf
Rscript make_ldhat_files.r ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.simple.vcf
$ run ldhat interval
/lustre/work/jmanthey/LDhat-master/interval -seq ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.sites \
-loc ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.locs \
-lk ${workdir}/${output}_lk.txt -bpen 10 -its 3000000 -samp 3000 -prefix ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.
/lustre/work/jmanthey/LDhat-master/stat -input ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.rates.txt \
-burn 301 -prefix ${workdir}/windows/${output}__${chrom_array}__${start_array}__${end_array}.
mv ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.mapping ${workdir}/windows/${output}__${chrom_array}__${start_array}__${end_array}.mapping
rm ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.locs
rm ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.recode.vcf
rm ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.simple.vcf
rm ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.sites
rm ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.bounds.txt
rm ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.new_lk.txt
rm ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.type_table.txt
rm ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.rates.txt
output=western
cat ${output}_header.txt > ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.recode.vcf
tabix ${workdir}/${output}_ldhat.vcf.gz ${chrom_array}:${start_array}-${end_array} >> ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.recode.vcf
bcftools query -f '%POS\t%REF\t%ALT[\t%GT]\n' ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.recode.vcf > ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.simple.vcf
Rscript make_ldhat_files.r ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.simple.vcf
$ run ldhat interval
/lustre/work/jmanthey/LDhat-master/interval -seq ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.sites \
-loc ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.locs \
-lk ${workdir}/${output}_lk.txt -bpen 10 -its 3000000 -samp 3000 -prefix ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.
/lustre/work/jmanthey/LDhat-master/stat -input ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.rates.txt \
-burn 301 -prefix ${workdir}/windows/${output}__${chrom_array}__${start_array}__${end_array}.
mv ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.mapping ${workdir}/windows/${output}__${chrom_array}__${start_array}__${end_array}.mapping
rm ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.locs
rm ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.recode.vcf
rm ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.simple.vcf
rm ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.sites
rm ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.bounds.txt
rm ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.new_lk.txt
rm ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.type_table.txt
rm ${workdir}/windows/${chrom_array}__${start_array}__${end_array}.rates.txt
