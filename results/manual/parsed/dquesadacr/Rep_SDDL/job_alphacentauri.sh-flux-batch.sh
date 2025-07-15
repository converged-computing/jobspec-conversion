#!/bin/bash
#FLUX: --job-name=expensive-onion-4470
#FLUX: -t=14400
#FLUX: --urgency=16

module --force purge
mkdir -p V-"$1"_d-"$3"/Data/precip V-"$1"_d-"$3"/models/precip
cp -n Data/precip/y_OEG.rda V-"$1"_d-"$3"/Data/precip/
cp -n Data/precip/x_32.rda V-"$1"_d-"$3"/Data/precip/
cp -n sing_run.sh V-"$1"_d-"$3"/
cp -n train_scripts/OEG_cnn_$1.R V-"$1"_d-"$3"/
cp -n parse_aux/unet_def.R V-"$1"_d-"$3"/
cp -n parse_aux/aux_funs_train.R V-"$1"_d-"$3"/
nvidia-modprobe -u -c=0
singularity exec --nv -B V-"$1"_d-"$3"/:/data Rep_SDDL.sif bash /data/sing_run.sh $1 $2 $3 $4
mkdir -p val_hist/V-"$1"_d-"$3"/$4/
cp V-"$1"_d-"$3"/Data/precip/$4/validation_CNN* val_hist/V-"$1"_d-"$3"/$4/
cp V-"$1"_d-"$3"/Data/precip/$4/hist_train_CNN* val_hist/V-"$1"_d-"$3"/$4/
