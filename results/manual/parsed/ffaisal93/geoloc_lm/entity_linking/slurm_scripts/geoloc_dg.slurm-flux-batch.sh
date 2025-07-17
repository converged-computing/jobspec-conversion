#!/bin/bash
#FLUX: --job-name=mbert_acl
#FLUX: --queue=all-HiPri
#FLUX: -t=715
#FLUX: --urgency=16

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
