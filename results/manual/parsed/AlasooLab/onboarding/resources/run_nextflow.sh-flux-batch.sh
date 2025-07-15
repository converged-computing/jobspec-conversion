#!/bin/bash
#FLUX: --job-name="genimpute"
#FLUX: --queue=amd
#FLUX: -t=86400
#FLUX: --priority=16

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
