#!/bin/bash
#FLUX: --job-name=rainbow-ricecake-3677
#FLUX: -c=16
#FLUX: -t=86400
#FLUX: --priority=16

mkdir -p logs
PYTHON_VIRTUAL_ENVIRONMENT=wavprompt
CONDA_ROOT=/nobackup/users/$(whoami)/espnet/tools/conda
source ${CONDA_ROOT}/etc/profile.d/conda.sh
conda activate $PYTHON_VIRTUAL_ENVIRONMENT
RUN_CMD=$1
CMD="srun --ntasks=1 --exclusive --gres=gpu:1 --mem=200G -c 16"
if [ "${RUN_CMD}" = "bash" ]; then
    CMD=""
    PARALLEL="false"
    echo "PARALLEL: ${PARALLEL}"
else
    ulimit -s unlimited
    ## Creating SLURM nodes list
    export NODELIST=nodelist.$
    srun -l bash -c 'hostname' |  sort -k 2 -u | awk -vORS=, '{print $2":4"}' | sed 's/,$//' > $NODELIST
    ## Number of total processes
    echo " "
    echo " Nodelist:= " $SLURM_JOB_NODELIST
    echo " Number of nodes:= " $SLURM_JOB_NUM_NODES
    echo " GPUs per node:= " $SLURM_JOB_GPUS
    echo " Ntasks per node:= "  $SLURM_NTASKS_PER_NODE
    ####    Use MPI for communication with Horovod - this can be hard-coded during installation as well.
    export HOROVOD_GPU_ALLREDUCE=MPI
    export HOROVOD_GPU_ALLGATHER=MPI
    export HOROVOD_GPU_BROADCAST=MPI
    export NCCL_DEBUG=DEBUG
    echo " Running on multiple nodes/GPU devices"
    echo ""
    echo " Run started at:- "
    date
    CMD="srun --ntasks=1 --exclusive --gres=gpu:1 --mem=200G -c 16"
    PARALLEL="true"
fi
function eval {
    manifest_dir=$1
    split=$2
    all_scena=$3
    scena=${all_scena// /_}
    ckpt_path_template=$4
    ckpt_path_variable=$5
    stage=$6
    output_folder=$7
    prompt=$8
    hyp_manifest_dir=$9
    ${CMD} ./run.sh --stage 100 --stop-stage 100 \
        --transcript-folder ${hyp_manifest_dir} \
        --manifest-dir "${manifest_dir}" --split "${split}" \
        --all-scenarios "${all_scena}" \
        --ckpt-path-template ${ckpt_path_template} \
        --ckpt-path-variable ${ckpt_path_variable}
    ${CMD} ./run.sh \
        --stage ${stage} --stop-stage ${stage} \
        --all-scenarios "${all_scena}" --output-folder "${output_folder}" --ckpt-path-template "${ckpt_path_template}" \
        --prompt "${prompt}" --split "${scena}" --manifest-dir ${hyp_manifest_dir} --ckpt-path-variable "${ckpt_path_variable}"
}
eval_folder=evaluation
transcript_folder=${eval_folder}/transcripts
stage=110
dataset=flickr8k
manifest_dir="manifest/flickr8k"
all_scenarios=("black white" "dark light" "man woman" "male female")
model_key_s="wavpromptlsp100"
model_key_e="ntok0"
output_folder="${eval_folder}/${model_key_s}_${dataset}"
ckpt_path_template="outputs/${model_key_s}rf{v}${model_key_e}/checkpoint.best_loss_*.pt"
splits=("test_black_white" "test_dark_light" "test_man_woman" "test_male_female")
prompts=("the speaker is describing a person in" "the speaker is describing a person in" "the speaker is describing a" "the speaker is describing a")
ckpt_path_variables=(2 4 8 16)
for ckpt_path_variable in  "${ckpt_path_variables[@]}"; do
    echo ckpt_path_variable: ${ckpt_path_variable}
    for i in "${!all_scenarios[@]}"; do
        all_scena="${all_scenarios[$i]}"
        echo split ${splits[$i]}
        if [ ! -z ${splits[$i]} ]; then
            split=${splits[$i]}
            prompt=${prompts[$i]}
        fi
        model_key="${model_key_s}rf${ckpt_path_variable}${model_key_e}"
        hyp_manifest_dir=${transcript_folder}/${model_key}/${dataset}
        mkdir -p ${hyp_manifest_dir}
        hyp_split=${scena}
        echo $all_scena $split $prompt ${ckpt_path_template} model_key: ${model_key}
        if [ "${PARALLEL}" = "true" ]; then
            echo evaluate parallelly echo ${PARALLEL}
            (eval "${manifest_dir}" "${split}" "${all_scena}" "${ckpt_path_template}" "${ckpt_path_variable}" "${stage}" "${output_folder}" "${prompt}" "${hyp_manifest_dir}") &
            pids+=($!)
        else
            eval "${manifest_dir}" "${split}" "${all_scena}" "${ckpt_path_template}" "${ckpt_path_variable}" "${stage}" "${output_folder}" "${prompt}" "${hyp_manifest_dir}"
        fi
    done
done
i=0; for pid in "${pids[@]}"; do wait ${pid} || ((++i)); done
[ ${i} -gt 0 ] && echo "$0: ${i} background jobs are failed." && false
echo "Run completed at:- "
date
