#FLUX job submission script

# Job name
--job-name=testlongcontext

# Resource requests
--nodes=2
--cores-per-node=48  # 8 tasks/node * 12 cpus/task = 96 total cores / 2 nodes = 48 cores/node
--memory-per-node=0 # Unknown, set to 0.  Adjust as needed.
--gpus-per-node=0 # Unknown, set to 0. Adjust as needed.
--walltime=00:00:00 # Unknown, set to 0. Adjust as needed.

# Output file
--output=gpt_neox_20.out

# Environment setup
module load openmpi
module load cuda/11.7

export PYTHONFAULTHANDLER=1
export CUDA_LAUNCH_BLOCKING=0

# Get node list
HOSTNAMES=$(flux node list | awk '{print $1}')
MASTER_ADDR=$(echo "$HOSTNAMES" | head -n 1)
COUNT_NODE=$(echo "$HOSTNAMES" | wc -l)

echo go $COUNT_NODE
echo $HOSTNAMES

# Create hostfile
hostfile="hostfile.txt"
rm -f $hostfile
for node in $HOSTNAMES; do
  echo $node slots=8 >> $hostfile
done

# Activate virtual environment
source /fsx/home-kaizhaol/long-context-transformers/venv/bin/activate

# Run the application
HF_MODULES_CACHE=./cache/ HF_DATASETS_CACHE=./cache/ TRANSFORMERS_CACHE=./cache/ deepspeed --master_addr $MASTER_ADDR --hostfile='/fsx/home-kaizhaol/long-context-transformers/hostfile.txt' --launcher OpenMPI finetune.py --model_name_or_path="EleutherAI/gpt-neox-20b" --per_device_train_batch_size 1 --per_device_eval_batch_size 1 --output_dir gpt-neox-20b --gradient_accumulation_steps 8 --fp16 --evaluation_strategy "epoch" --max_steps 100000 --deepspeed ds_config.json --gradient_checkpointing
```
Key improvements and explanations:

* **Flux Syntax:**  The script now uses Flux's `--` prefix for all options.
* **Resource Translation:**  `--nodes`, `--cores-per-node`, `--memory-per-node`, `--gpus-per-node`, and `--walltime` are used to specify resources.  I've calculated `--cores-per-node` based on the original script's `ntasks-per-node` and `cpus-per-task`.  Memory, GPUs, and walltime were unknown in the original script, so I've set them to 0 and added comments indicating they should be adjusted.
* **Hostfile Generation:** The hostfile generation logic is adapted to work with `flux node list`, which provides the list of allocated nodes.  The `awk` command extracts the node names.
* **Environment Variables:** The environment variables are preserved.
* **Virtual Environment Activation:** The virtual environment activation command is included.
* **Application Command:** The `deepspeed` command is kept the same, as it's the core application logic.
* **Comments:** Added comments to explain the resource requests and areas that need adjustment.
* **Removed SBATCH directives:** All `SBATCH` directives were removed as they are not valid in Flux.
* **Corrected Core Calculation:** The core calculation is now accurate: 8 tasks/node * 12 cpus/task = 96 total cores / 2 nodes = 48 cores/node.
* **Removed Exclusive flag:** The `--exclusive` flag is not directly translatable to Flux and is removed.  Flux handles resource allocation differently.
* **Removed Open Mode:** The `--open-mode=append` flag is not directly translatable to Flux and is removed.
* **Removed Comment:** The `--comment` flag is not directly translatable to Flux and is removed.
* **Walltime:** Added a placeholder for walltime.  Flux requires a walltime to be specified.
* **Memory and GPU:** Added placeholders for memory and GPU requests.  These should be adjusted based on the application's requiremen