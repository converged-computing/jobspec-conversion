#!/bin/bash
#FLUX: --job-name=dtaScrape
#FLUX: --queue=gpu
#FLUX: -t=5100
#FLUX: --priority=16

echo "Starting at $(date)"
echo ""
echo "#########################################################################"
echo "#########################################################################"
echo "##                                                                     ##"
echo "##        ::::::::::::::::::::::::    :::::::::::::::::   :::          ##" 
echo "##           :+:    :+:       :+:    :+:    :+:    :+:   :+:           ##"  
echo "##          +:+    +:+        +:+  +:+     +:+     +:+ +:+             ##"    
echo "##         +#+    +#++:++#    +#++:+      +#+      +#++:               ##"      
echo "##        +#+    +#+        +#+  +#+     +#+       +#+                 ##"        
echo "##       #+#    #+#       #+#    #+#    #+#       #+#                  ##"         
echo "##      ###    #############    ###    ###       ###                   ##"          
echo "##            ::::::::: ::::::::::    :::     :::::::::::::::::::      ##" 
echo "##           :+:    :+::+:         :+: :+:  :+:    :+:   :+:           ##"      
echo "##          +:+    +:++:+        +:+   +:+ +:+          +:+            ##"       
echo "##         +#++:++#+ +#++:++#  +#++:++#++:+#++:++#++   +#+             ##"        
echo "##        +#+    +#++#+       +#+     +#+       +#+   +#+              ##"        
echo "##       #+#    #+##+#       #+#     #+##+#    #+#   #+#               ##"         
echo "##      ######### #############     ### ########    ###                ##"    
echo "##                                                                     ##"
echo "##                                                                     ##"
echo "#########################################################################"
echo "#########################################################################"
echo ""
nxArg=5
if [ "$#" -lt "$nxArg" ];
then
  echo "$0: Missing arguments"
  exit 1
elif [ "$#" -gt "$nxArg" ];
then
  echo "$0: Too many arguments: $@"
  exit 1
else
  echo "Input Arguments:"
  echo "#########################################################################"
  echo "Number of arguments.: $#"
  #echo "List of arguments...: $@"
  #echo "Arg #1..............: $1 (Video File)"
  videoFile=$1
  #echo "Arg #2..............: (local username)"
  #unLocal=$2
  #echo "Arg #3..............: (local pword)"
  #pwLocal=$3
  #echo "Arg #4..............: (local ip)"
  #ipLocal=$4
  #echo "Arg #5..............: (local outdir)"
  #dirLocal=$5
  finSignal=$2
  outDirFinal=$3
  parsFile=$4
  homeDir=$5
  echo "#########################################################################"
fi
BASEDIR=$homeDir
outBase=$homeDir/output
dateTime=$(date +%m-%d-%y-%H-%M-%S-%N) #get date and time of start
fBase=${videoFile%.*}
fBase=${fBase##*/}
outDir=($homeDir/output/$fBase-output-$dateTime) #make unique output directory name/path tagged with date and time
MMOCREnvDir=$homeDir/envs/ocr
video="$(basename $videoFile)" #strip path from video file to make input for mmocr..
mmocrOut_dir=$outDir/out_dir/video_img_dta
configsDir=$homeDir/"envs/ocr/env/lib/python3.8/site-packages/mmocr/configs"
WhspEnvDir=$homeDir/envs/whspr
audioBase=${videoFile%.*}
audioBase=${audioBase##*/}
audioFile=$outDir/out_dir/audio_speech_dta/$audioBase.wav
whsprOut_dir=$outDir/out_dir/audio_speech_dta
if [[ $parsFile == "default" ]]; then
echo ""
echo "Sourcing Default Parameters:"
source $homeDir/defaultPars.sh
else
echo ""
echo "Sourcing Parameters from Input Pars.sh File:"
curDir=$(pwd)
cd $BASEDIR
source $parsFile
cd $curDir
fi
echo "frame_dsrate: $frame_dsrate"
echo "cor_thr: $cor_thr"
echo "detector: $detector"
echo "recognizer: $recognizer"
echo "Detector: $x_merge"
echo "x_merge: $ClustThr_factor"
echo "det_ckpt_in: $det_ckpt_in"
echo "recog_ckpt_in: $recog_ckpt_in"
echo "whspModel: $whspModel"
strtDir=$(pwd)
mkdir $outDir
echo "Created output directory for this job at:" 
echo "$outDir"
echo ""
cp $videoFile $outDir/$video
vid_dir=$outDir #update the video directory to correspond to the output directory
videoFile=$outDir/$video
echo "#########################################################################"
echo "#########################################################################"
echo "###########       EXTRACT TEXT FROM IMAGES WITH MMOCR         ###########"
echo "#########################################################################"
echo "#########################################################################"
echo "Current info on GPU from nvidia-smi:"
echo "===================================================="
nvidia-smi
echo "===================================================="
echo ""
cd $MMOCREnvDir
echo "activating mmocr venv ..."
echo ""
source env/bin/activate
cd env
echo "Beginning the MMOCR Pipeline to Detect Text in Image Frames:"
echo "======================================================="
python ./lib/python3.8/site-packages/lecxr_text_v3.py $vid_dir $video $frame_dsrate $cor_thr $detector $recognizer $x_merge $ClustThr_factor $det_ckpt_in $recog_ckpt_in $configsDir
echo "======================================================="
echo "MMOCR Pipeline Completed ..."
echo ""
echo "deactivating mmocr venv ..."
echo ""
deactivate
echo "#########################################################################"
echo "#########################################################################"
echo "###########       EXTRACT TEXT FROM AUDIO WITH WHISPER        ###########"
echo "#########################################################################"
echo "#########################################################################"
module load ffmpeg
echo "Current info on GPU from nvidia-smi:"
echo "===================================================="
nvidia-smi
echo "===================================================="
echo ""
cd $WhspEnvDir
echo "activating whisper virtualenv ..."
echo ""
source env/bin/activate
echo "Recognizing and Transcribing Speech in $audioFile Using OpenAI's Whisper"
echo "(currently using the $whspModel model)" 
echo ""
echo "Bash Command Issued to Whisper:"
echo "whisper $audioFile --model $whspModel --output_dir $whsprOut_dir --language English"
echo ""
echo "Whisper Model Output:"
echo "======================================================="
whisper $audioFile --model $whspModel --output_dir $whsprOut_dir --language English
mv $whsprOut_dir/$audioBase.wav.tsv $whsprOut_dir/$audioBase.tsv
mv $whsprOut_dir/$audioBase.wav.json $whsprOut_dir/$audioBase.json
mv $whsprOut_dir/$audioBase.wav.srt $whsprOut_dir/$audioBase.srt
mv $whsprOut_dir/$audioBase.wav.txt $whsprOut_dir/$audioBase.txt
mv $whsprOut_dir/$audioBase.wav.vtt $whsprOut_dir/$audioBase.vtt
echo "======================================================="
echo "Whisper Audio Transcription Complete ..."
echo ""
echo "deactivating whisper virtualenv ..."
echo ""
deactivate
whsprFile=$whsprOut_dir/$audioBase.tsv
mmocrTag="_ufTxt-Time"
mmocrFile=$mmocrOut_dir/$audioBase$mmocrTag.csv
cd $homeDir
source envs/ocr/env/bin/activate
python ./WhsprOcrCombine.py $whsprFile $mmocrFile $outDir
deactivate
cd $strtDir
echo "Ending at $(date)"
cd $outBase
tar -czvf $fBase-output-$dateTime.tar.gz $fBase-output-$dateTime
mkdir $outBase/$finSignal
mv $outBase/$fBase-output-$dateTime.tar.gz $outBase/$finSignal/output-$dateTime.tar.gz #move final zipped data into "end-signal" directory..
logfile=$(basename "$videoFile").out
cp $BASEDIR/output/$logfile $outBase/$finSignal/$dateTime-dtaScrape_$logfile #move log file into "end-signal" directory..
rm -rf $outDir #get rid of original/unzipped data dir..
cd $outBase/$finSignal/ #enter final output dir..
sig="done"
echo $sig > DONE
cd $strtDir
cd $BASEDIR/output/
rm $logfile
cd $BASEDIR/input
rm $video # remove video from input
cd $strtDir
