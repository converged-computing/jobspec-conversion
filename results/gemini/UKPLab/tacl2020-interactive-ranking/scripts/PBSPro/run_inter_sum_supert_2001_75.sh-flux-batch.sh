#!/bin/sh

# Flux directives
#FLUX: -N 1                                      # Number of nodes
#FLUX: -n 1                                      # Number of tasks (total for the job, script itself is one task)
#FLUX: -c 24                                     # CPUs per task (for the script's main task)
#FLUX: --mem=128G                                # Memory for the job (128GB total, allocated to the single node)
#FLUX: -t 72:00:00                               # Walltime (HH:MM:SS)
#FLUX: -J intsum_s75_01                          # Job name
#FLUX: -o pbs_intersumsup2001_75_output.log      # Standard output file
#FLUX: -e pbs_intersumsup2001_75_err.log      # Standard error file

# Set OpenMP environment variable
# The PBS 'ompthreads=24' directive and 'ncpus=24' request imply the job expects to use 24 threads.
export OMP_NUM_THREADS=24

# Load required modules
module load lang/python/anaconda/pytorch

# We might need to add the global paths to our code to the pythonpath. Also set the data directories globally.
# (Original comment retained for context, though PYTHON PATH modification is not present in the script)
cd /work/es1595/text_ranking_bayesian_optimisation

# Run the script using heuristics only and no interactions.

echo "Job started: $(date)"
echo "Running on node(s): $(hostname)" # In Flux, hostname might just give the lead broker node; `flux resource list` gives allocated nodes.
echo "OMP_NUM_THREADS set to: $OMP_NUM_THREADS"
echo "Working directory: $(pwd)"

# Run the script for each DUC dataset with GPPL-IMP, GPPL-UNPA, GPPL-EIG, GPPL-Random, BT-Random.
echo "Starting python script: GPPLHH with [eig]..."
python -u stage1_active_pref_learning.py GPPLHH 0 duc01_supert_bi_eig_gpplhh_75 "[eig]" . 4 DUC2001 75 supert 200 0.5 results_ls05 1
echo "Finished GPPLHH with [eig]."

echo "Starting python script: GPPLHH with [imp]..."
python -u stage1_active_pref_learning.py GPPLHH 0 duc01_supert_bi_imp_gpplhh_75 "[imp]" . 4 DUC2001 75 supert 200 0.5 results_ls05 1
echo "Finished GPPLHH with [imp]."

echo "Starting python script: LR with [random,unc]..."
python -u stage1_active_pref_learning.py LR     0 duc01_supert_bi_ran_lr_75     "[random,unc]" . 4 DUC2001 75 supert 200 0.5 results_ls05 1
echo "Finished LR with [random,unc]."

echo "Starting python script: GPPLHH with [random]..."
python -u stage1_active_pref_learning.py GPPLHH 0 duc01_supert_bi_ran_gpplhh_75 "[random]" . 4 DUC2001 75 supert 200 0.5 results_ls05 1
echo "Finished GPPLHH with [random]."

echo "All Python scripts completed: $(date)"