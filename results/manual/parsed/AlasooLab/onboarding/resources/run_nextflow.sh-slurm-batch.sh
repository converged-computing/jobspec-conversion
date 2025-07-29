#!/bin/bash
#SBATCH --job-name=genimpute
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5G
#SBATCH --time=1-00:00:00
#SBATCH --partition=amd
#SBATCH --constraint=ntasks-per-node=1

module load any/jdk/1.8.0_265
module load nextflow
module load any/singularity/3.5.3
module load squashfs/4.4
nextflow run main.nf -profile tartu_hpc\
   --studyFile testdata/multi_test.tsv\
    --vcf_has_R2_field FALSE\
    --run_nominal\
    --run_permutation\
    --run_susie\
    --varid_rsid_map_file testdata/varid_rsid_map.tsv.gz\
    --n_batches 25
