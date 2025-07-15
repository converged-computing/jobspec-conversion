#!/bin/bash
#FLUX: --job-name=chocolate-omelette-2337
#FLUX: --urgency=16

%%sbatch_args%%
%%venv%%
%%pythonpath%%
%%sh_lines%%
python3 %%python_script%% %%path_to_yaml_config%% -j $SLURM_ARRAY_TASK_ID %%cw_args%%
