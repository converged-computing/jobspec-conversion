#!/bin/bash
#FLUX: --job-name=loopy-avocado-1644
#FLUX: -n=6
#FLUX: --queue=lrgmem
#FLUX: -t=180000
#FLUX: --urgency=16

cd /home-4/yhe23@jhu.edu/work/yuan/tools/STAR-2.7.1a/bin/Linux_x86_64_static
genome_index_idr=/work-zfs/abattle4/heyuan/tissue_spec_eQTL_v8/datasets/STAR/genome_index
vcfFn=/work-zfs/abattle4/heyuan/tissue_spec_eQTL_v8/datasets/STAR/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.SHAPEIT2_phased.MAF01_nochromsome.vcf
fastq_dir=/work-zfs/abattle4/heyuan/tissue_spec_eQTL_v8/datasets/HM_ChIP_seq/fastq/
outputdir=/work-zfs/abattle4/heyuan/tissue_spec_eQTL_v8/datasets/HM_ChIP_seq/STAR_output
fn_rep1=${fastq_dir}/ENCFF782HDW.fastq
fn_rep2=${fastq_dir}/ENCFF536ZDD.fastq
outputfn=${outputdir}/liver_H3K4me3_seq
./STAR --genomeDir ${genome_index_idr}  --runThreadN 6 --readFilesIn ${fn_rep1},${fn_rep2} --readFilesCommand zcat  --outFileNamePrefix ${outputfn} --varVCFfile ${vcfFn} --outSAMattributes NH HI AS nM NM MD vA vG vW --outSAMtype BAM SortedByCoordinate --waspOutputMode SAMtag
