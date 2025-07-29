#!/bin/bash
#SBATCH --job-name=ATACseq
#SBATCH --output=job.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4Gb
#SBATCH --qos=normal

export PATH=':$PATH:/storage/zhangyanxiaoLab/share/bin'

module load picard
module load R
module load bowtie
module load samtools
unset PYTHONPATH
source /storage/zhangyanxiaoLab/share/Pipelines/environments/python3env/bin/activate
export PATH=:$PATH:/storage/zhangyanxiaoLab/share/bin
{exec_job}
