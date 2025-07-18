#!/bin/bash
#FLUX: --job-name=t2
#FLUX: -n=4
#FLUX: --queue=all
#FLUX: --urgency=16

module load gnu9/9.4.0 
module load cudnn/8.3-10.2
echo "Starting my job..."
start_time=$(date +%s)
list_test=('smFISH_images/Eric_smFISH_images/20230306/DUSP1_0nM_Dex_0min_012623')
NUMBER_OF_CORES=4
path_to_config_file="$HOME/FISH_Processing/config.yml"
path_to_executable="${PWD%/*}/src/pipeline_executable.py" 
diameter_nucleus=100                 # Approximate nucleus size in pixels
diameter_cytosol=200                 # Approximate cytosol size in pixels
psf_z=350                            # Theoretical size of the PSF emitted by a [rna] spot in the z plan, in nanometers.
psf_yx=160                           # Theoretical size of the PSF emitted by a [rna] spot in the yx plan, in nanometers.
voxel_size_z=500                     # Microscope conversion px to nanometers in the z axis.
voxel_size_yx=160                    # Microscope conversion px to nanometers in the xy axis.
channels_with_nucleus='[2]'                  # Channel to pass to python for nucleus segmentation
channels_with_cytosol='[1]'                 # Channel to pass to python for cytosol segmentation
channels_with_FISH='[0]'                   # Channel to pass to python for spot detection
send_data_to_NAS=0                   # If data sent back to NAS use 1.
download_data_from_NAS=1             # Download data from NAS
path_to_masks_dir='None'             # 'Test/test_dir/masks_test_dir___nuc_120__cyto_220.zip'
save_all_images=0                    # If true, it shows a all planes for the FISH plot detection.
threshold_for_spot_detection='None'  # Thresholds for spot detection. Use an integer for a defined value, or 'None' for automatic detection.
save_filtered_images=0               #         
optimization_segmentation_method='default' # optimization_segmentation_method = 'default' 'intensity_segmentation' 'z_slice_segmentation_marker', 'gaussian_filter_segmentation' , None
remove_z_slices_borders=1       # Use this flag to remove 2 z-slices from the top and bottom of the stack. This is needed to remove z-slices that are out of focus.
remove_out_of_focus_images=1         # Flag to remove out of focus images
save_pdf_report=0
convert_to_standard_format=0
number_color_channels=0
number_of_fov=0
for folder in ${list_test[*]}; do
     output_names=""output__"${folder////__}"".txt"
     ~/.conda/envs/FISH_processing/bin/python "$path_to_executable" "$folder" $send_data_to_NAS $diameter_nucleus $diameter_cytosol $voxel_size_z $voxel_size_yx $psf_z $psf_yx "$channels_with_nucleus" "$channels_with_cytosol" "$channels_with_FISH" "$output_names" "$path_to_config_file" $download_data_from_NAS $path_to_masks_dir $optimization_segmentation_method $save_all_images $threshold_for_spot_detection $NUMBER_OF_CORES $save_filtered_images $remove_z_slices_borders $remove_out_of_focus_images $save_pdf_report $convert_to_standard_format $number_color_channels $number_of_fov >> "$output_names" &
     wait
done
end_time=$(date +%s)
total_time=$(( (end_time - start_time) / 60 ))
echo "Total time to complete the job: $total_time minutes"
exit 0
