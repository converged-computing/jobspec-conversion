#!/bin/bash
#FLUX: --job-name=SVIM
#FLUX: -c=20
#FLUX: --priority=16

source ~/.bashrc
ref="/dfs7/jje/jenyuw/Eval-sv-temp/reference"
ref_genome="${ref}/r649.rename.fasta" ##REMEMBER it is renamed
trimmed="/dfs7/jje/jenyuw/Eval-sv-temp/results/trimmed"
aligned_bam="/dfs7/jje/jenyuw/Eval-sv-temp/results/alignment"
SVs="/dfs7/jje/jenyuw/Eval-sv-temp/results/SVs"
nT=$SLURM_CPUS_PER_TASK
file=`head -n $SLURM_ARRAY_TASK_ID ${trimmed}/namelist_2.txt |tail -n 1`
name=`echo ${file} | cut -d '/' -f 8 |cut -d '.' -f 1 `
read_type=`echo ${name} | cut -d '_' -f 1 `
file="${aligned_bam}/${name}.trimmed-ref.sort.bam"
module load python/3.10.2
svim alignment --sample ${name}_svim \
--min_mapq 20 --min_sv_size 50 \
--max_sv_size 10000000 \
--position_distance_normalizer 900 --cluster_max_distance 0.3 \
${SVs}/${name}_SVIM ${file} ${ref_genome}
cp ${SVs}/${name}_SVIM/variants.vcf ${SVs}/${name}.SVIM.vcf
module unload python/3.10.2
echo "This is the end"
