#!/bin/bash
#SBATCH --output=submit_phispy/submit_phispy-%j.out
#SBATCH --error=submit_phispy/submit_phispy-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --time=5-00:00:00

DATE=20220606
ASS=$DATE/assembly_summary_$DATE.txt.gz
VOGS=/home/edwa0468/VOGs/vog99/VOGs.hmm
NEED=0000$SLURM_ARRAY_TASK_ID
NEED=${NEED:(-4)}
snakemake -s ~/GitHubs/PhispyAnalysis/RunningPhiSpy/phispy_vogs_download.snakefile --config filelist=$DATE/needed/x$NEED gbk=$DATE/gbk output=$DATE/phispy assembly=$ASS vogs=$VOGS --profile slurm_small
