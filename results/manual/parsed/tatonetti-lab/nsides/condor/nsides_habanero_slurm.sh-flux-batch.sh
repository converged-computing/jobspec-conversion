#!/bin/bash
#FLUX: --job-name=NSIDES_%A_%a
#FLUX: --urgency=16

start=`date +%s`
module load cuda80/toolkit cuda80/blas cudnn/5.1
module load anaconda/2-4.2.0
pip install --user tensorflow-gpu keras h5py
i=${SLURM_ARRAY_TASK_ID}
mkdir $i
cd $i
python ../prepare_data_habanero.py --model-number $i | tee prepare_data.log
python ../prepare_data_separate_reports_habanero.py --model-number $i | tee prepare_data_separate_reports.log
python ../mlp_dnn.py --model-number $i | tee mlp_dnn.log
python ../mlp_shallow_osg.py --model-number $i | tee mlp_shallow.log
python ../eval_model_habanero.py --model-type tflr --model-number $i | tee eval_model_tflr.log
python ../eval_model_habanero.py --model-type bdt --model-number $i | tee eval_model_bdt.log
python ../eval_model_habanero.py --model-type rfc --model-number $i | tee eval_model_rfc.log
python ../eval_model_habanero.py --model-type lrc --model-number $i | tee eval_model_lrc.log
python ../eval_model_habanero.py --model-type dnn --model-number $i | tee eval_model_dnn.log
python ../eval_model_habanero.py --model-type nopsm --model-number $i | tee eval_model_nopsm.log
printf -v j "%03d" $i
tar -czvf ../../../nsides_results/results_"$j"_gpu.tar.gz results*.pkl *.log
cd ..
rm -rf $i
end=`date +%s`
runtime=$((end-start))
echo Elapsed time for running model $i : $runtime
