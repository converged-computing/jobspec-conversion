#!/usr/bin/env python3

import argparse
import fnmatch
import gc
import hashlib
import json
import os
import random

import IPython
import torch
from torch.utils.data import DataLoader, Dataset
from transformers import AutoModelForCausalLM, AutoTokenizer

here = os.path.dirname(os.path.abspath(__file__))

pbs_example_input = """#!/bin/sh
#PBS -l select=8:ncpus=4:mpiprocs=4
#PBS -l place=excl:scatter
#PBS -N test-petsc
#PBS -l walltime=1:00:00

cd /home/virtualheart/gplank/carp_user_execs/queeg/
mpirun -np 32 -m $PBS_NODEFILE \ /home/virtualheart/gplank/carp_user_execs/queeg/martin.bishop/carp.linux.petsc \
+F /home/virtualheart/gplank/carp_user_execs/queeg/parameters.par \
-meshname testimage_renum \
-simID /home/virtualheart/gplank/carp_user_execs/queeg/
"""

pbs_example_output = """```json
{
     "application":"carp",
     "resources":{
        "num-nodes":"8",
        "num-tasks":"32",
        "cpus-per-task":"1",
        "placement":"exclusive,scatter",
        "time":"1:00:00"
    }
}
```
    This is the corresponding Flux batch job:
```
        #flux: -N8
        #flux: -n32
        #flux: -t 1h
        #flux: --job-name=test-petsc

        cd /home/virtualheart/gplank/carp_user_execs/queeg/
        flux run -N8 -n32 /home/virtualheart/gplank/carp_user_execs/queeg/martin.bishop/carp.linux.petsc \
        +F /home/virtualheart/gplank/carp_user_execs/queeg/parameters.par \
        -meshname testimage_renum \
        -simID /home/virtualheart/gplank/carp_user_execs/queeg/
```
"""

lsf_example_input = """#!/bin/bash

#BSUB -P BIE108
#BSUB -q batch-hm
#BSUB -W 00:10
#BSUB -nnodes 2
#BSUB -J wd_test_hm
#BSUB -o /ccs/home/pstjohn/job_output/%J.out
#BSUB -e /ccs/home/pstjohn/job_output/%J.err

BATCH_SIZE=$(($NODES * 6 * 24))

module load ibm-wml-ce/1.7.0-3
conda activate tf21-ibm
export PYTHONPATH=$HOME/uniparc_modeling:$PYTHONPATH
export NCCL_DEBUG=INFO
export TF_ENABLE_AUTO_MIXED_PRECISION=1
export OMP_NUM_THREADS=4

mkdir -p  $MEMBERWORK/bie108/$LSB_JOBNAME/$LSB_JOBID
cd  $MEMBERWORK/bie108/$LSB_JOBNAME/$LSB_JOBID
cp $HOME/uniparc_modeling/run_model_wd_at.py .

jsrun -n 2 -g 6 -c 42 -r1 -a1 -b none python run_model_wd_at.py \
    --modelName=$LSB_JOBNAME.$LSB_JOBID \
    --scratchDir="$MEMBERWORK/bie108/uniparc_checkpoints" \
    --dataDir="$PROJWORK/bie108/split_uniref100" \
    --checkpoint="/gpfs/alpine/scratch/pstjohn/bie108/12_layer_relative_adam_20200625.185237/" \
    --batchSize=$BATCH_SIZE \
    --warmup=25 \
    --totalSteps=100 \
    --stepsPerEpoch=10 \
    --validationSteps=10 \
    --lr=1E-4 \
    --maskingFreq=0.05 \
    --sequenceLength=1024 \
    --modelDimension=768 \
    --numberXformerLayers=12 \
    --attentionType='relative' \
    --weightDecay='false' \
    --initialEpoch=0
"""

lsf_example_output = """```json
{
     "application":"run_model_wd_at.py",
     "environment:"{
        "module":"ibm-wml-ce/1.7.0-3",
        "conda":"tf21-ibm",
        "env":"PYTHONPATH=$HOME/uniparc_modeling:$PYTHONPATH",
        "env":"NCCL_DEBUG=INFO",
        "env":"TF_ENABLE_AUTO_MIXED_PRECISION=1",
        "env":"OMP_NUM_THREADS=4"
     },
     "resources":{
        "num-nodes":"2",
        "num-tasks":"2",
        "num-gpus":"12",
        "num-cpus":"84",
        "num-resource-sets":"2",
        "num-tasks-per-resource-set":"1",
        "num-cpus-per-resource-set":"42",
        "num-gpus-per-resource-set":"6",
        "num-resource-sets-per-node":"1",
        "cpus-per-task":"42",
        "placement":"exclusive,scatter",
        "time":"0:10:00"
     }
}
```
    This is the corresponding Flux batch job:
```
    #flux: -N2
    #flux: -n2
    #flux: -g6
    #flux: -c 42
    #flux: -t 10m
    #flux: -q batch-hm
    #flux: --job-name=wd_test_hm
    #flux: --output=/ccs/home/pstjohn/job_output/{{jobid}}.out
    #flux: --error=/ccs/home/pstjohn/job_output/{{jobid}}.err

    BATCH_SIZE=$(($NODES * 6 * 24))

    module load ibm-wml-ce/1.7.0-3
    conda activate tf21-ibm
    export PYTHONPATH=$HOME/uniparc_modeling:$PYTHONPATH
    export NCCL_DEBUG=INFO
    export TF_ENABLE_AUTO_MIXED_PRECISION=1
    export OMP_NUM_THREADS=4

    mkdir -p  $MEMBERWORK/bie108/$LSB_JOBNAME/$LSB_JOBID
    cd  $MEMBERWORK/bie108/$LSB_JOBNAME/$LSB_JOBID
    cp $HOME/uniparc_modeling/run_model_wd_at.py .

    flux run -n 2 -N 2 -g 6 -c 42 python run_model_wd_at.py \
    --modelName=$LSB_JOBNAME.$LSB_JOBID \
    --scratchDir="$MEMBERWORK/bie108/uniparc_checkpoints" \
    --dataDir="$PROJWORK/bie108/split_uniref100" \
    --checkpoint="/gpfs/alpine/scratch/pstjohn/bie108/12_layer_relative_adam_20200625.185237/" \
    --batchSize=$BATCH_SIZE \
    --warmup=25 \
    --totalSteps=100 \
    --stepsPerEpoch=10 \
    --validationSteps=10 \
    --lr=1E-4 \
    --maskingFreq=0.05 \
    --sequenceLength=1024 \
    --modelDimension=768 \
    --numberXformerLayers=12 \
    --attentionType='relative' \
    --weightDecay='false' \
    --initialEpoch=0

```
"""


oar_example_input = """#!/bin/bash
#OAR -n mixture-nanopore
#OAR -l /nodes=1/gpu=1/cpu=1/core=8,walltime=48:00:00
#OAR -p gpumodel='A100'
#OAR --stdout log.out
#OAR --stderr log.err
#OAR --project tamtam

export GMX_MAXBACKUP=-1

gmx=/home/gravells/softwares/gromacs-2023/build-gpu/bin/gmx

#${gmx} grompp -f ../input/nvt.mdp -p topol.top -o nvt -pp nvt -po nvt -r conf.gro
#${gmx} mdrun -deffnm nvt -v -rdd 1 -nt 8 -pin on
#cp nvt.gro conf.gro

${gmx} grompp -f ../input/npt.mdp -p topol.top -o npt -pp npt -po npt -r conf.gro -maxwarn 2
${gmx} mdrun -deffnm npt -v -rdd 1 -nt 8 -pin on
cp npt.gro conf.gro
"""

oar_example_output = """```json
{
     "application":"gmx",
     "environment:"{
        "env":"gmx=/home/gravells/softwares/gromacs-2023/build-gpu/bin/gmx",
        "env":"GMX_MAXBACKUP=-1"
     },
     "resources":{
        "num-nodes":"1",
        "num-tasks":"8",
        "cpus":"1",
        "gpus":"1",
        "cores":"8",
        "gpu-type":"A100",
        "time":"48:00:00"
    }
}
```
This is the corresponding Flux batch job:
```
    #flux: -N1
    #flux: -n8
    #flux: -g1
    #flux: -t 48h
    #flux: --job-name=mixture-nanopore

    export GMX_MAXBACKUP=-1

    gmx=/home/gravells/softwares/gromacs-2023/build-gpu/bin/gmx

    #${gmx} grompp -f ../input/nvt.mdp -p topol.top -o nvt -pp nvt -po nvt -r conf.gro
    #${gmx} mdrun -deffnm nvt -v -rdd 1 -nt 8 -pin on
    #cp nvt.gro conf.gro

    ${gmx} grompp -f ../input/npt.mdp -p topol.top -o npt -pp npt -po npt -r conf.gro -maxwarn 2
    ${gmx} mdrun -deffnm npt -v -rdd 1 -nt 8 -pin on
    cp npt.gro conf.gro

```
"""

cobalt_example_input = """#!/bin/bash
#COBALT -n 1
#COBALT -t 00:10:00
#COBALT -q training
#COBALT -A SDL_Workshop

CONTAINER=/lus/theta-fs0/software/thetagpu/nvidia-containers/tensorflow2/tf2_20.08-py3.simg
SCRIPT=/home/rmaulik/sdl_ai_workshop/05_Simulation_ML/ThetaGPU/queue_submission.sh

echo "Running Cobalt Job $COBALT_JOBID."
mpirun -n 1 -npernode 1 -hostfile $COBALT_NODEFILE singularity run --nv -B /lus:/lus $CONTAINER $SCRIPT
"""

cobalt_example_output = """```json
{
     "application":"tensorflow2",
     "environment:"{
        "env":"CONTAINER=/lus/theta-fs0/software/thetagpu/nvidia-containers/tensorflow2/tf2_20.08-py3.simg",
        "env":"SCRIPT=/home/rmaulik/sdl_ai_workshop/05_Simulation_ML/ThetaGPU/queue_submission.sh"
     },
     "resources":{
        "num-nodes":"1",
        "num-tasks":"1",
        "tasks-per-node":"1",
        "time":"00:10:00"
    }
}
```
This is the corresponding Flux batch job:
```
    #flux: -N1
    #flux: -n1
    #flux: -q training
    #flux: -t 10m
    #flux: --job-name=SDL_Workshop

    CONTAINER=/lus/theta-fs0/software/thetagpu/nvidia-containers/tensorflow2/tf2_20.08-py3.simg
    SCRIPT=/home/rmaulik/sdl_ai_workshop/05_Simulation_ML/ThetaGPU/queue_submission.sh

    echo "Running Flux Job {{jobid}}."
    flux run -N 1 -n 1 singularity run --nv -B /lus:/lus $CONTAINER $SCRIPT
```
"""


def build_dataloaders(dataset, batch_size, shuffle=False, num_workers=0):
    """
    Returns a dataloader object

    param: dataset: dataset object
    param: batch_size: number of samples per batch
    param: num_workers: how many subprocesses to use for data loading
    """
    dl = DataLoader(
        dataset, batch_size=batch_size, shuffle=shuffle, num_workers=num_workers
    )
    return dl


class JobspecDataset(Dataset):

    def __init__(
        self,
        file_list,
        prompt,
        prompt_per_rm=False,
        example_prompt=None,
        example_input=None,
        example_output=None,
    ):
        """
        param: path_to_data: path to the jobspec dataset
        param: prompt: text to prompt the model
        param: input_text: single input example for one-shot prompting
        param: output_text: single output example for one-shot prompting
        """
        self.files = file_list  # list to store paths to job scripts
        self.prompt_per_rm = prompt_per_rm
        self.prompt = prompt
        self.example_prompt = example_prompt
        self.example_input = example_input
        self.example_output = example_output

    def __len__(self):
        return len(self.files)

    def __getitem__(self, idx):
        # 0: filename, 1: ccn, 2: body
        filename = self.files[idx][0]
        ccn = self.files[idx][1]
        text = self.files[idx][2]

        # Preprocess text for one-shot prompting
        if (
            self.example_input is not None
            and self.example_output is not None
            and self.example_prompt is not None
        ):
            text = self.preprocess_one_shot(text)
        else:  # preprocess text for zero-shot prompting
            text = self.preprocess_zero_shot(text)
        return filename, ccn, text

    def preprocess_one_shot(self, text):
        """
        Creates an input prompt using one-shot inference

        :param example_prompt: str example instruction for the llm
        :param example_input: str example job script
        :param example_output: str example expected output
        :param prompt: str input instruction for the llm
        :param text: str input job script

        :return str input for llm
        """
        if self.prompt_per_rm:
            if "#PBS" in text:
                ex_input = pbs_example_input
                ex_output = pbs_example_output
            elif "#LSF" in text:
                ex_input = lsf_example_input
                ex_output = lsf_example_output
            elif "#OAR" in text:
                ex_input = oar_example_input
                ex_output = oar_example_output
            elif "#COBALT" in text:
                ex_input = cobalt_example_input
                ex_output = cobalt_example_output
            else:
                ex_input = self.example_input
                ex_output = self.example_output
        else:
            ex_input = self.example_input
            ex_output = self.example_output

        input_prompt = (
            f"<s>[INST]{self.example_prompt}\n"
            f"{ex_input}[/INST]\n"
            f"{ex_output}</s>\n"
            f"[INST]{self.prompt}\n"
            f"{text}[/INST]\n"
        )
        return input_prompt

    def preprocess_zero_shot(self, text):
        """
        Creates an zero-shot input prompt

        :param prompt: str input instruction for the llm
        :param text: str input job script
        :return str input for llm
        """

        input_prompt = f"<s>[INST]{self.prompt}\n" f"{text}[/INST]</s>\n"

        return input_prompt


def generate(model, tokenizer, input_texts, device, kwargs_generate):
    """
    Run inference and generate LLM text

    :param model: llm model object
    :param tokenizer: tokenizer object
    :param input_text: list of texts
    :param device: cpu or cuda
    :param kwargs_generate: dict of kw arguments for the generate function
    """
    # Pad sequences to match longest sequence in a batch
    inputs = tokenizer(
        input_texts, return_tensors="pt", add_special_tokens=False, padding=True
    )

    # move inputs to device
    inputs = inputs.to(device)

    # LLM text-generated output
    outputs = model.generate(**inputs, **kwargs_generate)

    new_tokens_idx = inputs.input_ids.shape[1]  # get the shape of input str
    new_outputs = outputs[:, new_tokens_idx:]  # access new tokens only
    generated_text = tokenizer.batch_decode(
        new_outputs, skip_special_tokens=True
    )  # decode tokens to words
    del inputs
    del outputs
    gc.collect()
    torch.cuda.empty_cache()
    torch.cuda.reset_peak_memory_stats()

    return generated_text


# Helper functions
def read_file(filename):
    with open(filename, "r") as fd:
        content = fd.read()
    return content


def recursive_find(base, pattern="*", max_files=None):
    count = 0
    for root, _, filenames in os.walk(base):
        for filename in fnmatch.filter(filenames, pattern):
            yield os.path.join(root, filename)
            count += 1
            if max_files is not None and count > max_files:
                return


def content_hash(filename):
    with open(filename, "rb", buffering=0) as f:
        return hashlib.file_digest(f, "sha256").hexdigest()


def write_file(content, filename):
    with open(filename, "w") as fd:
        fd.write(content)


def write_json(obj, filename):
    with open(filename, "w") as fd:
        fd.write(json.dumps(obj, indent=4))


def run_mistral(
    model_name,
    batch_size,
    output_file,
    oneshot,
    min_ccn,
    max_ccn,
    max_chars,
    max_files,
    prompt_per_rm,
    indir,
):

    # Read in the jobspecs
    print(f"\nLooking for files in {indir}")

    # Add some buffer to max files in case duplicates
    contenders = list(recursive_find(indir, max_files=max_files))

    seen = set()
    files = []
    for filename in contenders:
        digest = content_hash(filename)
        if digest in seen:
            continue
        seen.add(digest)
        files.append(filename)

    print(f"Number of preprocessed files {len(contenders)}")
    print(f"Number of postprocessed files {len(files)}")

    example_jobspec = read_file(random.choice(files))
    print(example_jobspec)

    example_output = """```json
    {
         "application":"vasp_stand",
         "environment:"{
            "module":"intel/2019.1.144",
            "module":"openmpi/4.0.1"
         },
         "resources":{
            "num-nodes":"1",
            "num-tasks":"16",
            "cpus-per-task":"1",
            "mem":"16G",
            "mem-per-cpu":"1000mb",
            "time":"6:00:00"
        }
    }
    ```
    This is the corresponding Flux batch job:
    ```
    #flux: --job-name=1163
    #flux: -N1
    #flux: -n16
    #flux: -t 6h
    #flux: -c 1
    #flux: --output=out_{{jobid}}.log
    #flux: --error=err_{{jobid}}.log

    cd $FLUX_JOB_TMPDIR

    module purge
    module load intel/2019.1.144
    module load openmpi/4.0.1

    flux run -N 1 -n 16 /home/joshuapaul/vasp_10-23-19_5.4.4/bin/vasp_stand > job.log
    echo Done
    ```
    """
    model = AutoModelForCausalLM.from_pretrained(model_name, torch_dtype="auto")

    tokenizer = AutoTokenizer.from_pretrained(
        model_name, torch_dtype="auto", padding_side="left"
    )
    tokenizer.pad_token = tokenizer.eos_token

    prompt = (
        "Extract the application name and details "
        "about software, environment, time, and resource "
        "requirements from the script below. "
        "Required resource keys are 'num-nodes', "
        "'num-tasks', and 'time'.",
        "Please provide a response in a structured JSON "
        "followed by a correctly formatted Flux batch job "
        "script.",
    )

    print(f"One-shot prompt? {oneshot}")
    if oneshot:
        example_prompt = (
            "This is an example of a job script "
            "which specifies information about "
            "the application to be run as well as "
            "its environment and resource requirements. "
            "The following examples are a structured JSON example "
            "of the application name, software, "
            "resource requirements, and time requirements "
            "correctly extracted from the job script. The "
            "second example is the job script translated "
            "into a Flux batch job script: "
        )
        dataset = JobspecDataset(
            files,
            prompt=prompt,
            prompt_per_rm=prompt_per_rm,
            example_prompt=example_prompt,
            example_input=example_jobspec,
            example_output=example_output,
        )
    else:
        dataset = JobspecDataset(files, prompt=prompt)

    print(f"Dataset len: {len(dataset)}")
    print(f"Batch size: {batch_size}")

    dl = build_dataloaders(dataset, batch_size=batch_size, shuffle=False)

    print(f"Number of batches: {len(dl)}")

    if torch.cuda.is_available():
        device = "cuda"
    else:
        device = "cpu"

    print(device)
    model.to(device)
    print("Running generation")

    # top-k based generation
    generate_params = {
        "max_new_tokens": 1000,  # number of new tokens to generate
        "top_k": 50,  # K most likely words for sampling
        "top_p": 0.95,  # smallest set of words whose probability exceeds top_p
        "temperature": 0.8,  # increase likelihood of high-probability words. If 0, then greedy search
        "do_sample": True,
    }

    # Breaking in the first batch for testing
    # I'm running into out of memory errors, possibly due to sequence padding
    # Need to test in a GPU with bigger memory

    # Iterate over batches of data
    for idx, texts in enumerate(dl):
        # We don't have ccn here
        input_texts = [t for t in texts[2]]

        # Just testing?
        if idx > max_files:
            break

        generated_text = generate(
            model,
            tokenizer,
            input_texts=input_texts,
            device=device,
            kwargs_generate=generate_params,
        )
        print(generated_text)
        gc.collect()
        torch.cuda.empty_cache()
        torch.cuda.reset_peak_memory_stats()


def main():
    parser = get_parser()
    args = parser.parse_args()
    run_mistral(
        args.model,
        args.batch_size,
        args.output_file,
        args.oneshot,
        args.min_ccn,
        args.max_ccn,
        args.max_chars,
        args.max_files,
        args.prompt_per_rm,
        args.input,
    )


def get_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument("--model", help="name of Mistral model to use")
    parser.add_argument("--batch-size", type=int, default=2, help="model batch size")
    parser.add_argument(
        "--input",
        default="/p/vast1/fractale/descriptive-thrust/Src_fractale_de/jobspec-db/data",
        help="Input directory",
    )
    parser.add_argument(
        "--output-file",
        default="model-test.csv",
        help="output CSV file; defaults to model-test.csv",
    )
    parser.add_argument(
        "--oneshot", action="store_true", help="Perform one-shot prompt?"
    )
    parser.add_argument(
        "--max-ccn",
        type=float,
        default=5.0,
        help="max cyclomatic complexity allowed for script inference",
    )
    parser.add_argument(
        "--min-ccn",
        type=float,
        default=0.0,
        help="min cyclomatic complexity allowed for script inference",
    )
    parser.add_argument(
        "--max-chars",
        type=int,
        default=16000,
        help="max number of jobspec characters allowed for script inference",
    )
    parser.add_argument(
        "--max-files",
        type=int,
        default=10000,
        help="max number of files used for inference",
    )
    parser.add_argument(
        "--prompt-per-rm",
        action="store_true",
        help="generate one-shot prompt based on the resource manager corresponding to the script",
    )
    return parser


if __name__ == "__main__":
    main()
