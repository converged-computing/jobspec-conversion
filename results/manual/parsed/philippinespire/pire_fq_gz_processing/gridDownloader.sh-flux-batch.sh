#!/bin/bash
#FLUX: --job-name=gridDown
#FLUX: -n=40
#FLUX: --exclusive
#FLUX: -t=0
#FLUX: --urgency=16

export SINGULARITY_BIND='/home/e1garcia  #odu'

export SINGULARITY_BIND=/home/e1garcia  #odu
OUTDIR=$1
LINK=$(echo $2 | sed 's/\/$//')
PROTOCOL=$3
cd $OUTDIR
if [[ "$PROTOCOL" == "wget" ]]; then
        COMMAND="wget -c -P"
	echo -e "Downloading using:\nprotocol= $PROTOCOL\ncommand= $COMMAND\n\n"
elif [[ "$PROTOCOL" == "wget1" ]]; then
        COMMAND="wget --secure-protocol=TLSv1_2 -c -P"    #yes, TLSv1_2 first
        echo -e "Downloading using:\nprotocol= $PROTOCOL\ncommand= $COMMAND\n\n"
elif [[ "$PROTOCOL" == "wget2" ]]; then
        COMMAND="wget --secure-protocol=TLSv1_1 -c -P"
	echo -e "Downloading using:\nprotocol= $PROTOCOL\ncommand= $COMMAND\n\n"
elif [[ "$PROTOCOL" == "curl" ]]; then
        COMMAND="curl -L -O -C - --output-dir"
	echo -e "Downloading using:\nprotocol= $PROTOCOL\ncommand= $COMMAND\n\n"
elif [[ -z "$PROTOCOL" ]]; then
        COMMAND="wget -c -P"
	echo -e "Protocol not specified. Downloading using:\nprotocol=wget\ncommand=$COMMAND\n\nIf you meant to run a different protocol please provite it as the third argument\nProtocol options= wget, wget1, wget2, curl. Try in this order\n\n."
else
        echo -e "Protocol not recognized. Options are: wget, wget1, wget2, curl. Please provide one of these as the third argument. Try them in the same order\n\n"
fi 
$COMMAND $OUTDIR $LINK/tamucc_files.txt
NCOL=$(cat tamucc_files.txt | tail -n1 | awk '{print NF}')
if [[ $NCOL -eq 9 ]]
then 
cat $OUTDIR/tamucc_files.txt | grep '^[-d]' | tr -s " " | cut -d " " -f9 | parallel --no-notice -kj20 $COMMAND $OUTDIR $LINK/{}
echo -e "\nFirst download completed.\n\nDownloading again in case partial downloads\n" 
cat $OUTDIR/tamucc_files.txt | grep '^[-d]' | tr -s " " | cut -d " " -f9 | parallel --no-notice -kj20 $COMMAND $OUTDIR $LINK/{}
echo -e "\nSecond download completed" 
cd $OUTDIR
echo -e "\nIf your download did not work at all, click on the link to the files and visually check in your browser that there is a file named tamucc_files.txt or contact Eric e1garcia@odu.edu"
elif [[ $NCOL -eq 1 ]] 
then
cat $OUTDIR/tamucc_files.txt | parallel --no-notice -kj20 $COMMAND $OUTDIR $LINK/{}
echo -e "\nFirst download completed.\n\nDownloading again in case partial downloads\n" 
cat $OUTDIR/tamucc_files.txt | parallel --no-notice -kj20 $COMMAND $OUTDIR $LINK/{}
echo -e "\nSecond download completed" 
echo -e "\nThe tamucc_files.txt does not have file size information (it was created with a simple ls) so this script cannot compare the size of files after download.\nPlease visually compare the size of downloaded files with what is posted in the web browser from the http link\n\nIf you have a lot of files, it might be worth asking Sharon or someone at TAMUCC to recreate the tamucc_files.txt with an ls -ltrh, in which case this script will automatically check the size of files before and after download"
echo -e "\nIf your download did not work at all, click on the link to the files and visually check in your browser that there is a file named tamucc_files.txt"
fi
echo  -e "\ngridDownloader.sh is done. Please run checkFQ.sh to check the size and format of files"
