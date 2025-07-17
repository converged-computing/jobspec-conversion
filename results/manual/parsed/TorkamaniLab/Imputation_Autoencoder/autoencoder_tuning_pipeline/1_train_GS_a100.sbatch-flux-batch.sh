#!/bin/bash
#FLUX: --job-name=1_train_GS
#FLUX: --exclusive
#FLUX: --queue=stsi
#FLUX: -t=2160000
#FLUX: --urgency=16

module purge
module load samtools/1.10
module load R
module load pytorch/1.8.0py38-cuda
echo -e "Work dir is $SLURM_SUBMIT_DIR"
echo -e "VMV is $indir, GPU a100 $ngpus GPUs"
cd $SLURM_SUBMIT_DIR
subdir=$(basename $indir)
new_indir=/tmp/$subdir
if [ -d /tmp/$subdir ]; then
    rm -rf /tmp/$subdir
fi
rsync -rtv $indir/* $new_indir/ 
bash 1_train_GS.sh $new_indir A100
rsync -rtv $new_indir/* $indir/
rm -rf $new_indir
nmodels=$(ls -l $indir/IMPUTATOR_*/*.pth | grep -v "_F.pth" | wc -l)
if [ $nmodels -lt 90 ]; then
    "Error, less than 90 models ran successfully, please check errors and rerun this job. Exiting with non-zero status."
    exit 1
else
    echo "$nmodels models completed successfully. Job done."
    exit 0
fi
