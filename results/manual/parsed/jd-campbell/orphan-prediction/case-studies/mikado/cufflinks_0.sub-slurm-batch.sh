#!/bin/bash
#SBATCH --job-name=cufflinks_0
#SBATCH --output=cufflinks_0.o%j
#SBATCH --error=cufflinks_0.e%j
#SBATCH --mail-user=arnstrm@gmail.com
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=4-00:00:00
#SBATCH --constraint=ntasks-per-node=16

cd $SLURM_SUBMIT_DIR
ulimit -s unlimited
module use /work/GIF/software/modules
module use /work/GIF/software/modules
module use /opt/rit/spack-modules/lmod/linux-rhel7-x86_64/Core
module use /opt/rit/spack-modules/lmod/linux-rhel7-x86_64/gcc
module load samtools
module load cufflinks
cufflinks -o merged_better_and_best -p 16 --multi-read-correct --frag-bias-correct TAIR10_chr_all.fas merged_better_and_best.bam
scontrol show job $SLURM_JOB_ID
