#!/bin/bash
#FLUX: --job-name=mood
#FLUX: --queue=bme.gpuresearch.q
#FLUX: -t=3600000
#FLUX: --priority=16

source /home/bme001/s144823/conda/etc/profile.d/conda.sh
conda activate mood
cd /home/bme001/shared/mood/code/ddpm-ood/post_processing
region="brain"
methods="select,mask,ssim,blur,mask"
phase="toy"
run="mood_ldm_07_25/nifti_vqvae/out/vqvae_10082023"
for select_recon in 0; do
for blur_sigma in 5 10 15; do
for mask_radius in 5 10; do
echo python analysis.py --run $run --phase $phase --combine_method $methods --mask_radius $mask_radius --blur_sigma $blur_sigma --select_recon $select_recon --save_predictions False
srun python analysis.py --run $run --phase $phase --combine_method $methods --mask_radius $mask_radius --blur_sigma $blur_sigma --select_recon $select_recon --save_predictions False
done
done
done
suffix="_transformed"
phase="val"
run="mood_ldm_07_25/nifti_vqvae/val/vqvae_10082023"
for select_recon in 0; do
for blur_sigma in 5 10 15; do
for mask_radius in 5 10; do
echo python analysis.py --run $run --phase $phase --suffix $suffix --combine_method $methods --mask_radius $mask_radius --blur_sigma $blur_sigma --select_recon $select_recon --save_predictions False
srun python analysis.py --run $run --phase $phase --suffix $suffix --combine_method $methods --mask_radius $mask_radius --blur_sigma $blur_sigma --select_recon $select_recon --save_predictions False
done
done
done
phase="val"
run="mood_ldm_07_25/nifti_vqvae/in/vqvae_10082023"
for select_recon in 0; do
for blur_sigma in 5 10 15; do
for mask_radius in 5 10; do
echo python analysis.py --run $run --phase $phase --suffix "" --combine_method $methods --mask_radius $mask_radius --blur_sigma $blur_sigma --select_recon $select_recon --save_predictions False
srun python analysis.py --run $run --phase $phase --suffix "" --combine_method $methods --mask_radius $mask_radius --blur_sigma $blur_sigma --select_recon $select_recon --save_predictions False
done
done
done
