#!/bin/bash
#FLUX: --job-name=plotLearn
#FLUX: -c=2
#FLUX: -t=1800
#FLUX: --urgency=16

cd ${HOME}/repos/patchV1/src
fdr0=/scratch/wd554/patchV1
res_fdr=${fdr0}/resource # inputFolder in cfg stimulus, V1-static, LGN-static and connectome files
data_fdr=${fdr0} # outputFolder in cfg
waveStage=3 # set stage number
if [[ "${waveStage}" = "2" ]] ;then # stage II wave goes here
	fdr=wave_concat/wave_II # folder will be made to store figures and configuratoin files
	op=32_ii # theme string to be added to filenames of data and figures
	op_cfg=wave_II.cfg # the simulation config file to be used
	new_setup=False
	lgn=lFF_ii # the theme string to be used for LGN_V1 connections
	res=lFF # the theme string to be used for V1, LGN positions etc.
fi
if [[ "${waveStage}" = "3" ]] ;then
	fdr=test_32/wave_III
	op=profile_III
	#fdr=wave_III/32x3_5-5_standard
	#op=32x3_5-5_standard0
	op_cfg=profile_III.cfg
	new_setup=False
	lgn=lFF_iii_5-5_32
	res=lFF_iii_5-5_32
fi
if [[ "${waveStage}" = "5" ]] ;then
	fdr=wave_concat
	op=32_32x3_concat
	op_cfg=wave_concat.cfg
	new_setup=True
	lgn=lFF_concat
	res=lFF # starts out from stage II
fi
seed=1924784 # RANDOM SEED for post-analysis sampling and input randomization 
st=2 # figures' output: 0 for temporal, 1 for spatial, 2 for both
examSingle=true # output the spatiotemporal figure, tLGN_V1_single if true
collectMeanDataOnly=False # not ploting samples of V1 response variable traces
usePrefData=False
OPstatus=1 
LGN_switch=false
TF=8
ori=0
nOri=0
v1=${lgn} # cortical V1 connections used the same theme as LGN to V1 connections
echo ${op} # echo/print out the variable "op" in the job's output file
fig_fdr=${fdr0}/${fdr}
if [ -d "${fig_fdr}" ]
then
	echo overwrite contents in ${fig_fdr}
else
	mkdir -p ${fig_fdr}
fi
echo using ${op_cfg}
echo outputs to ${fig_fdr}
cp lFF.slurm ${fig_fdr}/lFF_${op}.slurm
readNewSpike=$1
if [ -z "${readNewSpike}" ]; 
then
	readNewSpike=True
fi
echo readNewSpike=${readNewSpike}
plotOnly=$2
if [ -z "${plotOnly}" ]; 
then
	plotOnly=False
fi
echo plotOnly=${plotOnly}
cp outputLearnFF.m ${fig_fdr}/outputLearnFF_${op}.m
if [ "${plotOnly}" = False ]
then
	gpu=1
	cp ${op_cfg} ${fig_fdr}/${op}.cfg
	cp inputLearnFF.m ${fig_fdr}/inputLearnFF_${op}.m
else
	gpu=0
fi
if ! [ -d "log" ]
then
	mkdir log
fi
sbatch <<EOT
set -e
echo ${PATH}
module purge
module load gcc/10.2.0
module load cuda/11.1.74
module load boost/intel/1.74.0
module load matlab/2020b
module list
cd ${fdr0}
date
nsys profile -o fast_V1.qdrep --force-overwrite=true --cuda-flush-interval=0 patch -c ${fig_fdr}/${op}.cfg
date
EOT
