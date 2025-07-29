#!/bin/bash
#SBATCH --job-name=songbird
#SBATCH --output=array_%A-%a.out
#SBATCH --mail-user=mcalgaro93@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5gb
#SBATCH --time=1-00:00:00
#SBATCH --array=1-20

PER_TASK=5
START_NUM=$(( ($SLURM_ARRAY_TASK_ID - 1) * $PER_TASK + 1 ))
END_NUM=$(( $SLURM_ARRAY_TASK_ID * $PER_TASK ))
echo This is task $SLURM_ARRAY_TASK_ID, which will do runs $START_NUM to $END_NUM
module purge
module load Anaconda/2019.07
source activate songbird_env
run=$START_NUM
while [ $run -le $END_NUM ]; do 
	echo This is SLURM task $SLURM_ARRAY_TASK_ID, run number $run; 
	biom convert -i './songbird/16S_subgingival_supragingival_Comparison'$run'_Subset1_otutable.tsv' -o './songbird/16S_subgingival_supragingival_Comparison'$run'_Subset1_otutable.biom' --to-hdf5 
	biom convert -i './songbird/16S_subgingival_supragingival_Comparison'$run'_Subset2_otutable.tsv' -o './songbird/16S_subgingival_supragingival_Comparison'$run'_Subset2_otutable.biom' --to-hdf5 
	biom convert -i './songbird/16S_gingiva_mucosa_Comparison'$run'_Subset1_otutable.tsv' -o './songbird/16S_gingiva_mucosa_Comparison'$run'_Subset1_otutable.biom' --to-hdf5 
	biom convert -i './songbird/16S_gingiva_mucosa_Comparison'$run'_Subset2_otutable.tsv' -o './songbird/16S_gingiva_mucosa_Comparison'$run'_Subset2_otutable.biom' --to-hdf5 
	biom convert -i './songbird/16S_tonguedorsum_stool_Comparison'$run'_Subset1_otutable.tsv' -o './songbird/16S_tonguedorsum_stool_Comparison'$run'_Subset1_otutable.biom' --to-hdf5 
	biom convert -i './songbird/16S_tonguedorsum_stool_Comparison'$run'_Subset2_otutable.tsv' -o './songbird/16S_tonguedorsum_stool_Comparison'$run'_Subset2_otutable.biom' --to-hdf5 
	mkdir './songbird/16S_subgingival_supragingival_Comparison'$run'_Subset1'
	songbird multinomial --input-biom './songbird/16S_subgingival_supragingival_Comparison'$run'_Subset1_otutable.biom' \
                         --metadata-file './songbird/16S_subgingival_supragingival_Comparison'$run'_Subset1_samdata.tsv' \
                         --formula "grp" \
                         --summary-dir './songbird/16S_subgingival_supragingival_Comparison'$run'_Subset1'
	mkdir './songbird/16S_subgingival_supragingival_Comparison'$run'_Subset2'
	songbird multinomial --input-biom './songbird/16S_subgingival_supragingival_Comparison'$run'_Subset2_otutable.biom' \
                         --metadata-file './songbird/16S_subgingival_supragingival_Comparison'$run'_Subset2_samdata.tsv' \
                         --formula "grp" \
                         --summary-dir './songbird/16S_subgingival_supragingival_Comparison'$run'_Subset2'
	mkdir './songbird/16S_gingiva_mucosa_Comparison'$run'_Subset1'
	songbird multinomial --input-biom './songbird/16S_gingiva_mucosa_Comparison'$run'_Subset1_otutable.biom' \
                         --metadata-file './songbird/16S_gingiva_mucosa_Comparison'$run'_Subset1_samdata.tsv' \
                         --formula "grp" \
                         --summary-dir './songbird/16S_gingiva_mucosa_Comparison'$run'_Subset1'
	mkdir './songbird/16S_gingiva_mucosa_Comparison'$run'_Subset2'
	songbird multinomial --input-biom './songbird/16S_gingiva_mucosa_Comparison'$run'_Subset2_otutable.biom' \
                         --metadata-file './songbird/16S_gingiva_mucosa_Comparison'$run'_Subset2_samdata.tsv' \
                         --formula "grp" \
                         --summary-dir './songbird/16S_gingiva_mucosa_Comparison'$run'_Subset2'
	mkdir './songbird/16S_tonguedorsum_stool_Comparison'$run'_Subset1'
	songbird multinomial --input-biom './songbird/16S_tonguedorsum_stool_Comparison'$run'_Subset1_otutable.biom' \
                         --metadata-file './songbird/16S_tonguedorsum_stool_Comparison'$run'_Subset1_samdata.tsv' \
                         --formula "grp" \
                         --summary-dir './songbird/16S_tonguedorsum_stool_Comparison'$run'_Subset1'
	mkdir './songbird/16S_tonguedorsum_stool_Comparison'$run'_Subset2'
	songbird multinomial --input-biom './songbird/16S_tonguedorsum_stool_Comparison'$run'_Subset2_otutable.biom' \
                         --metadata-file './songbird/16S_tonguedorsum_stool_Comparison'$run'_Subset2_samdata.tsv' \
                         --formula "grp" \
                         --summary-dir './songbird/16S_tonguedorsum_stool_Comparison'$run'_Subset2'
	############################################################################################################################
	biom convert -i './songbird/WMS_CRC_control_Comparison'$run'_Subset1_otutable.tsv' -o './songbird/WMS_CRC_control_Comparison'$run'_Subset1_otutable.biom' --to-hdf5 
	biom convert -i './songbird/WMS_CRC_control_Comparison'$run'_Subset2_otutable.tsv' -o './songbird/WMS_CRC_control_Comparison'$run'_Subset2_otutable.biom' --to-hdf5 
	biom convert -i './songbird/WMS_schizophrenia_control_Comparison'$run'_Subset1_otutable.tsv' -o './songbird/WMS_schizophrenia_control_Comparison'$run'_Subset1_otutable.biom' --to-hdf5 
	biom convert -i './songbird/WMS_schizophrenia_control_Comparison'$run'_Subset2_otutable.tsv' -o './songbird/WMS_schizophrenia_control_Comparison'$run'_Subset2_otutable.biom' --to-hdf5 
	biom convert -i './songbird/WMS_tonguedorsum_stool_Comparison'$run'_Subset1_otutable.tsv' -o './songbird/WMS_tonguedorsum_stool_Comparison'$run'_Subset1_otutable.biom' --to-hdf5 
	biom convert -i './songbird/WMS_tonguedorsum_stool_Comparison'$run'_Subset2_otutable.tsv' -o './songbird/WMS_tonguedorsum_stool_Comparison'$run'_Subset2_otutable.biom' --to-hdf5 
	mkdir './songbird/WMS_CRC_control_Comparison'$run'_Subset1'
	songbird multinomial --input-biom './songbird/WMS_CRC_control_Comparison'$run'_Subset1_otutable.biom' \
                         --metadata-file './songbird/WMS_CRC_control_Comparison'$run'_Subset1_samdata.tsv' \
                         --formula "grp" \
                         --summary-dir './songbird/WMS_CRC_control_Comparison'$run'_Subset1'
	mkdir './songbird/WMS_CRC_control_Comparison'$run'_Subset2'
	songbird multinomial --input-biom './songbird/WMS_CRC_control_Comparison'$run'_Subset2_otutable.biom' \
                         --metadata-file './songbird/WMS_CRC_control_Comparison'$run'_Subset2_samdata.tsv' \
                         --formula "grp" \
                         --summary-dir './songbird/WMS_CRC_control_Comparison'$run'_Subset2'
	mkdir './songbird/WMS_schizophrenia_control_Comparison'$run'_Subset1'
	songbird multinomial --input-biom './songbird/WMS_schizophrenia_control_Comparison'$run'_Subset1_otutable.biom' \
                         --metadata-file './songbird/WMS_schizophrenia_control_Comparison'$run'_Subset1_samdata.tsv' \
                         --formula "grp" \
                         --summary-dir './songbird/WMS_schizophrenia_control_Comparison'$run'_Subset1'
	mkdir './songbird/WMS_schizophrenia_control_Comparison'$run'_Subset2'
	songbird multinomial --input-biom './songbird/WMS_schizophrenia_control_Comparison'$run'_Subset2_otutable.biom' \
                         --metadata-file './songbird/WMS_schizophrenia_control_Comparison'$run'_Subset2_samdata.tsv' \
                         --formula "grp" \
                         --summary-dir './songbird/WMS_schizophrenia_control_Comparison'$run'_Subset2'
	mkdir './songbird/WMS_tonguedorsum_stool_Comparison'$run'_Subset1'
	songbird multinomial --input-biom './songbird/WMS_tonguedorsum_stool_Comparison'$run'_Subset1_otutable.biom' \
                         --metadata-file './songbird/WMS_tonguedorsum_stool_Comparison'$run'_Subset1_samdata.tsv' \
                         --formula "grp" \
                         --summary-dir './songbird/WMS_tonguedorsum_stool_Comparison'$run'_Subset1'
	mkdir './songbird/WMS_tonguedorsum_stool_Comparison'$run'_Subset2'
	songbird multinomial --input-biom './songbird/WMS_tonguedorsum_stool_Comparison'$run'_Subset2_otutable.biom' \
                         --metadata-file './songbird/WMS_tonguedorsum_stool_Comparison'$run'_Subset2_samdata.tsv' \
                         --formula "grp" \
                         --summary-dir './songbird/WMS_tonguedorsum_stool_Comparison'$run'_Subset2'
	run=$((run+1)); 
done
