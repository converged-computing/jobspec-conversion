#!/bin/bash
#FLUX: --job-name=hanky-carrot-6325
#FLUX: --queue=physical
#FLUX: -t=50400
#FLUX: --urgency=16

module load FSL/5.0.11-intel-2017.u2-GCC-6.2.0-CUDA9
module load MRtrix/20190207-GCC-6.2.0
module load Python/3.6.4-intel-2017.u2
source venv/bin/activate
scratch_path="/scratch/punim0695"
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
subject=$1
dataset=$2
streamlines=$3
workingdir=`pwd`
store_path="/data/gpfs/projects/punim0695/fMRI/DataStore/HCP_data/${dataset}/${subject}"
files=(
	# Diffusion files
	"T1w/T1w_acpc_dc_restore_1.25.nii.gz"
	"T1w/Diffusion/data.nii.gz"
	"T1w/Diffusion/bvals"
	"T1w/Diffusion/bvecs"
	"T1w/Diffusion/nodif_brain_mask.nii.gz"
	# Structural files
	"T1w/T1w_acpc_dc_restore.nii.gz"
	"T1w/T1w_acpc_dc_restore_brain.nii.gz"
	# MNI individual surfaces
	# "MNINonLinear/fsaverage_LR32k/${subject}.L.white.32k_fs_LR.surf.gii"
	# "MNINonLinear/fsaverage_LR32k/${subject}.R.white.32k_fs_LR.surf.gii"
	# native individual surfaces
	# "T1w/fsaverage_LR32k/${subject}.L.white.32k_fs_LR.surf.gii"
	# "T1w/fsaverage_LR32k/${subject}.R.white.32k_fs_LR.surf.gii"
	# Warp files
	"MNINonLinear/xfms/acpc_dc2standard.nii.gz"
	"MNINonLinear/xfms/standard2acpc_dc.nii.gz"
)
echo -e "${GREEN}[INFO]${NC} `date`: Checking if initial files are present"
for file in ${files[@]};
do
	if [ ! -f "${store_path}/${file}" ];
	then
		echo -e "${RED}[ERROR]${NC} File not found: ${store_path}/${file}"
		exit 1
	fi
done
echo -e "${GREEN}[INFO]${NC} `date`: File checks passed succesfuly"
tmp_path="/data/scratch/projects/punim0695/volumetric_tractography/${dataset}/${subject}"
out_path="/data/gpfs/projects/punim0695/fMRI/DataStore/tmp/volumetric_tractography/${dataset}/${subject}"
mkdir -p ${tmp_path}
mkdir -p ${out_path}
cd "${tmp_path}"
echo -e "${GREEN}[INFO]${NC} `date`: Converting images to .mif"
mrconvert "${store_path}/T1w/Diffusion/data.nii.gz" "${tmp_path}/dwi.mif" \
          -fslgrad "${store_path}/T1w/Diffusion/bvecs" "${store_path}/T1w/Diffusion/bvals" \
          -datatype float32 -strides 0,0,0,1
echo -e "${GREEN}[INFO]${NC} `date`: Running five tissue type segmentation"
mrconvert "${store_path}/T1w/T1w_acpc_dc_restore_brain.nii.gz" "${tmp_path}/T1.mif"
5ttgen fsl "${tmp_path}/T1.mif" "${tmp_path}/5tt.mif" -premasked
echo -e "${GREEN}[INFO]${NC} Generating mean bzero image"
dwiextract "${tmp_path}/dwi.mif" - -bzero | mrmath - mean "${tmp_path}/meanb0.mif" -axis 3
echo -e "${GREEN}[INFO]${NC} `date`: Estimation of response function using dhollander"
dwi2response dhollander "${tmp_path}/dwi.mif" \
                        "${tmp_path}/wm.txt" \
                        "${tmp_path}/gm.txt" \
                        "${tmp_path}/csf.txt" \
                        -voxels "${tmp_path}/voxels.mif"
echo -e "${GREEN}[INFO]${NC} `date`: Running Multi-Shell, Multi-Tissue Constrained Spherical Deconvolution"
maskfilter -npass 2 "${store_path}/T1w/Diffusion/nodif_brain_mask.nii.gz" dilate "${tmp_path}/nodif_brain_mask_dilated_2.nii.gz"
dwi2fod msmt_csd "${tmp_path}/dwi.mif" \
                 -mask "${tmp_path}/nodif_brain_mask_dilated_2.nii.gz" \
                 "${tmp_path}/wm.txt" "${tmp_path}/wmfod.mif" \
                 "${tmp_path}/gm.txt" "${tmp_path}/gmfod.mif" \
                 "${tmp_path}/csf.txt" "${tmp_path}/csffod.mif" \
maskfilter -npass 2 "${store_path}/T1w/Diffusion/nodif_brain_mask.nii.gz" erode "${tmp_path}/nodif_brain_mask_eroded_2.nii.gz"
mtnormalise "${tmp_path}/wmfod.mif" "${tmp_path}/wmfod_norm.mif" \
            "${tmp_path}/gmfod.mif" "${tmp_path}/gmfod_norm.mif" \
            "${tmp_path}/csffod.mif" "${tmp_path}/csffod_norm.mif" \
            -mask "${tmp_path}/nodif_brain_mask_eroded_2.nii.gz"
echo -e "${GREEN}[INFO]${NC} `date`: Creating gray matter white matter interface mask"
5tt2gmwmi "${tmp_path}/5tt.mif" "${tmp_path}/gmwmiSeed.mif"
echo -e "${GREEN}[INFO]${NC} `date`: Creating streamlines"
tckgen -seed_gmwmi "${tmp_path}/gmwmiSeed.mif" \
	-act "${tmp_path}/5tt.mif" \
       -select "${streamlines}" \
       -maxlength 250 \
       -cutoff 0.06 \
       "${tmp_path}/wmfod_norm.mif" \
       "${out_path}/volumetric_probabilistic_tracks_${streamlines}.tck"
       # -nthreads 6 \
tcksift2 "${out_path}/volumetric_probabilistic_tracks_${streamlines}.tck" \
	  "${tmp_path}/wmfod_norm.mif" \
	  "${out_path}/volumetric_probabilistic_sift_weights_${streamlines}.txt"
tckresample -endpoints "${out_path}/volumetric_probabilistic_tracks_${streamlines}.tck" \
 	     "${out_path}/volumetric_probabilistic_track_endpoints_${streamlines}.tck"
echo -e "${GREEN}[INFO]${NC} `date`: Removing unnecessary files."
rm -r "${tmp_path}/"
echo -e "${GREEN}[INFO]${NC} `date`: Script finished!"
deactivate
