#!/bin/bash
#FLUX: --job-name=Mar18
#FLUX: --queue=broadwl
#FLUX: -t=129600
#FLUX: --priority=16

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
module load gcc/6.1
module load python/cpython-3.7.0
module load R
filePrefix=LongEnd
remoteDir=/scratch/midway2/heqixin/${filePrefix}_${SLURM_ARRAY_TASK_ID}
cp -r /home/heqixin/varmodel2 $remoteDir
cd $remoteDir
cd IRStests
python writeGIParameters.py -p ${filePrefix}_param.csv -i {filePrefix}_Template.py -n $SLURM_ARRAY_TASK_ID -r 5 -x $filePrefix
cd ..
./build.py -p IRStests/${filePrefix}_${SLURM_ARRAY_TASK_ID}_s0_input.py -d s0
./s0/bin/varMig
Rscript writeSummaryTableFast.r ./ ${filePrefix} ${SLURM_ARRAY_TASK_ID} ../results/ 0 0
cd IRStests
python writeGIParameters.py -p -p ${filePrefix}_param.csv -i {filePrefix}_Template.py -n $SLURM_ARRAY_TASK_ID -g -r 5 -x $filePrefix
cd ..
./build.py -p IRStests/${filePrefix}_${SLURM_ARRAY_TASK_ID}_s4_input.py -d s4
./s4/bin/varMig
Rscript writeSummaryTableFast.r ./ ${filePrefix} ${SLURM_ARRAY_TASK_ID} ../results/ 4 0
for j in {0..4}
do
	for i in {3..3}
	do
	./build.py -p IRStests/${filePrefix}_${SLURM_ARRAY_TASK_ID}_s${i}_r${j}_input.py -d s${i}_r${j}
	./s${i}_r${j}/bin/varMig
	Rscript writeSummaryTableFast.r ./ ${filePrefix} ${SLURM_ARRAY_TASK_ID} ../results/ ${i} ${j}
	Rscript ../runInfo/writeDuration.r ./ ${filePrefix} ${SLURM_ARRAY_TASK_ID} ../results/ ${i} ${j}
	done
	for i in {7..7}
	do
	./build.py -p IRStests/${filePrefix}_${SLURM_ARRAY_TASK_ID}_s${i}_r${j}_input.py -d s${i}_r${j}
	./s${i}_r${j}/bin/varMig
	Rscript writeSummaryTableFast.r ./ ${filePrefix} ${SLURM_ARRAY_TASK_ID} ../results/ ${i} ${j}
	Rscript ../runInfo/writeDuration.r ./ ${filePrefix} ${SLURM_ARRAY_TASK_ID} ../results/ ${i} ${j}
	done
done
