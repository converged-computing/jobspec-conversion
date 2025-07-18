#!/bin/bash
#FLUX: --job-name=dagstuhloid
#FLUX: -c=67
#FLUX: --queue=learnlab
#FLUX: -t=259200
#FLUX: --urgency=16

tasks=(zp_pbbob zp_ms_bbob aquacrop_fao bonnans deceptive double_o_seven fishing instrum_discrete keras_tuning mldakmeans mltuning mono_rocket multimodal multiobjective_example multiobjective_example_hd multiobjective_example_many_hd naive_seq_keras_tuning naive_seq_mltuning naive_veryseq_keras_tuning naivemltuning nano_naive_seq_mltuning nano_naive_veryseq_mltuning nano_seq_mltuning nano_veryseq_mltuning neuro_oneshot_mltuning pbbob pbo_reduced_suite reduced_yahdlbbbob rocket seq_keras_tuning seq_mltuning sequential_instrum_discrete sequential_topology_optimization spsa_benchmark topology_optimization ultrasmall_photonics ultrasmall_photonics2 veryseq_keras_tuning yabbob yabigbbob yaboundedbbob yaboxbbob yahdbbob yahdnoisybbob yamegapenbbob yamegapenboundedbbob yamegapenboxbbob yanoisybbob yaonepenbbob yaonepenboundedbbob yaonepenboxbbob yaonepennoisybbob yaonepenparabbob yaonepensmallbbob yaparabbob yapenbbob yapenboundedbbob yapenboxbbob yapennoisybbob yapenparabbob yapensmallbbob yasmallbbob yatinybbob yatuningbbob ms_bbob ranknoisy powersystems verysmall_photonics verysmall_photonics2)
task=${tasks[SLURM_ARRAY_TASK_ID]}
echo task attribution $SLURM_ARRAY_TASK_ID $task
echo Keras/TF versions:
pip show keras tensorflow tensorflow-estimator
conda info
echo Starting at
date
python -m nevergrad.benchmark $task --num_workers=71 2>&1 | tail -n 50
echo task over $SLURM_ARRAY_TASK_ID $task
echo Finishing at
date
