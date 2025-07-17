#!/bin/bash
#FLUX: --job-name=train_deeplab
#FLUX: --queue=4gpu
#FLUX: --urgency=16

export TMPDIR='${JOBTMP}  # scratch-directory for the job '
export WKHTMLTOPDF_PATH='/isi/w/lb27/softwares/wkhtmltopdf/usr/local/bin/wkhtmltopdf'

cd ..
jobFile=train_unet_target
JOBNAME=DL_${jobFile}_${SLURM_JOBID}
USERNAME=kari
JOBTMP=/scratch/${USERNAME}_${SLURM_JOB_ID}
export TMPDIR=${JOBTMP}  # scratch-directory for the job 
__conda_setup="$('/isi/w/lb27/softwares/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/isi/w/lb27/softwares/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/isi/w/lb27/softwares/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/isi/w/lb27/softwares/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
export WKHTMLTOPDF_PATH=/isi/w/lb27/softwares/wkhtmltopdf/usr/local/bin/wkhtmltopdf
conda activate detectron
python ${jobFile}.py --exp-name unet_vanilla_uds_resnet50_noleak \
--gpu-id 0 \
--encoder resnet50 \
--model-arch Unet \
--batch-size 12 \
--num-iterations 100000 \
--val-every-it 200 \
--data-dir-image /isi/w/lb27/data/PAG_segmentation/processed/semantic_segmentation/real_data/nital_pag_no_overlap_comb/images \
--data-dir-label /isi/w/lb27/data/PAG_segmentation/processed/semantic_segmentation/real_data/nital_pag_no_overlap_comb/masks \
--data-list-train /isi/w/lb27/data/PAG_segmentation/processed/semantic_segmentation/real_data/nital_pag_no_overlap_comb/train_list.txt \
--data-list-validation /isi/w/lb27/data/PAG_segmentation/processed/semantic_segmentation/real_data/nital_pag_no_overlap_comb/val_list.txt \
sleep 5
    while [ -f ${JOBNAME}.lck ]; do
       sleep 5
    done
