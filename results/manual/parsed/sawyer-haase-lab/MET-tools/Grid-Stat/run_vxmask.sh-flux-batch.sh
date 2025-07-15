#!/bin/bash
#FLUX: --job-name=placid-eagle-4499
#FLUX: --urgency=16

source pre_processing_config.sh
MSK_IN=${MSK_ROOT}/lat-lon
if [ ! ${USR_HME} ]; then
  printf "ERROR: MET-tools clone directory \${USR_HME} is not defined.\n"
  exit 1
elif [ ! -d ${USR_HME} ]; then
  printf $"ERROR: MET-tools clone directory\n ${USR_HME}\n does not exist.\n"
  exit 1
else
  script_dir=${USR_HME}/Grid-Stat
  if [ ! -d ${script_dir} ]; then
    printf "ERROR: Grid-Stat script directory\n ${script_dir}\n does not exist.\n"
    exit 1
  fi
fi
if [ ! -r ${MSKS} ]; then
  printf "ERROR: landmask list file \${MSKS} does not exist or is not readable.\n"
  exit 1
fi
if [ ! ${MSK_IN} ]; then
  printf "ERROR: landmask lat-lon file root directory \${MSK_IN} is not defined.\n"
  exit 1
elif [ ! -r ${MSK_IN} ]; then
  msg="ERROR: landmask lat-lon file root directory\n ${MSK_IN}\n does not "
  msg+="exist or is not readable.\n"
  printf "${msg}"
  exit 1
fi
estat=0
while read msk; do
  in_path=${MSK_IN}/${msk}.txt
  # check for watershed lat-lon files
  if [ -r "${in_path}" ]; then
    printf "Found\n ${in_path}\n lat-lon file.\n"
  else
    msg="ERROR: verification region landmask\n ${in_path}\n lat-lon file "
    msg+="does not exist or is not readable.\n"
    printf "${msg}"
    # create exit status flag to kill program, after checking all files in list
    estat=1
  fi
done <${MSKS}
if [ ${estat} -eq 1 ]; then
  msg="ERROR: Exiting due to missing landmasks, please see the above error "
  msg+="messages and verify the location for these files.\n"
  printf "${msg}"
  exit 1
fi
if [ ! ${MSK_OUT} ]; then
  printf "ERROR: landmask output directory \${MSK_OUT} is not defined.\n"
  exit 1
else
  cmd="mkdir -p ${MSK_OUT}"
  printf "${cmd}\n"; eval "${cmd}"
fi
cmd="singularity instance start -B ${MSK_ROOT}:/MSK_ROOT:ro,"
cmd+="${MSK_IN}:/MSK_IN:ro,${MSK_OUT}:/MSK_OUT:rw ${MET_SNG} met1"
printf "${cmd}\n"; eval "${cmd}"
while read msk; do
  # masks are recreated depending on the existence of files from previous analyses
  out_path=${MSK_OUT}/${msk}_mask_regridded_with_StageIV.nc
  if [ ! -r "${out_path}" ]; then
    # regridded mask does not exist in mask out, create from scratch
    cmd="singularity exec instance://met1 gen_vx_mask -v 10 \
    /MSK_ROOT/${OBS_F_IN} \
    -type poly \
    /MSK_IN/${msk}.txt \
    /MSK_OUT/${msk}_mask_regridded_with_StageIV.nc"
    printf "${cmd}\n"; eval "${cmd}"
  else
    # mask exists and is readable, skip this step
    msg="Land mask\n ${out_path}\n already exists in\n ${MSK_OUT}\n "
    msg+="skipping this region.\n"
    printf "${msg}"
  fi
done<${MSKS}
cmd="singularity instance stop met1"
printf "${cmd}\n"; eval "${cmd}"
msg="Script completed at `date +%Y-%m-%d_%H_%M_%S`, verify "
msg+="outputs at MSK_OUT:\n ${MSK_OUT}\n"
printf "${msg}"
exit 0
