#!/bin/bash
#FLUX: --job-name=rpt-tractography
#FLUX: -n=28
#FLUX: --queue=standard
#FLUX: -t=144000
#FLUX: --urgency=16

. $PWD/parseParams.sh
parseparams $*
PREVSECS=$SECONDS
SECONDS=0
STARTTIME=$(date)
echo "Tractography Pipeline"
echo "script start time: " $STARTTIME
shopt -s expand_aliases
alias runtrix="singularity run $SINGIMG"
alias runtrixhere="singularity run --nv -B $WORK:/opt/data $SINGIMG"
echo "***********************"
echo "SUBJECT = $SUB"
echo "SESSION = $SES"
echo "SESSION(anat) = $ANATSES"
echo "DATADIR = $DATADIR"
echo "WORKDIR = $WORKDIR"
echo "WORK = $WORK"
echo "SINGULARITY = $SINGIMG"
echo "OUTPUT = $OUTPUT"
echo "VIEW = $VIEWIMG"
echo "OVERWRITE = $OVERWRITE"
echo "DEBUG = $DEBUG "
export SUB SES ANATSES DATADIR WORKDIR WORK SINGIMG OUTPUT VIEWIMG OVERWRITE DEBUG
if [ $DEBUG = "False" ]
then
mkdir -p $OUTPUT
mkdir -p $WORK
fi
DWI=$OUTPUT/$SUB-dwi.mif
RAWDWI=$DATADIR/${SUB}/${SES}/dwi/${SUB}_${SES}_dwi.nii.gz
BVALS=$DATADIR/${SUB}/${SES}/dwi/${SUB}_${SES}_dwi.bval
BVECS=$DATADIR/${SUB}/${SES}/dwi/${SUB}_${SES}_dwi.bvec
export DWI RAWDWI BVALS BVECS
STEP="STEP 1: CREATE dwi.mif:"
echo -e "\n$STEP: combine raw dwi, diffusion bvalues and vectors into one convenient mrtrix file\n"
if [ ! -f $DWI ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then
    echo -e "\tConverting raw DWI file $RAWDWI to mrtrix format $DWI"
    echo -e "\tmrconvert ${FORCE} $RAWDWI -fslgrad $BVECS $BVALS $DWI"
    runtrix mrconvert ${FORCE} $RAWDWI -fslgrad $BVECS $BVALS $DWI
else
    if [ $DEBUG = "False" ]; then echo -e "\talready converted raw DWI file $RAWDWI to mrtrix format $DWI"
    else echo -e "\tRunning in Debug mode. $STEP skipped.\n"
    fi
fi
if [ $VIEWIMG = "True" ]
then
  echo -e "\n$STEP: Viewing raw DWI $DWI in mrview."
  runtrix mrview $DWI
fi
DENOISEDWI=$OUTPUT/$SUB-dwi_den.mif
NOISE=$OUTPUT/$SUB-noise.mif
RESIDUAL=$OUTPUT/$SUB-noise_residual.mif
export DENOISEDWI NOISE RESIDUAL
STEP="STEP 2: DENOISE:"
echo -e "\n$STEP denoise the mrtrix dwi file using M-PCA algorithm\n"
if [ ! -f $DENOISEDWI ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then
    echo -e "\tDenoising $DWI to create denoised version $DENOISEDWI. Noise estimate created here $NOISE"
    echo -e "\tdwidenoise ${FORCE} $DWI $DENOISEDWI  -noise $NOISE"
    echo -e "\tmrcalc $DWI $DENOISEDWI -subtract $RESIDUAL"
    runtrix dwidenoise ${FORCE} $DWI $DENOISEDWI -noise $NOISE
    runtrix mrcalc $DWI $DENOISEDWI -subtract $RESIDUAL
else
    if [ $DEBUG = "False" ]; then echo -e "\tAlready denoised $DWI to create denoised version $DENOISEDWI. Noise estimate created here $NOISE"
    else echo -e "\tRunning in Debug mode. $STEP skipped.\n"
    fi
fi
if [ $VIEWIMG = "True" ]
then
  echo -e "\n$STEP: Viewing \nRAWDWI=$DWI \nDENOISED=$DENOISEDWI \nNOISE=$NOISE \nRESIDUAL=$RESIDUAL"
  runtrix mrview $DWI $DENOISEDWI $NOISE $RESIDUAL
fi
GIBBSDENOISEDWI=$OUTPUT/$SUB-dwi_den_gibbs.mif
GIBBSRESIDUAL=$OUTPUT/$SUB-dwi_den_gibbs_residual.mif
export GIBBSDENOISEDWI GIBBSRESIDUAL
STEP="STEP 3: GIBBS ARTEFACT:"
echo -e "\n$STEP: reduce Gibbs ringing artefact using method of sub-voxel shifts\n"
if [ ! -f $GIBBSDENOISEDWI ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then
    echo -e "\tReducing Gibbs artefact from denoised $DENOISEDWI to create $GIBBSDENOISEDWI "
    echo -e "\tmrdegibbs -axes 0,1 ${FORCE} $DENOISEDWI $GIBBSDENOISEDWI "
    echo -e "\tmrcalc $DENOISEDWI $GIBBSDENOISEDWI -subtract $GIBBSRESIDUAL"
    runtrix mrdegibbs -axes 0,1 ${FORCE} $DENOISEDWI $GIBBSDENOISEDWI 
    runtrix mrcalc $DENOISEDWI $GIBBSDENOISEDWI -subtract $GIBBSRESIDUAL
else
    if [ $DEBUG = "False" ]; then echo -e "\tAlready reduced Gibbs artefact from denoised $DENOISEDWI to create $GIBBSDENOISEDWI"
    else echo -e "\tRunning in Debug mode. $STEP skipped.\n"
    fi
fi
if [ $VIEWIMG = "True" ] 
then
  echo -e "\n$STEP Viewing \nDENOISED=$DENOISEDWI \nGIBBS_DENOISED=$GIBBSDENOISEDWI \nGIBBS_RESIDUAL=$GIBBSRESIDUAL"
  runtrix mrview $DENOISEDWI $GIBBSDENOISEDWI $GIBBSRESIDUAL
fi
RAWRPE=$DATADIR/${SUB}/${SES}/misc/${SUB}_${SES}_acq-rpe_dwi.nii.gz
RPE=$OUTPUT/$SUB-rpe.mif
export RAWRPE RPE
STEP="STEP 4: PROCESS RPE:"
SUBSTEP=": Prepare RPE pair for EDDY and TOPUP"
echo -e "\n$STEP $SUBSTEP \n"
if [ ! -f $RPE ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then
    echo -e "\tConverting raw RPE file ${RAWRPE} to mrtrix format $RPE - this is for informational purposes only"
    echo -e "\tmrconvert ${FORCE} ${RAWRPE} ${RPE}"
    runtrix mrconvert ${FORCE} ${RAWRPE} ${RPE}
else
    if [ $DEBUG = "False" ]; then echo -e "\talready converted raw RPE file $RPERAW to mrtrix format $RPE"
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
meanAP=$OUTPUT/$SUB-mean_b0_AP.mif
RUNPROC4A=$WORK/004a_runproc.sh
export meanAP RUNPROC4A
SUBSTEP=": Extract B0 images."
echo -e "\n$STEP $SUBSTEP \n"
if [ ! -f $meanAP ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then
    echo -e "\textract mean B0 image from $GIBBSDENOISEDWI"
    echo -e "\tdwiextract $GIBBSDENOISEDWI - -bzero | mrmath - mean $meanAP -axis 3"
    echo "dwiextract $GIBBSDENOISEDWI - -bzero | mrmath - mean $meanAP -axis 3" > $RUNPROC4A
    chmod +x $RUNPROC4A
    runtrixhere $RUNPROC4A
else
    if [ $DEBUG = "False" ]; then echo -e "\talready extracted $meanAP from  $GIBBSDENOISEDWI"
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
meanPA=$OUTPUT/$SUB-mean_b0_PA.mif
RUNPROC4B=$WORK/004b_runproc.sh
export meanPA RUNPROC4B
SUBSTEP=": Calculate mean RPE."
echo -e "\n$STEP $SUBSTEP \n"
if [ ! -f $meanPA ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then
    TDIM=$(runtrix fslinfo $RAWRPE | sed -n /^dim4/p | sed "s/.*\s\(.*\)$/\1/")
    if [ $TDIM -eq 1 ]
    then
        echo -e "\tRPE has 1 volume. Simply copy RPE as the mean PA image. "
        echo -e "\tcp ${RPE} ${meanPA}"
        cp ${RPE} ${meanPA} 
    else
        echo -e "\tCalculate mean B0 image from $RPE which has $TDIM images"
        echo -e "\tmrconvert ${FORCE} $RAWRPE - | mrmath - mean $meanPA -axis 3"
        echo "mrconvert ${FORCE} ${RAWRPE} - | mrmath - mean $meanPA -axis 3" > $RUNPROC4B
        chmod +x $RUNPROC4B
        runtrixhere $RUNPROC4B 
    fi
else
    if [ $DEBUG = "False" ]; then echo -e "\tAlready extracted $meanPA from  $RPE"
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
B0PAIR=$OUTPUT/$SUB-b0_pair.mif
export B0PAIR
SUBSTEP=": Concatenate mean AP and mean PA to create BO Pair."
echo -e "\n$STEP $SUBSTEP \n"
if [ ! -f $B0PAIR ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then
    echo -e "\tCreate B0 Pair from $meanAP and $meanPA"
    echo -e "\tmrcat"
    runtrix mrcat $meanAP $meanPA -axis 3 $B0PAIR
else
    if [ $DEBUG = "False" ]; then echo -e "\talready created $B0PAIR from $meanAP and $meanPA"
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
if [ $VIEWIMG = "True" ]
then
    echo -e "\n$STEP Viewing \nmeanAP=$meanAP \nmeanPA=$meanPA \nRPE=$RPE \nB0PAIR=$B0PAIR"
    echo -e "mrview $meanAP $meanPA $RPE $B0PAIR" 
    runtrix mrview $meanAP $meanPA $RPE $B0PAIR
fi
if [ $VIEWIMG = "True" ]
then
    echo -e "\n$STEP Viewing $meanAP overlaid with $meanPA"
    echo -e "mrview $meanAP -overlay.load $meanPA"
    runtrix mrview $meanAP -overlay.load $meanPA
fi
PREPROCDWI=$OUTPUT/$SUB-dwi_den_gibbs_preproc.mif
RUNPROC5A=$WORK/005a_runproc.sh
STEP="STEP 5: EDDY:"
SUBSTEP=": run dwifslpreproc to correct for eddy current artefacts."
echo -e "\n$STEP $SUBSTEP \n"
if [ ! -f $PREPROCDWI ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then
    echo -e "\tUse FSL EDDY to remove eddy and motion artefacts from $GIBBSDENOISEDWI to create $PREPROCDWI "
    echo -e "\tdwifslpreproc $GIBBSDENOISEDWI $PREPROCDWI ${FORCE} -pe_dir AP -rpe_pair -se_epi $B0PAIR -eddy_options \" --slm=linear\""
    echo "dwifslpreproc $GIBBSDENOISEDWI $PREPROCDWI ${FORCE} -pe_dir AP -rpe_pair -se_epi $B0PAIR -eddy_options \" --slm=linear\"" > $RUNPROC5A
    chmod +x $RUNPROC5A
    runtrixhere $RUNPROC5A
else
    if [ $DEBUG = "False" ]; then echo "Already used FSL EDDY to remove eddy and motion artefacts from $GIBBSDENOISEDWI to create $PREPROCDWI "
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
SUBSTEP=": Convert preprocessed DWI from .mif to .nii.gz."
echo -e "\n$STEP $SUBSTEP \n"
PREPROCDWI_NII=$OUTPUT/$SUB-dwi_den_gibbs_preproc
if [ ! -f $PREPROCDWI_NII.nii.gz ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then
    echo -e "\tconvert $PREPROCDWI to ${PREPROCDWI}.nii.gz"
    echo -e "\tmrconvert ${FORCE} $PREPROCDWI ${PREPROCDWI_NII}.nii.gz"
    runtrix mrconvert ${FORCE} $PREPROCDWI ${PREPROCDWI_NII}.nii.gz
else
    if [ $DEBUG = "False" ]; then echo "Already converted $PREPROCDWI to ${PREPROCDWI}.nii.gz"
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
if [ $VIEWIMG = "True" ]
then
  echo -e "\n$STEP Viewing Preprocessed DWI PREPROCDWI\nPREPROCDWI=$PREPROCDWI\nGibbs Denoised: $GIBBSDENOISEDWI"
  echo -e "command: mrview $PREPROCDWI $GIBBSDENOISEDWI"
  runtrix mrview $PREPROCDWI $GIBBSDENOISEDWI
fi
T1RAW=$DATADIR/${SUB}/${ANATSES}/anat/${SUB}_${ANATSES}_acq-nd_T1w.nii.gz
FSLANAT=${OUTPUT}/T1proc_${SUB}
STEP="STEP 6: FSL_ANAT:"
SUBSTEP=": Run FSL_ANAT to perform T1w preprocessing (Bias correction, brain extraction, registration to MNI)."
echo -e "\n$STEP $SUBSTEP \n"
if [ ! -d ${FSLANAT}.anat ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then
    ANATPARAM="-o"
    if [ ${OVERWRITE} = "True" ]
    then
        if [ -d ${FSLANAT}.anat ]   
        then
         ANATPARAM="-d"
        fi
    fi
    echo -e "\tRun fsl_anat on $T1RAW"
    echo -e "\tfsl_anat -i $T1RAW $ANATPARAM $FSLANAT"
    runtrix fsl_anat -i $T1RAW $ANATPARAM $FSLANAT
else
    if [ $DEBUG = "False" ]; then echo -e "\tAlready run fsl_anat on $T1RAW."
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
T1BIAS=$FSLANAT.anat/T1_biascorr
T1BIASBRAIN=$FSLANAT.anat/T1_biascorr_brain
T1BIASBRAINMASK=$FSLANAT.anat/T1_biascorr_brain_mask
if [ $VIEWIMG = "True" ]
then
    echo -e "\nViewing Bias Corrected T1W image\nT1BIAS=$T1BIAS \nT1BIASBRAIN=$T1BIASBRAIN \nT1BIASBRAINMASK=$T1BIASBRAINMASK"
    echo "command: fsleyes $T1BIAS $T1BIASBRAIN $T1BIASBRAINMASK"
    runtrix fsleyes $T1BIAS $T1BIASBRAIN $T1BIASBRAINMASK
fi
T12MNIWARP=$FSLANAT.anat/T1_to_MNI_nonlin_field
echo "Warp $T12MNIWARP created from T1 to MNI"
MNI2T1WARP=${OUTPUT}/MNI_to_T1_nonlin_field
if [ ! -f $MNI2T1WARP.nii.gz ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then
   echo "Create inverse warp $MNI2T1WARP from MNI to T1"
   echo "invwarp --ref=${T1BIAS} --warp=${T12MNIWARP} --out=${MNI2T1WARP}"
   runtrix invwarp --ref=${T1BIAS} --warp=${T12MNIWARP} --out=${MNI2T1WARP}
else
   echo "Already created $MNI2T1WARP"
fi
meanAP_Eddy=$OUTPUT/$SUB-mean_b0_AP_eddycorrected.mif
RUNPROC7A=$WORK/006a_runproc.sh
STEP="STEP 7: EPI_REG:"
SUBSTEP=": Extract average B0 from DWI in AP direction."
echo -e "\n$STEP $SUBSTEP \n"
if [ ! -f $meanAP_Eddy ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then
    echo -e "\textract mean B0 image from $PREPROCDWI"
    echo -e "\tdwiextract $PREPROCDWI - -bzero | mrmath - mean $meanAP_Eddy -axis 3"
    echo "dwiextract $PREPROCDWI - -bzero | mrmath - mean $meanAP_Eddy -axis 3" > $RUNPROC7A
    chmod +x $RUNPROC7A
    runtrixhere $RUNPROC7A
else
    if [ $DEBUG = "False" ]; then echo -e "\talready extracted $meanAP_Eddy from  $ $PREPROCDWI"
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
SUBSTEP=": Convert meanAP from .mif to .nii.gz."
echo -e "\n$STEP $SUBSTEP \n"
meanB0=$OUTPUT/${SUB}_${SES}_dwi_mean_b0
if [ ! -f $meanB0.nii.gz ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then
    echo "mrconvert ${FORCE} $meanAP_Eddy $meanB0.nii.gz"
    runtrix mrconvert ${FORCE} $meanAP_Eddy $meanB0.nii.gz
else
    if [ $DEBUG = "False" ]; then echo "Already generated $meanB0"
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
if [ $VIEWIMG = "True" ]
then
  echo -e "\nViewing meanAP \nmeanA_Eddy=$meanAP_Eddy"
  echo -e "mrview $meanAP_Eddy"
  runtrix mrview $meanAP_Eddy
fi
SUBSTEP=": Extract average B0 from DWI in AP direction."
echo -e "\n$STEP $SUBSTEP \n"
EPI2T1=$OUTPUT/epi2t1
EPI2T1MAT=$OUTPUT/epi2t1.mat
T12EPIMAT=$OUTPUT/t12epi.mat
if [ ! -f ${EPI2T1MAT} ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then
    echo -e "\tRun EPI-REG"
    echo -e "\tepi_reg --epi=${meanB0} --t1=${T1BIAS} --t1brain=${T1BIASBRAIN} --out=${EPI2T1}"
    runtrix epi_reg --epi=${meanB0} --t1=${T1BIAS} --t1brain=${T1BIASBRAIN} --out=${EPI2T1}
    echo -e "\tCreate inverse EPI-REG transform"
    echo -e "\tconvert_xfm -omat ${T12EPIMAT} -inverse ${EPI2T1MAT}"
    runtrix convert_xfm -omat ${T12EPIMAT} -inverse ${EPI2T1MAT}
else
    if [ $DEBUG = "False" ]; then echo "EPI-REG already run"
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
echo "completed transform from EPI to T1 space"
echo "EPI to T1 Transform: $EPI2T1MAT"
echo "T1 to EPI Transform: $T12EPIMAT"
DWIT1=${PREPROCDWI_NII}_T1space
SUBSTEP=": Test forward EPI to T1 Transform."
echo -e "\n$STEP $SUBSTEP \n"
if [ ! -f ${DWIT1}.nii.gz ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then
    echo -e "\tflirt -in ${PREPROCDWI_NII} -ref ${T1BIAS} -applyxfm -init ${EPI2T1MAT} -out ${DWIT1}"
    runtrix flirt -in ${PREPROCDWI_NII} -ref ${T1BIAS} -applyxfm -init ${EPI2T1MAT} -out ${DWIT1}
else
    if [ $DEBUG = "False" ]; then echo "$DWIT1 already created "
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
if [ $VIEWIMG = "True" ]
then
  echo -e "\nViewing \nT1BIAS=${T1BIAS} \nDWIT1=${DWIT1} "
  runtrix fsleyes ${T1BIAS} ${DWIT1}
fi
T1DWI=${OUTPUT}/${SUB}_${ANATSES}_T1w_dwispace
SUBSTEP=": Test reverse T1 to EPI to Transform."
echo -e "\n$STEP $SUBSTEP \n"
if [ ! -f ${T1DWI}.nii.gz ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then
    echo "flirt -in ${T1BIAS} -ref ${meanB0} -applyxfm -init ${T12EPIMAT} -out ${T1DWI}"
    runtrix flirt -in ${T1BIAS} -ref ${meanB0} -applyxfm -init ${T12EPIMAT} -out ${T1DWI}
else
    if [ $DEBUG = "False" ]; then echo "$T1DWI already created "
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
if [ $VIEWIMG = "True" ]
then
  echo -e "\nViewing \nPREPROCDWI_NII=${PREPROCDWI_NII} \nT1DWI=${T1DWI} "
  runtrix fsleyes ${PREPROCDWI_NII} ${T1DWI}
fi
DWIUNBIASED_MASK=$OUTPUT/$SUB-dwi_den_gibbs_preproc_unbiased_mask.mif
PREPROCDWI_UNBIASED=$OUTPUT/$SUB-dwi_den_gibbs_preproc_unbiased.mif
DWIBIAS=$OUTPUT/$SUB-dwi_bias.mif
DWIMASK=$OUTPUT/$SUB-dwi_den_gibbs_preproc_mask.mif
STEP="STEP 8: Create DWIMASK:"
SUBSTEP=": Create Masks for DWI using dwi2mask."
echo -e "\n$STEP $SUBSTEP \n"
if [ ! -f ${PREPROCDWI_UNBIASED} ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then
   echo -e "\tUse -ants option to bias-correct EPI"
   echo -e "\tdwibiascorrect ants ${FORCE} $PREPROCDWI $PREPROCDWI_UNBIASED -bias $DWIBIAS"
   runtrixhere dwibiascorrect ants ${FORCE} $PREPROCDWI $PREPROCDWI_UNBIASED -bias $DWIBIAS
   echo -e "\tgenerate mask from bias-corrected DWI"
   echo -e "\tdwi2mask ${FORCE} $PREPROCDWI_UNBIASED $DWIUNBIASED_MASK"
   runtrixhere dwi2mask ${FORCE} $PREPROCDWI_UNBIASED $DWIUNBIASED_MASK
   echo -e "\tgenerate mask from uncorrected DWI"
   echo -e "\tdwi2mask${FORCE} $PREPROCDWI $DWIMASK"
   runtrixhere dwi2mask  ${FORCE} $PREPROCDWI $DWIMASK
else
    if [ $DEBUG = "False" ]; then echo -e "\tBias correction using -ants already run on ${PREPROCDWI_UNBIASED}"
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
T1BIASDWI_MASK=${OUTPUT}/${SUB}_${ANATSES}_T1w_mask_dwispace.nii.gz
T1BIASDWI_MASK_DIL=${OUTPUT}/${SUB}_${ANATSES}_T1w_mask_dil_M_dwispace.nii.gz
SUBSTEP=": Create Masks for DWI using FSL flirt."
echo -e "\n$STEP $SUBSTEP \n"
if [ ! -f ${T1BIASDWI_MASK} ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then
    echo -e "\tTransform T1 mask to DWI space"
    echo -e "\tflirt -in ${T1BIASBRAINMASK} -ref ${meanB0} -applyxfm -interp nearestneighbour -init ${T12EPIMAT} -out ${T1BIASDWI_MASK}"
    runtrix flirt -in ${T1BIASBRAINMASK} -ref ${meanB0} -applyxfm -interp nearestneighbour -init ${T12EPIMAT} -out ${T1BIASDWI_MASK}
    echo -e "\tCreate Dilated mask"
    echo fslmaths $T1BIASDWI_MASK -dilM  $T1BIASDWI_MASK_DIL
    runtrix fslmaths $T1BIASDWI_MASK -dilM  $T1BIASDWI_MASK_DIL 
    #echo fslmaths $T1BIASDWI_MASK -dilD  $T1BIASDWI_MASK_DIL_D
    #runtrix fslmaths $T1BIASDWI_MASK -dilD  $T1BIASDWI_MASK_DIL_D
    #echo fslmaths $T1BIASDWI_MASK -dilF  $T1BIASDWI_MASK_DIL_F
    #runtrix fslmaths $T1BIASDWI_MASK -dilF  $T1BIASDWI_MASK_DIL_F
else
    if [ $DEBUG = "False" ]; then echo "T1w mask already transformed to DWI space"
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
FSDWI_MASK=${OUTPUT}/${SUB}_${ANATSES}_FS_T1w_brainmask_dwispace.nii.gz
FSDWI_BRAIN=${OUTPUT}/${SUB}_${ANATSES}_FS_T1w_brain_dwispace.nii.gz
FREESURF=/xdisk/yinghuichou/CORT/derivatives/freesurfer
FREEDIR=$FREESURF/${ANATSES}/acq-nd_
FSANAT=${FREEDIR}/${SUB}/mri/brain.mgz
FSNATIVE=${OUTPUT}/${SUB}_${ANATSES}_FS_T1w_brain.mgz
NIFTINATIVE=$OUTPUT/${SUB}_${ANATSES}_FS_T1w_brain.nii.gz
NATIVEMASK_FS=$OUTPUT/${SUB}_${ANATSES}_FS_T1w_brainmask.nii.gz
FS2EPIMAT=$OUTPUT/FS2EPI.mat
EPI2FSMAT=$OUTPUT/EPI2FS.mat
SUBSTEP=": Create Masks for DWI from existing FreeSurfer folder."
echo -e "\n$STEP $SUBSTEP \n"
if [ ! -f ${FSDWI_MASK} ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then
    echo -e "\tUsing existing freesurfer extracted brain. Converting from Freesurfer space to native space"
    echo -e "\tmri_vol2vol --mov ${FSANAT} --targ ${FREEDIR}/${SUB}/mri/rawavg.mgz --regheader --o ${FSNATIVE} --no-save-reg"
    runtrix ${FREESURF}/freebash.sh ${FREEDIR} mri_vol2vol --mov ${FSANAT} --targ ${FREEDIR}/${SUB}/mri/rawavg.mgz --regheader --o ${FSNATIVE} --no-save-reg
    echo -e "mri_convert --in_type mgz --out_type nii  ${FSNATIVE} ${NIFTINATIVE}"
    runtrix ${FREESURF}/freebash.sh ${FREEDIR} mri_convert --in_type mgz --out_type nii  ${FSNATIVE} ${NIFTINATIVE}
    echo -e "\tTransform from FS space to T1W FIRST space"
    echo -e "\tflirt -in ${NIFTINATIVE} -ref ${T1BIASBRAIN} -out ${OUTPUT}/FS2FIRST -omat ${OUTPUT}/FS2FIRST.mat -dof 6"
    runtrix flirt -in ${NIFTINATIVE} -ref ${T1BIASBRAIN} -out ${OUTPUT}/FS2FIRST -omat ${OUTPUT}/FS2FIRST.mat -dof 6
    echo -e "\tCreate concatenated transform from FS space to DWI space"
    echo -e "\tconvert_xfm -omat AtoC.mat -concat BtoC.mat AtoB.mat"
    echo -e "\tconvert_xfm -omat ${FS2EPIMAT}  -concat ${T12EPIMAT} ${OUTPUT}/FS2FIRST.mat"
    runtrix convert_xfm -omat ${FS2EPIMAT}  -concat ${T12EPIMAT} ${OUTPUT}/FS2FIRST.mat 
    echo -e "\tCreate inverse transform from DWI to FS space"
    echo -e "\tconvert_xfm -omat ${EPI2FSMAT} -inverse ${FS2EPIMAT}"
    runtrix convert_xfm -omat ${EPI2FSMAT} -inverse ${FS2EPIMAT} 
    echo -e "\tCreate Mask from original T1w image brain as processed by FS"
    echo "flirt -in ${NIFTINATIVE} -ref ${meanB0} -applyxfm -init ${FS2EPIMAT} -out ${FSDWI_BRAIN}"
    runtrix flirt -in ${NIFTINATIVE} -ref ${meanB0} -applyxfm -init ${FS2EPIMAT} -out ${FSDWI_BRAIN}
    echo -e "\tfslmaths $FSDWI_BRAIN -bin $FSDWI_MASK" 
    runtrix fslmaths $FSDWI_BRAIN -bin $FSDWI_MASK
    echo -e "\tfslmaths $NIFTINATIVE -bin $NATIVEMASK_FS"
    runtrix fslmaths $NIFTINATIVE -bin $NATIVEMASK_FS
else
    if [ $DEBUG = "False" ]; then echo "FS generated brain and  mask already transformed to DWI space"
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
if [ $VIEWIMG = "True" ]
then
  echo -e "\nViewing Different Masks \nDWIMASK=$DWIMASK $\nDWIUNBIASED_MASK=$DWIUNBIASED_MASK \nT1BIASDWI_MASK=$T1BIASDWI_MASK \nT1BIASDWI_MASK_DIL=$T1BIASDWI_MASK_DIL \nFSDWI_MASK=$FSDWI_MASK \nDWIBIAS=$DWIBIAS"
  echo -e "mrview $DWIMASK $DWIUNBIASED_MASK $T1BIASDWI_MASK $T1BIASDWI_MASK_DIL $FSDWI_MASK $DWIBIAS"
  runtrix mrview $DWIMASK $DWIUNBIASED_MASK $T1BIASDWI_MASK $T1BIASDWI_MASK_DIL $FSDWI_MASK $DWIBIAS
  echo -e "\tViewing Anatomical images \nNIFTINATIVE=$NIFTINATIVE \nNATIVEMASK_FS=$NATIVEMASK_FS \nT1BIAS=$T1BIAS \nT1BIASBRAIN=$T1BIASBRAIN \nT1BIASBRAINMASK=$T1BIASBRAINMASK"
  echo -e "fsleyes $NIFTINATIVE $NATIVEMASK_FS $T1BIAS $T1BIASBRAIN $T1BIASBRAINMASK"
  runtrix fsleyes $NIFTINATIVE $NATIVEMASK_FS $T1BIAS $T1BIASBRAIN $T1BIASBRAINMASK
fi
WMRESP=$OUTPUT/${SUB}_${SES}_wmresp.txt
GMRESP=$OUTPUT/${SUB}_${SES}_gmresp.txt
CSFRESP=$OUTPUT/${SUB}_${SES}_csfresp.txt
VOXELS=$OUTPUT/$SUB-voxels.mif
STEP="STEP 9: Estimate Response Function:"
SUBSTEP=": Calculate Response Functions for S."
echo -e "\n$STEP $SUBSTEP \n"
if [ ! -f $WMRESP ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then 
    echo "estimate response function from $PREPROCDWI_UNBIASED as $WMRESP with voxels selected for estimated saved here $VOXELS"
    echo "dwi2response dhollander ${FORCE} $PREPROCDWI_UNBIASED $WMRESP $GMRESP $CSFRESP -voxels $VOXELS"
    #runtrixhere dwi2response dhollander ${FORCE} $PREPROCDWI_UNBIASED $WMRESP $GMRESP $CSFRESP -voxels $VOXELS
    #dwi2response dhollander dwi.mif response_wm.txt response_gm.txt response_csf.txt -mask dwi_mask.mif
    runtrixhere dwi2response dhollander ${FORCE} $PREPROCDWI_UNBIASED $WMRESP $GMRESP $CSFRESP -voxels $VOXELS -mask $DWIUNBIASED_MASK
else
    if [ $DEBUG = "False" ]; then echo "Already estimated response function from $PREPROCDWI_UNBIASED as $WMRESP with voxels selected for estimated saved here $VOXELS"
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
if [ $VIEWIMG = "True" ]
then
  echo -e "\nViewing mrview PREPROCDWI_UNBIASED -overlay.load VOXELS"
  echo -e "\nmrview $PREPROCDWI_UNBIASED -overlay.load $VOXELS"
  runtrix mrview $PREPROCDWI_UNBIASED -overlay.load $VOXELS
  echo -e "\nshview \NWMRESP=$WMRESP"
  runtrix shview $WMRESP
  echo -e "\nshview \nGMRESP=$GMRESP"
  runtrix shview $GMRESP
  echo -e "\nshview \nCSFRESP=$CSFRESP"
  runtrix shview $CSFRESP
fi
WMFOD=$OUTPUT/$SUB_${SES}_wmfod.mif
GMFOD=$OUTPUT/$SUB_${SES}_gmfod.mif
CSFFOD=$OUTPUT/$SUB_${SES}_csffod.mif
WMFOD_NORM=$OUTPUT/$SUB_${SES}_wmfod_norm.mif
GMFOD_NORM=$OUTPUT/$SUB_${SES}_gmfod_norm.mif
CSFFOD_NORM=$OUTPUT/$SUB_${SES}_csffod_norm.mif
T1BIASDWI_MASK_DIL_MIF=${OUTPUT}/${SUB}_${ANATSES}_T1w_mask_dil_M_dwispace.mif
STEP="STEP 10: Estimate Response Function:"
SUBSTEP=": Calculate FOD."
echo -e "\n$STEP $SUBSTEP \n"
if [ ! -f $WMFOD_NORM ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then
   echo 
   runtrix mrconvert ${FORCE} ${T1BIASDWI_MASK_DIL} ${T1BIASDWI_MASK_DIL_MIF}
    echo "estimate fiber orientation distributions from  $PREPROCDWI_UNBIASED and normalize"
    echo "dwi2fod msmt_csd ${FORCE} $PREPROCDWI -mask $T1BIASDWI_MASK_DIL $WMRESP $WMFOD $GMRESP $GMFOD $CSFRESP $CSFFOD"
    echo "mtnormalise -force $WMFOD $WMFOD_NORM -mask $T1BIASDWI_MASK_DIL_MIF"
   #runtrix dwi2fod msmt_csd ${FORCE} $PREPROCDWI -mask $T1BIASDWI_MASK_DIL_MIF  $WMRESP $WMFOD $GMRESP $GMFOD $CSFRESP $CSFFOD
   # problems using dilated mask above - looks like DWIMASK covers everything even brain stem!!! 
   runtrix dwi2fod msmt_csd ${FORCE} $PREPROCDWI -mask $DWIUNBIASED_MASK $WMRESP $WMFOD $GMRESP $GMFOD $CSFRESP $CSFFOD
   #runtrix mtnormalise ${FORCE} $WMFOD $WMFOD_NORM $GMFOD $GMFOD_NORM $CSFFOD $CSFFOD_NORM -mask $T1BIASDWI_MASK_DIL_MIF
   runtrix mtnormalise ${FORCE} $WMFOD $WMFOD_NORM $GMFOD $GMFOD_NORM $CSFFOD $CSFFOD_NORM -mask $DWIUNBIASED_MASK 
else
    if [ $DEBUG = "False" ]; then echo "Already estimated and normalised fiber orientation distributions from $PREPROCDWI_UNBIASED"
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
VF_FILE=${OUTPUT}/vf.mif
VFNORM_FILE=${OUTPUT}/vfnorm.mif
RUNPROC10A=$WORK/010a_runproc.sh
RUNPROC10B=$WORK/010b_runproc.sh
SUBSTEP=": Generate VIF"
echo -e "\n$STEP $SUBSTEP \n"
if [ ! -f $VF_FILE ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then
    echo "Create $VF_FILE and $VFNORM_FILE for viewing"
    echo "mrconvert ${FORCE} -coord 3 0 $WMFOD - | mrcat ${FORCE} $CSFFOD $GMFOD - $VF_FILE" > $RUNPROC10A
    chmod +x $RUNPROC10A
    runtrixhere $RUNPROC10A
    echo "mrconvert ${FORCE} -coord 3 0 $WMFOD_NORM - | mrcat ${FORCE} $CSFFOD_NORM $GMFOD_NORM - $VFNORM_FILE" > $RUNPROC10B
    chmod +x $RUNPROC10B   
    runtrixhere $RUNPROC10B
else
    if [ $DEBUG = "False" ]; then echo "already generated $VF_FILE"
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
if [ $VIEWIMG = "True" ]
then
  echo -e "\nmrview VF_FILE -odf.load_sh WMFOD"
  echo -e "\nmrview $VF_FILE -odf.load_sh $WMFOD"
  runtrix mrview $VF_FILE -odf.load_sh $WMFOD
  echo -e "\nmrview VFNORM_FILE -odf.load_sh WMFOD_NORM"
  echo -e "\nmrview $VFNORM_FILE -odf.load_sh $WMFOD_NORM"
  runtrix mrview $VFNORM_FILE -odf.load_sh $WMFOD_NORM
fi
STEP="STEP 11: Calculate Tissue Estimates for ACT:"
SUBSTEP=": Convert T1 to mrtrix format."
echo -e "\n$STEP $SUBSTEP \n"
T1=$OUTPUT/$SUB-T1.mif
if [ ! -f $T1 ] && [ $DEBUG = "False" ]
then
    echo "convert T1W from nifti format $T1RAW to mrtrix format $T1"
    echo "mrconvert -force $T1RAW $T1"
    runtrix mrconvert -force $T1RAW $T1
else
    if [ $DEBUG = "False" ]; then echo "Already converted T1W from nifti format $T1RAW to mrtrix format $T1"
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
SUBSTEP=": run 5tt Gen to generate 5 tissue map."
echo -e "\n$STEP $SUBSTEP \n"
FIVETT=$OUTPUT/$SUB-5tt.mif
if [ ! -f $FIVETT ] && [ $DEBUG = "False" ]
then
    echo "Use FSL tp segment $T1 into 5 tissue types (Cortical GM, subcortical GM,WM,CSF,Pathological Tissue) in $FIVETT"
    echo "5ttgen fsl $T1 $FIVETT"    
    # use runtrixhere because file created in /opt/data (see TODO A)
    runtrixhere 5ttgen fsl $T1 $FIVETT
else
    if [ $DEBUG = "False" ]; then  echo "Already used FSL tp segment $T1 into 5 tissue types (Cortical GM, subcortical GM,WM,CSF,Pathological Tissue) in $FIVETT"
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
SUBSTEP=": Coregister 5TT to T1W."
echo -e "\n$STEP $SUBSTEP \n"
FIVETTCOREG=$OUTPUT/$SUB-5tt-coreg.mif
EPI2T1MAT=$OUTPUT/epi2t1.mat
EPI2T1MAT_MRT=$OUTPUT/epi2t1_mrtrix.txt
if [ ! -f $FIVETTCOREG ] && [ $DEBUG = "False" ]
then
    echo "Coregister $FIVETT to the DWI $PREPROCDWI as $FIVETTCOREG using FSL's epi-reg from previous FAST run"
    echo "transformconvert -force $EPI2T1MAT ${meanB0}.nii.gz ${T1BIASBRAIN}.nii.gz  flirt_import $EPI2T1MAT_MRT"
    echo "mrtransform -force $FIVETT -linear $EPI2T1MAT_MRT -inverse $FIVETTCOREG"
    runtrix transformconvert -force $EPI2T1MAT ${meanB0}.nii.gz ${T1BIASBRAIN}.nii.gz  flirt_import $EPI2T1MAT_MRT
    runtrix mrtransform -force $FIVETT -linear $EPI2T1MAT_MRT -inverse $FIVETTCOREG
else
    if [ $DEBUG = "False" ]; then  echo "Already Coregistered $FIVETT to the DWI $PREPROCDWI as $FIVETTCOREG using FSL's epi-reg"
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
if [ $VIEWIMG = "True" ]
then
    runtrix mrview $PREPROCDWI -overlay.load $FIVETTCOREG -overlay.colourmap 2 -overlay.load $FIVETT -overlay.colourmap 1
fi
STEP="STEP 12: Create streamlines:"
SUBSTEP=": Create streamline seeds at grey matter and white matter boundary."
echo -e "\n$STEP $SUBSTEP \n"
GMWMBOUNDARY=$OUTPUT/$SUB-gmwmseed_coreg.mif
if [ ! -f $GMWMBOUNDARY ] && [ $DEBUG = "False" ]
then
    echo "create Grey-white matter boundary as streamline seed from $FIVETTCOREG as $GMWMBOUNDARY"
    echo "5tt2gmwmi -force $FIVETTCOREG $GMWMBOUNDARY"
    runtrix 5tt2gmwmi -force $FIVETTCOREG $GMWMBOUNDARY
else
    if [ $DEBUG = "False" ]; then  echo "Already created Grey-white matter boundary as streamline seed from $FIVETTCOREG as $GMWMBOUNDARY"
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
SUBSTEP=": Create streamline seeds at grey matter and white matter boundary."
echo -e "\n$STEP $SUBSTEP \n"
TRACKNUM=100000000
TRACKS=$OUTPUT/$SUB-tracks_act_${TRACKNUM}.tck
MAXLEN=250
POW=0.33
if [ ! -f $TRACKS ] 
then
   echo -e "\tGenerate $TRACKNUM whole brain tracks as $TRACKS"
   #echo "tckgen -force -act $FIVETTCOREG -backtrack -seed_gmwmi $GMWMBOUNDARY -select $TRACKNUM $WMFOD_NORM  $TRACKS"
   #runtrix tckgen -force -act $FIVETTCOREG -backtrack -seed_gmwmi $GMWMBOUNDARY -select $TRACKNUM $WMFOD_NORM  $TRACKS
   # consider -crop_at_gmwmi and -seed-dynamic options - copied directly below from mrtrix3_connectome
   echo -e "\ttckgen $WMFOD_NORM $TRACKS -act $FIVETTCOREG -backtrack -crop_at_gmwmi -maxlength $MAXLEN -power $POW -select $TRACKNUM  -seed_dynamic $WMFOD_NORM"
   runtrix tckgen $WMFOD_NORM $TRACKS -act $FIVETTCOREG -backtrack -crop_at_gmwmi -maxlength $MAXLEN -power $POW -select $TRACKNUM  -seed_dynamic $WMFOD_NORM
else
    if [ $DEBUG = "False" ]; then echo "Already Generated $TRACKNUM whole brain tracks as $TRACKS"
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
SUBTRACKS=200k
TRACKSUB=$OUTPUT/$SUB-tracks_actview_${SUBTRACKS}.tck
if [ $VIEWIMG = "True" ] 
then
  echo
  echo "Viewing $TRACKS in mrview"
  runtrix tckedit $TRACKS -number $SUBTRACKS $TRACKSUB
  runtrix mrview $PREPROCDWI -tractography.load $TRACKSUB
fi
SUBSTEP=": Using tcksift2."
echo -e "\n$STEP $SUBSTEP \n"
TRACKSIFTWEIGHT=$OUTPUT/$SUB-tracks_act_sift_weight.csv
PROPCOEFF=$OUTPUT/$SUB-tracks_act_sift_mu.txt
if [ ! -f $TRACKSIFTWEIGHT ] 
then
   echo -e "\tGenerate $SIFTTRACKNUM whole brain tracks as $TRACKSIFT using SIFT2 algorithm"
   echo -e "\truntrix tcksift2 -force $TRACKS $WMFOD_NORM $TRACKSIFTWEIGHT -act $FIVETTCOREG -out_mu $PROPCOEFF"
   runtrix tcksift2 -force $TRACKS $WMFOD_NORM $TRACKSIFTWEIGHT -act $FIVETTCOREG -out_mu $PROPCOEFF
else
   if [ $DEBUG = "False" ]; then  echo "Already Generated  $TRACKSIFTWEIGHT using SIFT2 algorithm"
   else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
   fi
fi
STEP="STEP 13: Create Connectome for Aparc.aseg2009:"
SUBSTEP=": Create Aparc2009-aseg in DWI Space"
echo -e "\n$STEP $SUBSTEP \n"
APARC2009ASEGFS=$OUTPUT/${SUB}_${SES}_aparc2009-aseg.mgz
APARC2009ASEG=$OUTPUT/${SUB}_${SES}_aparc2009-aseg.nii.gz
APARC2009ASEGDWI=$OUTPUT/${SUB}_${SES}_aparc2009-aseg_dwispace.nii.gz
if [ ! -f ${APARC2009ASEG} ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then
    echo "Using existing aparcaseg convert from Freesurfer space to native space"
    runtrix ${FREESURF}/freebash.sh ${FREEDIR} mri_label2vol --seg ${FREEDIR}/${SUB}/mri/aparc.a2009s+aseg.mgz --temp ${FREEDIR}/${SUB}/mri/rawavg.mgz --o ${APARC2009ASEGFS} --regheader ${FREEDIR}/${SUB}/mri/aparc.a2009s+aseg.mgz
    runtrix $FREESURF/freebash.sh ${FREEDIR} mri_convert --in_type mgz --out_type nii  ${APARC2009ASEGFS} ${APARC2009ASEG}
    echo "flirt -in ${APARC2009ASEG} -ref ${meanB0} -applyxfm  -interp nearestneighbour -init ${FS2EPIMAT} -out ${APARC2009ASEGDWI}"
    runtrix flirt -in ${APARC2009ASEG} -ref ${meanB0} -applyxfm  -interp nearestneighbour -init ${FS2EPIMAT} -out ${APARC2009ASEGDWI}
else
    if [ $DEBUG = "False" ]; then  echo "Aparc2009-aseg already created and transformed to DWI"
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
if [ $VIEWIMG = "True" ] 
then
     runtrix fsleyes ${PREPROCDWI_NII} ${APARCASEGDWI} ${APARC2009ASEGDWI} $FSDWI_BRAIN 
fi
FREELABEL=/opt/freesurfer/FreeSurferColorLUT.txt
FREEORDERED=/opt/mrtrix3/share/mrtrix3/labelconvert/fs_a2009s.txt
APARC2009NODES=${OUTPUT}/${SUB}_${SES}_aparc2009_nodes.mif
APARC2009NODEST1W=${OUTPUT}/${SUB}_${SES}_aparc2009_nodes_T1w.nii.gz
SUBSTEP=": Use labelConvert to order labels sequentially for aparc2009"
echo -e "\n$STEP $SUBSTEP \n"
if [ ! -f ${APARC2009NODES} ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then
    echo "Generating ordered nodes for aparc2009 in DWI space"
    runtrix labelconvert $APARC2009ASEGDWI $FREELABEL $FREEORDERED $APARC2009NODES
    #runtrix cp $FREELABEL $WORKDIR/FreeSurferColorLUT.txt
    #runtrix cp $FREEORDERED $WORKDIR/fs_a2009s.txt
    echo "Generating ordered nodes for aparc2009 in T1w space - useful for fmri processing" 
    runtrix labelconvert $APARC2009ASEG $FREELABEL $FREEORDERED $APARC2009NODEST1W
else
    if [ $DEBUG = "False" ]; then echo "Ordered Nodes for Aparc2009 created."
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
if [ $VIEWIMG = "True" ]
then
   runtrix mrview $APARC2009NODES
fi
APARC2009MATRIX=$OUTPUT/${SUB}_${SES}_aparc2009_matrix.csv
APARC2009MEANLEN=$OUTPUT/${SUB}_${SES}_aparc2009_meanlen.csv
APARC2009ASSG=$OUTPUT/${SUB}_${SES}_aparc2009_assignments.csv
SUBSTEP=": Generate connectome using aparc2009"
echo -e "\n$STEP $SUBSTEP \n"
if [ ! -f ${APARC2009MATRIX} ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then
    #runtrix tck2connectome -symmetric -zero_diagonal -scale_invnodevol $TRACKSIFT $APARC2009NODES ${APARC2009MATRIX} -out_assignment $APARC2009ASSG
    echo -e "\tGenerate matrix for aparc 2009"
    echo -e "\truntrix tck2connectome $TRACKS $APARC2009NODES $APARC2009MATRIX -tck_weights_in $TRACKSIFTWEIGHT -out_assignment $APARC2009ASSG"
    runtrix tck2connectome $TRACKS $APARC2009NODES $APARC2009MATRIX -tck_weights_in $TRACKSIFTWEIGHT -out_assignment $APARC2009ASSG
    echo -e "\tGenerate mean length"
    echo -e "runtrix tck2connectome $TRACKS $APARC2009NODES $APARC2009MEANLEN -tck_weights_in $TRACKSIFTWEIGHT -scale_length -stat_edge mean"
    runtrix tck2connectome $TRACKS $APARC2009NODES $APARC2009MEANLEN -tck_weights_in $TRACKSIFTWEIGHT -scale_length -stat_edge mean
else
    if [ $DEBUG = "False" ]; then echo "Already Created Matrix for aparc2009."
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
APARC2009EXEMPLARS=$OUTPUT/${SUB}_${SES}_aparc2009_exemplars.tck
SUBSTEP=": Generate Exemplar using aparc2009"
echo -e "\n$STEP $SUBSTEP \n"
if [ ! -f ${APARC2009EXEMPLARS} ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then
    #runtrix connectome2tck -nodes 80,76  -exclusive $TRACKSIFT $APARC2009ASSG $OUTPUT/${SUB}_${SES}_aparc2009_lHippo.lThalamus
    #runtrix connectome2tck -nodes 80,43  -exclusive $TRACKSIFT $APARC2009ASSG $OUTPUT/${SUB}_${SES}_aparc2009_lHippo.lTemporalPole
    #runtrix connectome2tck -nodes 80,81  -exclusive $TRACKSIFT $APARC2009ASSG $OUTPUT/${SUB}_${SES}_aparc2009_lHippo.lAmygdala
    #runtrix connectome2tck -nodes 80,23  -exclusive $TRACKSIFT $APARC2009ASSG $OUTPUT/${SUB}_${SES}_aparc2009_lHippo.lParahippo
    #runtrix connectome2tck -nodes 87,83  -exclusive $TRACKSIFT $APARC2009ASSG $OUTPUT/${SUB}_${SES}_aparc2009_rHippo.rThalamus
    #runtrix connectome2tck -nodes 87,132 -exclusive $TRACKSIFT $APARC2009ASSG $OUTPUT/${SUB}_${SES}_aparc2009_rHippo.rTemporalPole
    #runtrix connectome2tck -nodes 87,88  -exclusive $TRACKSIFT $APARC2009ASSG $OUTPUT/${SUB}_${SES}_aparc2009_rHippo.rAmygdala
    #runtrix connectome2tck -nodes 87,112 -exclusive $TRACKSIFT $APARC2009ASSG $OUTPUT/${SUB}_${SES}_aparc2009_rHippo.rParahippo
    # create exemplar
    echo "connectome2tck $TRACKS $APARC2009ASSG $APARC2009EXEMPLARS -tck_weights_in $TRACKSIFTWEIGHT -exemplars $APARC2009NODES -files single"
    runtrix connectome2tck $TRACKS $APARC2009ASSG $APARC2009EXEMPLARS -tck_weights_in $TRACKSIFTWEIGHT -exemplars $APARC2009NODES -files single
else
    if [ $DEBUG = "False" ]; then echo "Created Exemplar for aparc2009"
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
   #runtrix mrview $FSDWI_BRAIN -tractography.load $OUTPUT/${SUB}_${SES}_aparc2009_lHippo.lThalamus76-80.tck
   #runtrix mrview $FSDWI_BRAIN -tractography.load $OUTPUT/${SUB}_${SES}_aparc2009_lHippo.lTemporalPole43-80.tck
   #runtrix mrview $FSDWI_BRAIN -tractography.load $OUTPUT/${SUB}_${SES}_aparc2009_lHippo.lAmygdala80-81.tck
   #runtrix mrview $FSDWI_BRAIN -tractography.load $OUTPUT/${SUB}_${SES}_aparc2009_lHippo.lParahippo23-80.tck
   #runtrix mrview $FSDWI_BRAIN -tractography.load $OUTPUT/${SUB}_${SES}_aparc2009_rHippo.rThalamus83-87.tck
   #runtrix mrview $FSDWI_BRAIN -tractography.load $OUTPUT/${SUB}_${SES}_aparc2009_rHippo.rTemporalPole87-132.tck
   #runtrix mrview $FSDWI_BRAIN -tractography.load $OUTPUT/${SUB}_${SES}_aparc2009_rHippo.rAmygdala87-88.tck
   #runtrix mrview $FSDWI_BRAIN -tractography.load $OUTPUT/${SUB}_${SES}_aparc2009_rHippo.rParahippo87-112.tck
LH_HCPANNOT=/xdisk/nkchen/chidi/repos/DTI-hippo/custom-pipeline/hcpmmp1_atlas/lh.HCPMMP1.annot
RH_HCPANNOT=/xdisk/nkchen/chidi/repos/DTI-hippo/custom-pipeline/hcpmmp1_atlas/rh.HCPMMP1.annot
HCPMMP1ASEGFS=$OUTPUT/${SUB}_${SES}_aparc.HCPMMP1+aseg.mgz
HCPMMP1ASEGFS_NATIVE=$OUTPUT/${SUB}_${SES}_aparc.HCPMMP1+aseg_native.mgz
HCPMMP1ASEG=$OUTPUT/${SUB}_${SES}_aparc.HCPMMP1+aseg.nii.gz
HCPMMP1ASEGDWI=$OUTPUT/${SUB}_${SES}_aparc.HCPMMP1+aseg_dwispace.nii.gz
STEP="STEP 14: Create Connectome for HCPMMP:"
SUBSTEP=": Create HCPMMP in DWI Space"
echo -e "\n$STEP $SUBSTEP \n"
if [ ! -f ${HCPMMP1ASEGDWI} ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then
    FSAVERAGE_TARGET=${FREEDIR}/fsaverage
    FSAVERAGE_SOURCE=/opt/freesurfer/subjects/fsaverage
    runtrix ln -s $FSAVERAGE_SOURCE $FSAVERAGE_TARGET
    #runtrix cp -R $FSAVERAGE_SOURCE $FSAVERAGE_TARGET
    LHEC_TARGET=${FREEDIR}/lh.EC_average 
    LHEC_SOURCE=/opt/freesurfer/subjects/lh.EC_average 
    runtrix ln -s $LHEC_SOURCE $LHEC_TARGET
    #runtrix cp -R  $LHEC_SOURCE $LHEC_TARGET
    RHEC_TARGET=${FREEDIR}/rh.EC_average 
    RHEC_SOURCE=/opt/freesurfer/subjects/rh.EC_average 
    runtrix ln -s $RHEC_SOURCE $RHEC_TARGET
    #runtrix cp -R $RHEC_SOURCE $RHEC_TARGET
    runtrix ${FREESURF}/freebash.sh ${FREEDIR} mri_surf2surf --srcsubject fsaverage --trgsubject ${SUB} --hemi lh --sval-annot ${LH_HCPANNOT} --tval ${FREEDIR}/${SUB}/label/lh.HCPMMP1.annot
    runtrix ${FREESURF}/freebash.sh ${FREEDIR} mri_surf2surf --srcsubject fsaverage --trgsubject ${SUB} --hemi rh --sval-annot ${RH_HCPANNOT} --tval ${FREEDIR}/${SUB}/label/rh.HCPMMP1.annot
    runtrix ${FREESURF}/freebash.sh ${FREEDIR} mri_aparc2aseg --s ${SUB} --old-ribbon --annot HCPMMP1 --o $HCPMMP1ASEGFS
     echo "Using existing hcpmmp1 convert from Freesurfer space to native space"
    runtrix ${FREESURF}/freebash.sh ${FREEDIR} mri_label2vol --seg ${HCPMMP1ASEGFS} --temp ${FREEDIR}/${SUB}/mri/rawavg.mgz --o ${HCPMMP1ASEGFS_NATIVE} --regheader ${HCPMMP1ASEGFS}  
    runtrix $FREESURF/freebash.sh ${FREEDIR} mri_convert --in_type mgz --out_type nii  ${HCPMMP1ASEGFS_NATIVE} ${HCPMMP1ASEG}
    echo "flirt -in ${HCPMMP1ASEG} -ref ${meanB0} -applyxfm  -interp nearestneighbour -init ${FS2EPIMAT} -out ${HCPMMP1ASEGDWI}"
    runtrix flirt -in ${HCPMMP1ASEG} -ref ${meanB0} -applyxfm  -interp nearestneighbour -init ${FS2EPIMAT} -out ${HCPMMP1ASEGDWI}
else
    if [ $DEBUG = "False" ]; then echo "Created HCPMMP in T1 and DWI Space."
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
HCPMMPLABEL=/opt/mrtrix3/share/mrtrix3/labelconvert/hcpmmp1_original.txt
HCPMMPORDERED=/opt/mrtrix3/share/mrtrix3/labelconvert/hcpmmp1_ordered.txt
HCPMMPNODES=${OUTPUT}/${SUB}_${SES}_aparc.HCPMMP1+aseg_nodes.mif
HCPMMPNODEST1W=${OUTPUT}/${SUB}_${SES}_aparc.HCPMMP1+aseg_nodes_T1w.nii.gz
SUBSTEP=": Label Convert HCPMMP in sequential order."
echo -e "\n$STEP $SUBSTEP \n"
if [ ! -f ${HCPMMPNODES} ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then
    echo "Generating ordered nodes for hcpmmp1 in DWI space"
    runtrix labelconvert $HCPMMP1ASEGDWI $HCPMMPLABEL $HCPMMPORDERED $HCPMMPNODES
    echo "Generating ordered nodes for hcpmmp1 in T1w space"
    runtrix labelconvert $HCPMMP1ASEG $HCPMMPLABEL $HCPMMPORDERED $HCPMMPNODEST1W
else
    if [ $DEBUG = "False" ]; then echo "Label Convert of HCPMMP already run."
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
if [ $VIEWIMG = "True" ] && [ $DEBUG = "False" ]
then
    runtrix mrview $HCPMMPNODES
fi
HCPMMPMATRIX=$OUTPUT/${SUB}_${SES}_HCPMMP1+aseg_matrix.csv
HCPMMPASSG=$OUTPUT/${SUB}_${SES}_HCPMMP1+aseg_assignments.csv
HCPMMPMEANLEN=$OUTPUT/${SUB}_${SES}_HCPMMP1+aseg_meanlen.csv
SUBSTEP=": Create HCPMMP Matrix."
echo -e "\n$STEP $SUBSTEP \n"
if [ ! -f ${HCPMMPMATRIX} ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then
    #runtrix tck2connectome -symmetric -zero_diagonal -scale_invnodevol $TRACKSIFT $HCPMMPNODES ${HCPMMPMATRIX} -out_assignment $HCPMMPASSG
    runtrix tck2connectome $TRACKS $HCPMMPNODES $HCPMMPMATRIX -tck_weights_in $TRACKSIFTWEIGHT -out_assignment $HCPMMPASSG
    runtrix tck2connectome $TRACKS $HCPMMPNODES $HCPMMPMEANLEN -tck_weights_in $TRACKSIFTWEIGHT -scale_length -stat_edge mean
else
    if [ $DEBUG = "False" ]; then echo "HCPMMP Matrix already created."
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
HCPMMPEXEMPLARS=$OUTPUT/${SUB}_${SES}_HCPMMP+aseg_exemplars.tck
SUBSTEP=": Creating Exemplars for HCPMMP."
echo -e "\n$STEP $SUBSTEP \n"
if [ ! -f ${HCPMMPEXEMPLARS} ] || [ ${OVERWRITE} = "True" ] && [ $DEBUG = "False" ]
then
    echo "Creating HCPMMP Exemplars."
    echo "connectome2tck $TRACKS $HCPMMPASSG $HCPMMPEXEMPLARS -tck_weights_in $TRACKSIFTWEIGHT -exemplars $HCPMMPNODES -files single"
    runtrix connectome2tck $TRACKS $HCPMMPASSG $HCPMMPEXEMPLARS -tck_weights_in $TRACKSIFTWEIGHT -exemplars $HCPMMPNODES -files single
else
    if [ $DEBUG = "False" ]; then echo "HCPMMP exemplars already created."
    else echo -e "\tRunning in Debug mode. $STEP $SUBSTEP skipped.\n"
    fi
fi
echo "script start time was: $STARTTIME"
ENDTIME=$(date)
echo "script end time is: $ENDTIME"
echo
duration=$SECONDS
echo "Time elapsed is $duration seconds."
echo "Time elapsed is $(($duration / 60)) minutes and $(($duration % 60))."
