#!/bin/bash
#FLUX: --job-name=salted-cinnamonbun-0506
#FLUX: -c=16
#FLUX: --queue=gpu
#FLUX: -t=1800
#FLUX: --urgency=16

export nnUNet_raw='/projects/0/nwo2021061/uls23/nnUNet_raw'
export nnUNet_results='/home/ljulius/algorithm/nnunet/nnUNet_results'
export dataset_id='501'

DATASET_ID=501
now=$(date)
echo "Hello, this is a ULS job running inference on more datasets."
echo "The starting time is $now"
timestr=$(date +"%Y-%m-%d_%H-%M-%S")
source "/home/ljulius/miniconda3/etc/profile.d/conda.sh"
source /home/${USER}/.bashrc
conda activate uls
export nnUNet_raw="/projects/0/nwo2021061/uls23/nnUNet_raw"
export nnUNet_results="/home/ljulius/algorithm/nnunet/nnUNet_results"
export dataset_id=500
nnUNetv2_predict -f all -i /projects/0/nwo2021061/uls23/nnUNet_raw/Dataset500_DeepLesion3D/imagesTs -o /home/ljulius/data/output/baseline/Dataset500_DeepLesion3D -d 400 -c nnUNetTrainer_ULS_500_QuarterLR__nnUNetPlansNoRs__3d_fullres_resenc
export dataset_id=502
nnUNetv2_predict -f all -i /projects/0/nwo2021061/uls23/nnUNet_raw/Dataset502_RadboudumcPancreas/imagesTs -o /home/ljulius/data/output/baseline/Dataset502_RadboudumcPancreas -d 400 -c nnUNetTrainer_ULS_500_QuarterLR__nnUNetPlansNoRs__3d_fullres_resenc
export dataset_id=503
nnUNetv2_predict -f all -i /projects/0/nwo2021061/uls23/nnUNet_raw/Dataset503_kits21/imagesTs -o /home/ljulius/data/output/baseline/Dataset503_kits21 -d 400 -c nnUNetTrainer_ULS_500_QuarterLR__nnUNetPlansNoRs__3d_fullres_resenc
export dataset_id=504
nnUNetv2_predict -f all -i /projects/0/nwo2021061/uls23/nnUNet_raw/Dataset504_LIDC-IDRI/imagesTs -o /home/ljulius/data/output/baseline/Dataset504_LIDC-IDRI -d 400 -c nnUNetTrainer_ULS_500_QuarterLR__nnUNetPlansNoRs__3d_fullres_resenc
export dataset_id=505
nnUNetv2_predict -f all -i /projects/0/nwo2021061/uls23/nnUNet_raw/Dataset505_LiTS/imagesTs -o /home/ljulius/data/output/baseline/Dataset505_LiTS -d 400 -c nnUNetTrainer_ULS_500_QuarterLR__nnUNetPlansNoRs__3d_fullres_resenc
export dataset_id=506
nnUNetv2_predict -f all -i /projects/0/nwo2021061/uls23/nnUNet_raw/Dataset506_MDSC_Task06_Lung/imagesTs -o /home/ljulius/data/output/baseline/Dataset506_MDSC_Task06_Lung -d 400 -c nnUNetTrainer_ULS_500_QuarterLR__nnUNetPlansNoRs__3d_fullres_resenc
export dataset_id=507
nnUNetv2_predict -f all -i /projects/0/nwo2021061/uls23/nnUNet_raw/Dataset507_MDSC_Task07_Pancreas/imagesTs -o /home/ljulius/data/output/baseline/Dataset507_MDSC_Task07_Pancreas -d 400 -c nnUNetTrainer_ULS_500_QuarterLR__nnUNetPlansNoRs__3d_fullres_resenc
export dataset_id=508
nnUNetv2_predict -f all -i /projects/0/nwo2021061/uls23/nnUNet_raw/Dataset508_MDSC_Task10_Colon/imagesTs -o /home/ljulius/data/output/baseline/Dataset508_MDSC_Task10_Colon -d 400 -c nnUNetTrainer_ULS_500_QuarterLR__nnUNetPlansNoRs__3d_fullres_resenc
export dataset_id=509
nnUNetv2_predict -f all -i /projects/0/nwo2021061/uls23/nnUNet_raw/Dataset509_NIH_LN_ABD/imagesTs -o /home/ljulius/data/output/baseline/Dataset509_NIH_LN_ABD -d 400 -c nnUNetTrainer_ULS_500_QuarterLR__nnUNetPlansNoRs__3d_fullres_resenc
export dataset_id=510
nnUNetv2_predict -f all -i /projects/0/nwo2021061/uls23/nnUNet_raw/Dataset510_NIH_LN_MED/imagesTs -o /home/ljulius/data/output/baseline/Dataset510_NIH_LN_MED -d 400 -c nnUNetTrainer_ULS_500_QuarterLR__nnUNetPlansNoRs__3d_fullres_resenc
export dataset_id=501
nnUNetv2_predict -f all -i /home/ljulius/Dataset501_RadboudumcBone/imagesTs -o /home/ljulius/data/output/baseline/Dataset501_RadboudumcBone -d 400 -c nnUNetTrainer_ULS_500_QuarterLR__nnUNetPlansNoRs__3d_fullres_resenc
now2=$(date)
echo "Done at $now"
