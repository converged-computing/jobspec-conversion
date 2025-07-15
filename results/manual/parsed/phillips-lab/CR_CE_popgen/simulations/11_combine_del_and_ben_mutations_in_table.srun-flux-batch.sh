#!/bin/bash
#FLUX: --job-name=Rstats
#FLUX: --queue=phillips
#FLUX: -t=18000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load R
scriptB="table_script_BEN.R"
dir="/projects/phillipslab/ateterina/slim/worms_snakemake"
mkdir -p $dir/BEN
cd $dir/BEN
cp $dir/sim30rep/d*/*Mut_1_Fr*.ALLMUT.txt $dir/BEN
cp $dir/sim70rep/d*/*Mut_1_Fr*.ALLMUT.txt $dir/BEN
cp $dir/simmut15/d*/*Mut_1_Fr*.ALLMUT.txt $dir/BEN
cp $dir/balancing/d*/*Mut_1_Fr*.ALLMUT.txt $dir/BEN
cd $dir/BEN
Rscript --vanilla $dir/$scriptB SLIM_SEL_BENEFICIAL_PART.out
