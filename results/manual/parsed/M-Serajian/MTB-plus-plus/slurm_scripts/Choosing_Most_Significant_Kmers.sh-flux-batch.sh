#!/bin/bash
#FLUX: --job-name=$job_name
#FLUX: --urgency=16

Cross_Validation_number_parallel=4
Number_of_Top_Kmers=524288
Number_of_samples=6224
Needed_memory=156gb
process_time=60:00:00
array_job_list=1-1 # single job
main_job_action_name=Kmer_concat
drugs=("Amikacin" \
"Bedaquiline" \
"Clofazimine" \
"Delamanid" \
"Ethambutol" \
"Ethionamide" \
"Isoniazid" \
"Kanamycin" \
"Levofloxacin" \
"Linezolid" \
"Moxifloxacin" \
"Rifampicin" \
"Rifabutin" \
"RIA" \
"AMG" \
"FQS")
mkdir -p temp
mkdir -p temp/logs   #for saving the logs
for ((i=0; i<=15; i++))
do
job_name=$main_job_action_name"_"${drugs[i]}
drug_name_group=${drugs[i]}
Cross_Validation_number=$Cross_Validation_number_parallel
Kmers_address=/blue/boucher/share/Deep_TB_Ali/Final_TB/NPY_Binary_Files_with_index/
Top_kmers_for_each_drug_address=/blue/boucher/share/Deep_TB_Ali/Final_TB/Top_kmers_for_each_drug/Cross_validation_$Cross_Validation_number_parallel/
Chi_score_addresses_for_each_drug=/blue/boucher/share/Deep_TB_Ali/Final_TB/Chi_score_drugs/Chi_score_CV$Cross_Validation_number_parallel/
Phenotypes_address="6224_Targets_NA_3_letters.csv"
cat << EOF > ./temp/$job_name.sh
ml python3
chmod a+x projects/MTB-plus-plus/src/Choosing_Most_Significant_Kmers/Choosing_Most_Significant_Kmers.py
mkdir -p $Top_kmers_for_each_drug_address$drug_name_group
python projects/MTB-plus-plus/src/Choosing_Most_Significant_Kmers/Choosing_Most_Significant_Kmers.py  $drug_name_group\\
$Number_of_Top_Kmers\\
$Number_of_samples\\
$Kmers_address\\
$Top_kmers_for_each_drug_address\\
$Chi_score_addresses_for_each_drug\\
$Phenotypes_address
EOF
sbatch ./temp/$job_name.sh
echo Chi Square test for ${drug_name_group} submitted!
done
