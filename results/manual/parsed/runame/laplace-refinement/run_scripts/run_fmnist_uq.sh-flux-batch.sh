#!/bin/bash
#FLUX: --job-name=pusheena-pancake-6033
#FLUX: --queue=gpu-2080ti
#FLUX: -t=259200
#FLUX: --urgency=16

scontrol show job $SLURM_JOB_ID
declare -a datasets=("R-FMNIST" "FMNIST-OOD")
declare -a nfmethods=("refine" "nf_naive")
declare -a prior_optim=("marglik" "CV")
data_root=/mnt/qb/hennig/data/
models_root=/mnt/qb/hennig/pretrained_models
for dataset in "${datasets[@]}";
do
    # Assuming you have activated your conda environment
    # MAP
    python uq.py --benchmark $dataset --method map --model LeNet --data_root ${data_root} --models_root ${models_root} --model_seed $SLURM_ARRAY_TASK_ID
    for prior in "${prior_optim[@]}";
    do
        # LA-NN-MC
        python uq.py --benchmark $dataset --method laplace --subset_of_weights last_layer --hessian_structure full --optimize_prior_precision $prior --pred_type nn --link_approx mc --n_samples 20 --model LeNet --data_root ${data_root} --models_root ${models_root} --compute_mmd --model_seed $SLURM_ARRAY_TASK_ID --run_name $dataset/la_nn_mc_${prior}_$SLURM_ARRAY_TASK_ID
        # LA-MC
        python uq.py --benchmark $dataset --method laplace --subset_of_weights last_layer --hessian_structure full --optimize_prior_precision $prior --pred_type glm --link_approx mc --n_samples 20 --model LeNet --data_root ${data_root} --models_root ${models_root} --compute_mmd --model_seed $SLURM_ARRAY_TASK_ID --run_name $dataset/la_glm_mc_${prior}_$SLURM_ARRAY_TASK_ID
        # LA-Probit
        python uq.py --benchmark $dataset --method laplace --subset_of_weights last_layer --hessian_structure full --optimize_prior_precision $prior --pred_type glm --link_approx probit --model LeNet --data_root ${data_root} --models_root ${models_root} --compute_mmd --model_seed $SLURM_ARRAY_TASK_ID --run_name $dataset/la_glm_probit_${prior}_$SLURM_ARRAY_TASK_ID
    done
    # HMC
    python uq.py --benchmark $dataset --method hmc --prior_precision 510 --model LeNet --data_root ${data_root} --models_root ${models_root} --compute_mmd --model_seed $SLURM_ARRAY_TASK_ID
    # Refine & NF-N(0,I)
    for nfmethod in "${nfmethods[@]}";
    do
        echo ${nfmethod}
        echo 1
        python uq.py --benchmark $dataset --method ${nfmethod}_radial_1 --prior_precision 510 --model LeNet --data_root ${data_root} --models_root ${models_root} --compute_mmd --model_seed $SLURM_ARRAY_TASK_ID
        for n_flows in {5..30..5};
        do
                echo $n_flows
                python uq.py --benchmark $dataset --method ${nfmethod}_radial_${n_flows} --prior_precision 510 --model LeNet --data_root ${data_root} --models_root ${models_root} --compute_mmd --model_seed $SLURM_ARRAY_TASK_ID
        done
    done
    # Baslines
    python uq.py --benchmark $dataset --method ensemble --nr_components 5 --model LeNet --data_root ${data_root} --models_root ${models_root} --model_seed $SLURM_ARRAY_TASK_ID
    python uq.py --benchmark $dataset --method bbb --model LeNet-BBB-flipout --normalize --data_root ${data_root} --models_root ${models_root} --model_seed $SLURM_ARRAY_TASK_ID
    python uq.py --benchmark $dataset --method csghmc --model LeNet-CSGHMC --normalize --data_root ${data_root} --models_root ${models_root} --model_seed $SLURM_ARRAY_TASK_ID
done
