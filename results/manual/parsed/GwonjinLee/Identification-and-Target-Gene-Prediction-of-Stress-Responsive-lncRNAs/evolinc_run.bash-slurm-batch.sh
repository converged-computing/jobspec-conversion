#!/bin/bash
#SBATCH --job-name=evolinc
#SBATCH --account=meixiazhao
#SBATCH --output=/blue/meixiazhao/lee.gwonjin/Soybean_project/scripts/outtext/evolinc_TE.out
#SBATCH --error=/blue/meixiazhao/lee.gwonjin/Soybean_project/scripts/outtext/evolinc_TE.err
#SBATCH --mail-user=lee.gwonjin@ufl.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=24G
#SBATCH --time=7-00:00:00

cd /blue/meixiazhao/lee.gwonjin/Soybean_project/lncRNA/evolinc
module load singularity
rm evolinc-i_1.7.5.sif
singularity pull docker://evolinc/evolinc-i:1.7.5
singularity run docker://evolinc/evolinc-i:1.7.5 \
-c /blue/meixiazhao/lee.gwonjin/Soybean_project/lncRNA/mapping/assembly/merged_asm_ref/Transctipts64Assembly.gtf \
-g /blue/meixiazhao/lee.gwonjin/Soybean_project/reference/genome/PhytozomeV13/Gmax/Wm82.a4.v1/assembly/Gmax_508_v4.0.fa \
-u /blue/meixiazhao/lee.gwonjin/Soybean_project/reference/genome/PhytozomeV13/Gmax/Wm82.a4.v1/annotation/Gmax_508_Wm82.a4.v1.gene.gff3 \
-b /blue/meixiazhao/lee.gwonjin/Soybean_project/reference/genome/PhytozomeV13/Gmax/TE/TE_seqforEvolinc/TE_sequences.fa \
-o evolinc_out \
-n 4
