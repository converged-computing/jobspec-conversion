#!/bin/bash
#FLUX: --job-name=predictvisits_bootstrap_${race}_${originmode}
#FLUX: --queue=bigmem2
#FLUX: -t=36000
#FLUX: --urgency=16

for originmode in mainspec mintime
do
for race in black asian whithisp
do
LIST_INSTANCES_1=`cat ../input/estimates/${originmode}/estimates_${race}_${originmode}_bootstrap_clean.csv | awk 'NR > 1' |awk -F,  '{print $5}'|sort -u|sort -n| sed -n 1,100p| paste -d, -s`
LIST_INSTANCES_2=`cat ../input/estimates/${originmode}/estimates_${race}_${originmode}_bootstrap_clean.csv | awk 'NR > 1' |awk -F,  '{print $5}'|sort -u|sort -n| sed -n 101,200p| paste -d, -s`
LIST_INSTANCES_3=`cat ../input/estimates/${originmode}/estimates_${race}_${originmode}_bootstrap_clean.csv | awk 'NR > 1' |awk -F,  '{print $5}'|sort -u|sort -n| sed -n 201,300p| paste -d, -s`
LIST_INSTANCES_4=`cat ../input/estimates/${originmode}/estimates_${race}_${originmode}_bootstrap_clean.csv | awk 'NR > 1' |awk -F,  '{print $5}'|sort -u|sort -n| sed -n 301,400p| paste -d, -s`
LIST_INSTANCES_5=`cat ../input/estimates/${originmode}/estimates_${race}_${originmode}_bootstrap_clean.csv | awk 'NR > 1' |awk -F,  '{print $5}'|sort -u|sort -n| sed -n 401,500p| paste -d, -s`
count=1
for i in $LIST_INSTANCES_1 $LIST_INSTANCES_2 $LIST_INSTANCES_3 $LIST_INSTANCES_4 $LIST_INSTANCES_5
do
echo "#!/bin/bash
module load julia/0.6.2
julia -p \$SLURM_NTASKS predvisits_bootstrap.jl ${race} ${originmode} \$SLURM_ARRAY_TASK_ID
"> run_array_${race}_${originmode}_$count.sbatch
count=`expr $count + 1`
done
done
done
