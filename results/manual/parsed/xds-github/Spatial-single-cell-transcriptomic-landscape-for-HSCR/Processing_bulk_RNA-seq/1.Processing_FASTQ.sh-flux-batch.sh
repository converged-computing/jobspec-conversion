#!/bin/bash
#FLUX: --job-name=misunderstood-cinnamonbun-1677
#FLUX: -c=6
#FLUX: --queue=compute
#FLUX: --urgency=16

your_folder=/share/home/xudeshu/ #本人所在的根目录
input_folder=/data/xudeshu/HSCR_bulk_RNA_data/ # 原始数据目录
temp_folder=/share/home/xudeshu/temp211016/ # 临时文件夹
result_foler=/share/home/xudeshu/result/ #结果文件夹
mkdir ${result_foler}
rm -rf ${temp_folder}
mkdir ${temp_folder}
mkdir ${temp_folder}filter_dic/
mkdir ${temp_folder}report_dic/
filtered_data=${temp_folder}filter_dic/
report_folder=${temp_folder}report_dic/
STAR_index=/share/soft/human_star_index2/
gtf_file=/share/soft/human_ensemble_resource/Homo_sapiens.GRCh38.104.gtf
cd ${temp_folder}
ls ${input_folder} | grep '_R1.fq.gz$' > 1 # This line may should be changed
ls ${input_folder} | grep '_R2.fq.gz$' > 2 # This line may should be changed
ls ${input_folder} | grep '_R1.fq.gz$' | cut -d '_' -f 1 > 0 # This line should be changed
paste 0 1 2 > configure
cat configure | while read id
do
arr=(${id})
Read_1=${arr[1]}
Read_2=${arr[2]}
sample_Name=${arr[0]}
cp /share/soft/slurm_template.txt ${temp_folder}${sample_Name}.sh
echo "#SBATCH --job-name=rnaseq_${sample_Name}
docker run --rm --cpus=6 -v ${your_folder}:${your_folder} -v /share/soft:/share/soft  -v /data:/data f0651ca08acd /root/miniconda3/bin/fastp -i ${input_folder}${Read_1} -o ${filtered_data}${Read_1} -I ${input_folder}${Read_2} -O ${filtered_data}${Read_2} -j ${report_folder}${sample_Name}_fastp.json -w 6 -q 19 -u 50 -l 36 -x 
docker run --rm --cpus=6 -v ${your_folder}:${your_folder} -v /share/soft:/share/soft -v /data:/data f0651ca08acd /root/miniconda3/bin/STAR --runThreadN 6 --genomeDir ${STAR_index} --readFilesIn ${filtered_data}${Read_1} ${filtered_data}${Read_2} --readFilesCommand gunzip -c --outSAMtype BAM SortedByCoordinate --quantMode GeneCounts --outFileNamePrefix ${temp_folder}${sample_Name}_
cp ${temp_folder}${sample_Name}_ReadsPerGene.out.tab ${result_foler}${sample_Name}_ReadsPerGene.out.tab" >> ${temp_folder}${sample_Name}.sh
echo "sbatch ${temp_folder}${sample_Name}.sh" >> ${temp_folder}submit.sh
done
sh ${temp_folder}submit.sh
docker run --rm --cpus=6 -v ${your_folder}:${your_folder} -v /share/soft:/share/soft -v /data:/data f0651ca08acd chmod -R 777 ${temp_folder}
squeue #查看任务情况
docker run --rm --cpus=1 -v ${your_folder}:${your_folder} -v /share/soft:/share/soft f0651ca08acd /root/miniconda3/bin/multiqc ${temp_folder}. -o ${result_foler}
docker run --rm --cpus=1 -v ${your_folder}:${your_folder} -v /share/soft:/share/soft -v /data:/data f0651ca08acd chmod -R 777 ${result_foler}
