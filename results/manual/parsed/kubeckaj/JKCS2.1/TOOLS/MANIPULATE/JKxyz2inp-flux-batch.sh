#!/bin/bash
#FLUX: --job-name=carnivorous-house-4753
#FLUX: --urgency=16

function help {
  echo "THIS IS HELP:"
  echo """
  JKxyz2inp [OPTIONS] [FILES]
  OPTIONS:
   -help ............ print this help and exit
   -m,-method \"XX\" .. use XX as an input line
   -mem \"X\" ......... memory specification
   -c,-cpu \"x\" ...... specify number of CPUs=x
   -char,-ch,-q \"x\" . specify system charge ch=x
   -mult \"x\" ........ specify system multiplicity m=x
   OTHERS: -time(-t),-partition(-par),-add
  FILES:
    xyz file(s) is(are) expected
  EXAMPLES:
     JKxyz2inp
     JKxyz2inp -ch 1 -m 2 1.xyz
     JKxyz2inp -method \"! B3LYP 6-31+g* opt\" *.xyz
     JKxyz2inp -mem1 3000 -cpu 8 -m \"! DLPNO-CCSD(T) aug-cc-pvtz aug-cc-pvtz/C GRID4 nofinalgrid TightPNO TightSCF NOPOP NOPRINTMOS\"
  """
  exit
}
prossu=8
muisti1=3000
muisti2=4000
partition="serial"
aika=72:00:00
charge=+0
multiplicity=1
method="! DFT OPT FREQ PW91 6-31++g** GRID4 nofinalgrid TightPNO TightSCF NOPOP NOPRINTMOS"
next=0
Qextrainput=0
QmaxIter=500
for i in "$@"
do
  if [ "$i" == "-help" ]; then help;exit;fi
  firstletter=`echo $i | cut -c 1`
  if [ "$firstletter" == "-" ] || [ $next -eq 1 ]
  then
    #echo "first letter = $firstletter , input = $i "
    ### -method "X X X"
    if [ "$last" == "-method" ]
    then
      method="$i"
      last=""
      next=0
      continue
    fi
    if [ "$i" == "-method" ] || [ "$i" == "-m" ]
    then
      next=1
      last="-method"
      continue
    fi
    ### -cpu X
    if [ "$last" == "-cpu" ]
    then
      prossu=$i
      last=""
      next=0
      continue
    fi
    if [ "$i" == "-cpu" ] || [ "$i" == "-c" ]
    then
      next=1
      last="-cpu"
      continue
    fi
    ### -ch -x
    if [ "$last" == "-ch" ]
    then
      charge=$i
      last=""
      next=0
      continue
    fi
    if [ "$i" == "-char" ] || [ "$i" == "-ch" ] || [ "$i" == "-q" ]
    then
      next=1
      last="-ch"
      continue
    fi
    ### -partition -x
    if [ "$last" == "-par" ]
    then
      partition=$i
      last=""
      next=0
      continue
    fi
    if [ "$i" == "-par" ] || [ "$i" == "-partition" ]
    then
      next=1
      last="-par"
      continue
    fi
    ### -time -x
    if [ "$last" == "-time" ]
    then
      aika=$i
      last=""
      next=0
      continue
    fi
    if [ "$i" == "-time" ] || [ "$i" == "-t" ]
    then
      next=1
      last="-time"
      continue
    fi
    ### -m -x
    if [ "$last" == "-mult" ]
    then
      multiplicity=$i
      last=""
      next=0
      continue
    fi
    if [ "$i" == "-mult" ]
    then
      next=1
      last="-mult"
      continue
    fi
    ### -mem -x
    if [ "$last" == "-mem" ]
    then
      muisti1=$i
      muisti2=$i
      last=""
      next=0
      continue
    fi
    if [ "$i" == "-mem" ]
    then
      next=1
      last="-mem"
      continue
    fi
    ### -mem1 -x
    if [ "$last" == "-mem1" ]
    then
      muisti1=$i
      last=""
      next=0
      continue
    fi
    if [ "$i" == "-mem1" ]
    then
      next=1
      last="-mem1"
      continue
    fi
    ### -mem2 -x
    if [ "$last" == "-mem2" ]
    then
      muisti2=$i
      last=""
      next=0
      continue
    fi
    if [ "$i" == "-mem2" ]
    then
      next=1
      last="-mem2"
      continue
    fi
    ### $Qextrainput
    if [ "$i" == "-ea" ] || [ "$i" == "-extrainput" ] || [ "$i" == "-add" ]
    then
      last="-ea"
      next=1
      continue
    fi
    if [ "$last" == "-ea" ]
    then
      if [ "$i" == "maxIter" ] || [ "$i" == "maxiter" ]
      then
        Qextrainput="maxiter"
        last="maxiter"
      else  
        Qextrainput="$i"
        last=""
        next=0
      fi
      continue
    fi
    if [ "$last" == "maxiter" ]
    then
      QmaxIter=$i
      last=""
      next=0
      continue
    fi
    ###   
  else
    ### UPDATE LOG FILES
    filesin+="$i "
  fi
done
if [ -z "$filesin" ]
then
  filesin=`ls *.xyz`
fi
if [ -e ~/.JKCSusersetup.txt ]; then source ~/.JKCSusersetup.txt; fi
if [ ! -z "$PATH_ORCA" ]; then orca=$PATH_ORCA;fi
scriptpath=$(dirname $0)
toolspath="$scriptpath/../TOOLS"
for i in $filesin;
do 
  echo "$method
%pal nprocs $prossu
    end
%Maxcore $muisti1" > $(basename $i .xyz).inp
  ######## EXTRA INPUT
  if [ "$Qextrainput" != "0" ]
  then
    if [ -e "$Qextrainput" ]
    then
      cat $Qextrainput >> $(basename $i .xyz).inp
    elif [ "$Qextrainput" == "I" ]
    then
      echo """%basis
	NewGTO I \"aug-cc-pVTZ-PP\" end
	NewECP I \"SK-MCDHF-RSC\" end
end""" >> $(basename $i .xyz).inp
    elif [ -e "$Qextrainput" ]
    then
      cat "$Qextrainput" >> $(basename $i .xyz).inp
    fi
    if [ "$Qextrainput" == "I" ] || [ "$Qextrainput" == "maxiter" ]
    then
      echo """%geom
        maxIter $QmaxIter
end""" >> $(basename $i .xyz).inp
    fi
  fi
  ########## END OF EXTRA INPUT
  echo "* xyzfile $charge $multiplicity $(basename $i .xyz).xyz
  " >> $(basename $i .xyz).inp
done
