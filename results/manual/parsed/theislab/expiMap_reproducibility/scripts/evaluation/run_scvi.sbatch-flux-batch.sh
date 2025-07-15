#!/bin/bash
#FLUX: --job-name=quirky-milkshake-8929
#FLUX: --urgency=15

source $HOME/.bashrc
source activate work-gpu
python  $HOME/integr/run_scvi.py /storage/groups/ml01/workspace/sergei.rybakov/data_integr/lung_travaglini_preproc.h5ad tech_sample
python  $HOME/integr/run_scvi.py /storage/groups/ml01/workspace/sergei.rybakov/data_integr/liver_popescu_preproc.h5ad orig.ident
python  $HOME/integr/run_scvi.py /storage/groups/ml01/workspace/sergei.rybakov/data_integr/colon_smilie_preproc.h5ad Source
python  $HOME/integr/run_scvi.py /storage/groups/ml01/workspace/sergei.rybakov/data_integr/blood_azimuth_preproc.h5ad donor
python  $HOME/integr/run_scvi.py /storage/groups/ml01/workspace/sergei.rybakov/data_integr/heart_scvi_preproc.h5ad cell_source
