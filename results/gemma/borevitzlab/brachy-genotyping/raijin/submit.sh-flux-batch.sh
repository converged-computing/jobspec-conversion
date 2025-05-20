#!/bin/bash
# Flux batch script

# Resource requests
# Flux uses a single -n flag for total resources.  We infer nodes from the requested cpus.
# Assuming 28 cpus per node, we request 1 node.  Adjust if needed.
# Flux handles memory requests with --mem-per-cpu.  We convert 126G to GB per CPU.
# Flux doesn't have a direct equivalent to jobfs, so we omit it.
# Flux doesn't have a direct equivalent to 'wd' (working directory), it's implicit.
# Flux doesn't have a direct equivalent to 'other'

# Set log directory
logdir=raijin/log

# Create log directory if it doesn't exist
mkdir -p $logdir

# Archive existing logs
if [ -d $logdir ]; then
  pushd $logdir >/dev/null
  if [ -n "$(ls *.ER *.OU 2>/dev/null)" ]; then
    tar cf `date +%y%m%d_%H%M%S`.tar *.OU *.ER 2>/dev/null
    rm *.OU *.ER
  fi
  popd >/dev/null
fi

# Load modules
. raijin/modules.sh

# Snakemake command
snakemake                                \
    -j 500                               \
    --cluster-config raijin/cluster.yaml \
    --js raijin/jobscript.sh             \
    --local-cores 16                     \
    --rerun-incomplete                   \
    --keep-going                         \
    --cluster "flux run -n 28 --mem-per-cpu=4.5G" \
   all                                   \
   >raijin/log/snakemake.log
```
Key changes and explanations:

*   **Job Manager Identification:** The script clearly uses PBS/Torque directives (`#PBS`).
*   **Resource Translation:**
    *   `ncpus=28` in PBS is translated to `flux run -n 28`.  Flux uses `-n` to specify the total number of resources (typically cores).
    *   `mem=126G` is translated to `--mem-per-cpu=4.5G` (126GB / 28 cores = 4.5GB/core). Flux requires memory to be specified per CPU.
    *   `jobfs=100G` and `other=gdata1, wd` have no direct equivalents in Flux and are omitted.  Flux assumes a working directory and doesn't have a specific filesystem quota option.
    *   `walltime=24:00:00` is not directly specified in the Flux script. Flux relies on the system administrator to enforce time limits.
*   **`--cluster` Argument:** The `--cluster` argument in Snakemake is modified to use the `flux run` command with the appropriate resource requests.
*   **Module Loading:** The `raijin/modules.sh` script is retained as it's likely responsible for setting up the environment.
*   **Log Handling:** The log directory creation and archiving logic are preserved.
*   **Complexity Score:** The original script is moderately complex due to the resource requests, log handling, and the use of Snakemake's cluster features.  The Flux version is slightly simpler because some features are not directly translatable.
*   **Node Inference:** The Flux script assumes 28 cores per node.  This is a common configuration, but you should adjust the `-n` value if your system has a different core count per no