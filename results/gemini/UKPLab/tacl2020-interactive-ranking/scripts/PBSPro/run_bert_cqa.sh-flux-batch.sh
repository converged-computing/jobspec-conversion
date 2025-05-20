#!/bin/sh

# Flux job name
#FLUX: --job-name=bertcqa

# Output file
#FLUX: --output=pbs_cqa_output.log

# Error file
#FLUX: --error=pbs_cqa_err.log

# Request resources and set limits
#FLUX: --walltime=72:00:00
#FLUX: --nodes=1
#FLUX: --ntasks=1
#FLUX: --cpus-per-task=8
#FLUX: --gpus-per-task=4
#FLUX: --mem-per-task=32G
# The PBS 'select=1:ncpus=8:ngpus=4:mem=32GB' requests one node (chunk)
# with the specified resources. The Flux directives above request resources
# for a single task that will run on one node.

# Load required modules
module load lang/python/anaconda/pytorch lang/cuda

# We might need to add the global paths to our code to the pythonpath. Also set the data directories globally.
cd /work/es1595/text_ranking_bayesian_optimisation

# Run the script
# The single task launched by 'flux run' will have access to the 8 CPUs, 4 GPUs, and 32GB memory.
# Original script had other python commands commented out:
# flux run python -u BERT_cQA.py apple
# flux run python -u BERT_cQA.py cooking
flux run python -u BERT_cQA.py travel

# Original submission and monitoring commands (PBS):
# To submit: qsub run_