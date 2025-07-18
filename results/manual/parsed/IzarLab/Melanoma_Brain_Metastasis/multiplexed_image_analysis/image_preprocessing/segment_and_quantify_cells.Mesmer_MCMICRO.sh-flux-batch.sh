#!/bin/bash
#FLUX: --job-name=Melanoma_Brain_Metastasis
#FLUX: --queue=single
#FLUX: -t=172800
#FLUX: --urgency=16

module load system/singularity
module load devel/java_jdk/1.8.0
main_project_dir=/Melanoma_Brain_Metastasis
bfconvert=/bin/bftools/bfconvert
singluarity_cache=/singularity_cache
orig_tif_dir=$main_project_dir/original_tifs
mcmicro_dirs=$main_project_dir/mcmicro
script_dir=$main_project_dir/scripts
marker_file=$main_project_dir/markers.csv
cd $orig_tif_dir
for FILE in *.tif
do
        echo $FILE
        ## Parse the input filename
        new_filename="${FILE//[/}"
        new_filename="${new_filename//]/}"
        new_filename="${new_filename//,/-}"
        new_filename="${new_filename//_component_data/}"
        folder_name="${new_filename//.tif/}"
         if [ ! -f $mcmicro_dirs/$folder_name/registration/$new_filename ]
         then
                echo "Processing: "$FILE
                ## create folders for sample
                mkdir $mcmicro_dirs/$folder_name
                mkdir $mcmicro_dirs/$folder_name/registration
                mkdir $mcmicro_dirs/$folder_name/segmentation
                cp $marker_file $mcmicro_dirs/$folder_name
                ## run bfconvert
                $bfconvert -series 0 $orig_tif_dir/$FILE $mcmicro_dirs/$folder_name/registration/$new_filename
                ## run mesmer via singularity
                registration_dir=$mcmicro_dirs/$folder_name/registration
                segmentation_dir=$mcmicro_dirs/$folder_name/segmentation/mesmer-$folder_name
                mkdir $segmentation_dir
                mesmer_container=$singluarity_cache/vanvalenlab-deepcell-applications-0.3.0.img
                singularity exec -B $registration_dir:/input -B $segmentation_dir:/output $mesmer_container python /usr/src/app/run_app.py mesmer --squeeze --output-directory /output --output-name cell.tif --nuclear-image /input/$new_filename --nuclear-channel 0 --image-mpp 0.49 --membrane-image /input/$new_filename --membrane-channel 4
                ## run MCMICRO
                nextflow run labsyspharm/mcmicro -profile singularity --in $mcmicro_dirs/$folder_name --start-at quantification --stop-at quantification
        else
        echo $FILE" already processed!"
        fi
done
