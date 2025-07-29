#!/bin/bash
#SBATCH --job-name=mbert_acl
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=96G
#SBATCH --time=00:11:55
#SBATCH --qos=normal

                      #   bigmem-LoPri, bigmem-HiPri, gpuq, CS_q, CDS_q, ...
source ~/fairseq/bin/activate
module load cuda/10.0
file=$1
name=$2
outdir=$3
mode=$4
cd ../GENRE
python geoloc_dg.py --mode ${mode} \
--name ${name} \
--data_file ${file} \
--out_dir ${outdir}
