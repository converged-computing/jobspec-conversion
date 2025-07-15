#!/bin/bash
#FLUX: --job-name=bricky-pedo-1304
#FLUX: -c=67
#FLUX: --urgency=16

:"
module load intel/17.0.4
module load gnuparallel
module load biocontainers/0.1.0 	#With this module, various other tools/modules can be loaded
module load bwa/0.7.16a
module load blast/2.6.0
module load samtools/1.10
module load python2
module list
pwd
date
parallel -j 2 bash 2b.hybphaser_sample_Nikolov2019.sh {} :::: namelist.txt
parallel -j 2 bash 2b.hybphaser_sample_Angiosperms353NewTargets.sh {} :::: namelist.txt
parallel -j 2 bash 2c.hybphaser_combine_results_bait_sets.sh {} :::: namelist.txt
"
cd results_HybPhaser_allGenes/
module load intel/18.0.0
module load impi/18.0.0
module load RstatsPackages/3.5.1
module load Rstats/3.5.1
module load gnuparallel
module list
pwd
date
mkdir -p output_HybPhaser_allGenes/01_data_backup/
mv output_HybPhaser_allGenes/01_data/* output_HybPhaser_allGenes/01_data_backup/
for directory in $(cat ../namelist.txt); do mv output_HybPhaser_allGenes/01_data_backup/${directory} output_HybPhaser_allGenes/01_data/; done
Rscript ../hybphaser_scripts_updated_for_BrassiWood_project/1c_generate_sequence_lists_generalStart.R config_inclusive.txt
awk -F"," '{print $2}' genelist_allGenes_inclusive.txt > genelist_allGenes_inclusive_temp1.txt
sed 's/"x"//g' genelist_allGenes_inclusive_temp1.txt > genelist_allGenes_inclusive_temp2.txt
sed 's/"//g' genelist_allGenes_inclusive_temp2.txt > genelist_allGenes_inclusive_temp3.txt
sed '/^$/d' genelist_allGenes_inclusive_temp3.txt > genelist_allGenes_inclusive.txt
rm genelist_allGenes_inclusive_temp*.txt
parallel -j 67 Rscript ../hybphaser_scripts_updated_for_BrassiWood_project/1c_generate_sequence_lists_perLocus.R config_inclusive.txt :::: genelist_allGenes_inclusive.txt
rm -r output_HybPhaser_allGenes/03_sequence_lists_backup/
mkdir -p output_HybPhaser_allGenes/03_sequence_lists_backup/
cp -r output_HybPhaser_allGenes/03_sequence_lists_inclusive/* output_HybPhaser_allGenes/03_sequence_lists_backup/
cd ..
date
