#!/bin/bash
#FLUX: --job-name=HCA
#FLUX: -c=4
#FLUX: --queue=cpu
#FLUX: -t=259200
#FLUX: --urgency=16

export manifest_file='../../../source_files/scRNA_Seq/Manifest_file.tsv'
export tmp_folder_Download_data='/tmp/DOWNLOAD_HCA_DATA.$RANDOM'
export final_destination='/work/FAC/FBM/DEE/mrobinso/bgee/downloads/scRNA_Seq_All/scRNASeq_libraries_Droplet_10X/'

source  /dcsrsoft/spack/bin/setup_dcsrsoft
module load gcc python py-virtualenv
python -V
export manifest_file=../../../source_files/scRNA_Seq/Manifest_file.tsv
export tmp_folder_Download_data=/tmp/DOWNLOAD_HCA_DATA.$RANDOM
export final_destination=/work/FAC/FBM/DEE/mrobinso/bgee/downloads/scRNA_Seq_All/scRNASeq_libraries_Droplet_10X/
virtualenv hca
source hca/bin/activate
pip install hca
hca --version
if [ -d $tmp_folder_Download_data ]; then
    rm -r $tmp_folder_Download_data || exit 1
fi
mkdir -v $tmp_folder_Download_data
hca dss download-manifest --manifest $manifest_file --download-dir $tmp_folder_Download_data --replica 'aws' --layout bundle --no-metadata
declare -A dirs_to_move
while read -r el1 el2 the_rest; do
    dirs_to_move[$el1.$el2]=1
done <<< "$(sed 1d $manifest_file)"
echo; echo "List of unique directories = ${!dirs_to_move[@]}"; echo
for dir_name in "${!dirs_to_move[@]}"; do
    echo; echo "@@@ Dealing with unique directory: $dir_name"
    ## delete if already present in final destination folder
    if [[ -d $final_destination/$dir_name ]]; then
	echo "Warning: deleting $final_destination/$dir_name"
	rm -rv $final_destination/$dir_name
    fi
    ## copy the new data
    mv -v $tmp_folder_Download_data/$dir_name $final_destination
done
rm -r $tmp_folder_Download_data
