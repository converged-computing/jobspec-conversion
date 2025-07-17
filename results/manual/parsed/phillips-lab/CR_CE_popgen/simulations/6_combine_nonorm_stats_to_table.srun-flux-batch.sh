#!/bin/bash
#FLUX: --job-name=Rstats
#FLUX: --queue=phillips
#FLUX: -t=18000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load R
script="/projects/phillipslab/ateterina/slim/worms_snakemake/table_script.R"
scriptB="/projects/phillipslab/ateterina/slim/worms_snakemake/table_script_beta.R"
dir="/projects/phillipslab/ateterina/slim/worms_snakemake"
mkdir -p $dir/40kb_STATS
cd $dir/40kb_STATS/
mkdir -p SEL SEL_BETA
for simdir in sim30rep sim70rep simmut15 neutral_extra balancing;do
  cd $dir/$simdir
  mv d*/*12stats.txt $dir/40kb_STATS/SEL/
  mv d*/*40kb.BETA $dir/40kb_STATS/SEL_BETA/
done
find $dir/40kb_STATS/*/ -size 0 -delete
cd $dir/40kb_STATS/SEL/
Rscript --vanilla $script SLIM_SEL_TABLE_40.out
cd $dir/40kb_STATS/SEL_BETA/
Rscript --vanilla $scriptB SLIM_SEL_BETA_TABLE_40.out
mkdir -p $dir/100kb_STATS
cd $dir/100kb_STATS/
mkdir -p DECAY FLUCT EXP DECAY_BETA FLUCT_BETA EXP_BETA
cd $dir/100kb_STATS/DECAY
mv $dir/decay/d*/*12stats.txt .
mv $dir/decay_balancing/d*/*12stats.txt .
Rscript --vanilla $script SLIM_DECAY_TABLE.out
cd $dir/100kb_STATS/DECAY_BETA
mv $dir/decay/d*/*100kb.BETA .
mv $dir/decay_balancing/d*/*100kb.BETA .
Rscript --vanilla $scriptB SLIM_DECAY_BETA_TABLE.out
cd $dir/100kb_STATS/EXP
mv $dir/exponent/d*/*12stats.txt .
Rscript --vanilla $script SLIM_EXP_TABLE.out
cd $dir/100kb_STATS/EXP_BETA
mv $dir/exponent/d*/*100kb.BETA .
Rscript --vanilla $scriptB SLIM_EXP_BETA_TABLE.out
cd $dir/100kb_STATS/FLUCT
mv $dir/fluctuations/d*/*12stats.txt .
Rscript --vanilla $script SLIM_FLUCT_TABLE.out
cd $dir/100kb_STATS/FLUCT_BETA
mv $dir/fluctuations/d*/*100kb.BETA .
Rscript --vanilla $scriptB SLIM_FLUCT_BETA_TABLE.out
