#!/bin/bash
#SBATCH --account=mtnihrio
#SBATCH --output=run.sh.o.%j
#SBATCH --error=run.sh.e.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --partition=long

export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'

module load Python/2.7.13-intel-2017.03-GCC-6.3
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
source /mnt/nfs/home/ntv7/.DyNet/bin/activate
cd /mnt/nfs/home/ntv7/jNERE
python jNERE.py --dynet-mem 512 --epochs 100 --wembedding 100 --cembedding 25 --nembedding 100 --lr 0.0005 --lstmdims 100 --prevectors ../glove.6B.100d.txt --output outputs/exp_
