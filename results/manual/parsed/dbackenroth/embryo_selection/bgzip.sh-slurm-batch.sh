#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6g
#SBATCH --time=02:20:00

parentdir=/vol/sci/bio/data/shai.carmi/db2175/embryo_selection/
dir=${parentdir}/LIJMC
for i in {1..22}
do
  bgzip ${dir}/LIJMC37_phased_${i}.vcf
  tabix ${dir}/LIJMC37_phased_${i}.vcf.gz
done
