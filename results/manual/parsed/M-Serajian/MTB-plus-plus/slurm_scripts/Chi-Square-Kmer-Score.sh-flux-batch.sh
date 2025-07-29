#!/bin/bash
#FLUX: --job-name=$job_name
#FLUX: --urgency=16

Cross_Validation_number_parallel=0 #form zero to k-1 for k fold cross-validation
Needed_memory=155gb
Process_time=60:00:00
Array_job_list=1-12 # single job
Main_job_action_name=Chi_Square
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
mkdir -p temp/logs   #The address for saving the logs
for ((i=0; i<=15; i++))
do
job_name="Chi_Score_"${drugs[i]}
drug_name=${drugs[i]}
drug_name_group=$drug_name
Cross_Validation_number=$Cross_Validation_number_parallel
Number_of_samples=6224
Kmers_address=/blue/boucher/share/Deep_TB_Ali/Final_TB/NPY_Binary_Files_with_index/
Chi_score_addresses_for_each_drug=/blue/boucher/share/Deep_TB_Ali/Final_TB/Chi_score_drugs/Chi_score_CV$Cross_Validation_number_parallel/
train_index_address="/blue/boucher/share/Deep_TB_Ali/Final_TB/test_train_index/Cross_validation_$Cross_Validation_number_parallel/train_index_CV$Cross_Validation_number.npy"
test_index_address="/blue/boucher/share/Deep_TB_Ali/Final_TB/test_train_index/Cross_validation_$Cross_Validation_number_parallel/test_index_CV$Cross_Validation_number.npy"
address_to_phenotypes="6224_Targets_NA_3_letters.csv"
Cross_validation_index=$Cross_Validation_number_parallel
cat << EOF > ./temp/$job_name.sh
ml python3
chmod a+x projects/MTB-plus-plus/src/Chi-Square-Kmer-Score/Chi-Square-Kmer-ranking.py
mkdir -p $Chi_score_addresses_for_each_drug$drug_name_group
python projects/MTB-plus-plus/src/Chi-Square-Kmer-Score/Chi-Square-Kmer-ranking.py \${SLURM_ARRAY_TASK_ID} \\
$drug_name_group\\
$Number_of_samples\\
$Kmers_address\\
$Chi_score_addresses_for_each_drug\\
$Cross_validation_indexes_address\\
$address_to_phenotypes\\
$Cross_validation_folds\\
$Cross_validation_index
EOF
sbatch ./temp/$job_name.sh
echo Chi Square test for ${drug_name} submitted!
done
