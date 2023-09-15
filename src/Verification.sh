#!/bin/bash
#
FILES="0";
#
declare -a DATASETS=("DS1" "DS2" "DS3" "DS4" "DS5" "DS6" "DS7" "DS8" "DS9" "DS10" "DS11" "DS12" "DS13"  "DS14"  "DS15"  "DS16" "DS17"  "DS18"  "DS19"  "DS20"  "DS21"  "DS22"  "DS23"  "DS24"  "DS25"  "DS26"  "DS27"  "DS28"  "DS29"  "DS30"  "DS31"  "DS32"  "DS33"  "DS34"  "DS35"  "DS36"  "DS37"  "DS38"  "DS39"  "DS40"  "DS41"  "DS42"  "DS43"  "DS44"  "DS45"  "DS46"  "DS47"  "DS48"  "DS49"  "DS50"  "DS51"  "DS52"  "DS53"  "DS54"  "DS55"  "DS56"  "DS57"  "DS58"  "DS59"  "DS60"  "DS61"  "DS62" "DS63"  "DS64"  "DS65");
#
declare -a VIRUSES=("B19" "HPV" "VZV" "MCPyV" "HHV6B" "POLY7" "EBV" "CMV" "MT");
#
RUN_SPADES=0; 
RUN_METASPADES=0; 
RUN_METAVIRALSPADES=0; 
RUN_CORONASPADES=0; 
RUN_QURE=0; 
RUN_TRACESPIPELITE=0; 
RUN_TRACESPIPE=0; 
RUN_QVG=0; 
RUN_VPIPE=0; 
RUN_VISPA=0; 
RUN_LAZYPIPE=0; 
RUN_PEHAPLO=0; 
RUN_VIRGENA=0; 
RUN_SSAKE=0;
RUN_HAPLOFLOW=0;
################################################################################
#
SHOW_MENU () {
  echo " -------------------------------------------------------------------- ";
  echo "                                                                      ";
  echo " Verification.sh : Verification version v0.1                          ";
  echo "                                                                      ";
  echo " Verifies if the tools were successfully installed and the datasets   ";
  echo " were generated.                                                      ";  
  echo "                                                                      ";
  echo " Program options ---------------------------------------------------- ";
  echo "                                                                      ";
  echo " -h, --help                    Show this,                             ";
  echo " -t, --tools                   Checks if the all tools are installed, ";
  echo " -d, --datasets                Checks if the datasets were generated  ";
  echo "                               and generates them if they do not      ";
  echo "                               exist.                                 ";
  echo "                                                                      ";
  echo " --coronaspades                Checks installation of coronaSPAdes,   ";
  echo " --haploflow                   Checks installation of Haploflow,      ";
  echo " --lazypipe                    Checks installation of LAZYPIPE,       ";
  echo " --metaspades                  Checks installation of metaSPAdes,     ";
  echo " --metaviralspades             Checks installation of metaviralSPAdes,";
  echo " --pehaplo                     Checks installation of PEHaplo,        ";
  echo " --qure                        Checks installation of QuRe,           ";
  echo " --qvg                         Checks installation of QVG,            ";
  echo " --spades                      Checks installation of SPAdes,         ";
  echo " --ssake                       Checks installation of SSAKE,          ";
  echo " --tracespipe                  Checks installation of TRACESPipe,     ";
  echo " --tracespipelite              Checks installation of TRACESPipeLite, ";
  echo " --virgena                     Checks installation of VirGenA,        ";
  echo " --vispa                       Checks installation of ViSpA,          ";
  echo " --vpipe                       Checks installation of V-pipe.         ";
  echo "                                                                      ";
  echo " --all                         Checks all tools and datasets.          ";
  echo "                                                                      ";
  echo " Examples ----------------------------------------------------------- ";
  echo "                                                                      ";
  echo " - Checks tools and datasets                                          ";
  echo "  ./Verification.sh --all                                             ";
  echo "                                                                      ";
  echo " -------------------------------------------------------------------- ";
  }
#
################################################################################
#
if [[ "$#" -lt 1 ]];
  then
  HELP=1;
  fi
#
POSITIONAL=();
#
while [[ $# -gt 0 ]]
  do
  i="$1";
  case $i in
    -h|--help|?)
      HELP=1;
      shift;
    ;;
    --coronaspades)
      RUN_CORONASPADES=1;
      shift
    ;;
    --haploflow)
      RUN_HAPLOFLOW=1;
      shift
    ;;
    --lazypipe)
      RUN_LAZYPIPE=1;
      shift
    ;;
    --metaspades)
      RUN_METASPADES=1;
      shift
    ;;
    --metaviralspades)
      RUN_METAVIRALSPADES=1;
      shift
    ;;
    --pehaplo)
      RUN_PEHAPLO=1;
      shift
    ;;
    --qure)
      RUN_QURE=1;
      shift
    ;;
    --qvg)
      RUN_QVG=1;
      shift
    ;;
    --spades)
      RUN_SPADES=1;
      shift
    ;;
    --ssake)
      RUN_SSAKE=1;
      shift
    ;;
    --tracespipe)
      RUN_TRACESPIPE=1;
      shift
    ;;
    --tracespipelite)
      RUN_TRACESPIPELITE=1;
      shift
    ;;
    --virgena)
      RUN_VIRGENA=1;
      shift
    ;;
    --vispa)
      RUN_VISPA=1;
      shift
    ;;
    --vpipe)
      RUN_VPIPE=1;
      shift
    ;;
    --all)
      RUN_CORONASPADES=1;
      RUN_HAPLOFLOW=1;
      RUN_LAZYPIPE=1;
      RUN_METASPADES=1;
      RUN_METAVIRALSPADES=1;
      RUN_PEHAPLO=1;
      RUN_QURE=1;
      RUN_QVG=1;
      RUN_SPADES=1;
      RUN_SSAKE=1;
      RUN_TRACESPIPE=1;
      RUN_TRACESPIPELITE=1;
      RUN_VIRGENA=1;
      RUN_VISPA=1;
      RUN_VPIPE=1;
      FILES=1;
      shift;
    ;;
    -t|--tools)
      RUN_CORONASPADES=1;
      RUN_HAPLOFLOW=1;
      RUN_LAZYPIPE=1;
      RUN_METASPADES=1;
      RUN_METAVIRALSPADES=1;
      RUN_PEHAPLO=1;
      RUN_QURE=1;
      RUN_QVG=1;
      RUN_SPADES=1;
      RUN_SSAKE=1;
      RUN_TRACESPIPE=1;
      RUN_TRACESPIPELITE=1;
      RUN_VIRGENA=1;
      RUN_VISPA=1;
      RUN_VPIPE=1;
      shift;
    ;;
    -d|--datasets|--dataset)
      FILES=1;
      shift;
    ;;
    -*) # unknown option with small
    echo "Invalid arg ($1)!";
    echo "For help, try: ./Verification.sh -h"
    exit 1;
    ;;
  esac
  done
#
set -- "${POSITIONAL[@]}" # restore positional parameters
#
################################################################################
#
if [[ "$HELP" -eq "1" ]];
  then
  SHOW_MENU;
  exit;
  fi
#
################################################################################
#
PROGRAM_EXISTS () {
  printf "Checking $3 ... ";
  if ! [ -x "$(command -v $1)" ];
    then
    echo -e "\e[41mERROR\e[49m: $3 is not installed." >&2;
    echo -e "\e[42mTIP\e[49m: Try to reinstall $3 using ./Installation.sh --$2" >&2;
    #exit 1;
    else
    echo -e "\e[42mSUCCESS!\e[49m";
    fi
  }
  
PROGRAM_EXISTS_V2 () {
  printf "Checking $3 ... ";
  if ! [ -x "$(find . -name $1)" ];
    then
    echo -e "\e[41mERROR\e[49m: $3 is not installed." >&2;
    echo -e "\e[42mTIP\e[49m: Try to reinstall $3 using ./Installation.sh --$2" >&2;
    #exit 1;
    else
    echo -e "\e[42mSUCCESS!\e[49m";
    fi
  }
#
################################################################################
#
if [[ "$RUN_SPADES" -eq "1" ]];
  then
    #printf "Starting tool verificaton...\n"
    eval "$(conda shell.bash hook)"
    conda activate spades
    PROGRAM_EXISTS "spades.py" spades SPAdes;
fi
#
if [[ "$RUN_CORONASPADES" -eq "1" ]];
  then
    #printf "Starting tool verificaton...\n"
    eval "$(conda shell.bash hook)"
    conda activate spades
    PROGRAM_EXISTS "coronaspades.py" coronaspades coronaSPAdes;
fi
#
if [[ "$RUN_METASPADES" -eq "1" ]];
  then
    #printf "Starting tool verificaton...\n"
    eval "$(conda shell.bash hook)"
    conda activate spades
    PROGRAM_EXISTS "metaspades.py" metaspades metaSPAdes;
fi
#
if [[ "$RUN_METAVIRALSPADES" -eq "1" ]];
  then
    #printf "Starting tool verificaton...\n"
    eval "$(conda shell.bash hook)"
    conda activate spades
    PROGRAM_EXISTS "metaviralspades.py" metaviralspades metaviralSPAdes;
fi
#
if [[ "$RUN_HAPLOFLOW" -eq "1" ]];
  then
    #printf "Starting tool verificaton...\n"
    eval "$(conda shell.bash hook)"
    conda activate haploflow
    PROGRAM_EXISTS "haploflow" haploflow Haploflow; 
fi
#
if [[ "$RUN_LAZYPIPE" -eq "1" ]];
  then
    #printf "Starting tool verificaton...\n"
    eval "$(conda shell.bash hook)"
    conda activate blast
    conda activate --stack lazypipe
    PROGRAM_EXISTS_V2 "lazypipe.pl" lazypipe LAZYPIPE2;
fi
#
if [[ "$RUN_PEHAPLO" -eq "1" ]];
  then
    #printf "Starting tool verificaton...\n"
    eval "$(conda shell.bash hook)"
    conda activate bio2
    PROGRAM_EXISTS "pehaplo.py" pehaplo PEHaplo;
fi
#    
if [[ "$RUN_QURE" -eq "1" ]];
  then
    #printf "Starting tool verificaton...\n"
    eval "$(conda shell.bash hook)"
    conda activate java-env
    PROGRAM_EXISTS_V2 "QuRe_v0.99971" qure QuRe; 
fi    
#
if [[ "$RUN_QVG" -eq "1" ]];
  then
    #printf "Starting tool verificaton...\n"
    eval "$(conda shell.bash hook)"
    conda activate qvg
    PROGRAM_EXISTS_V2 "QVG.sh" qvg QVG;
fi    
#    
if [[ "$RUN_SSAKE" -eq "1" ]];
  then
    #printf "Starting tool verificaton...\n"
    eval "$(conda shell.bash hook)"
    conda activate base
    PROGRAM_EXISTS "runSSAKE.sh" ssake SSAKE;
fi    
#
if [[ "$RUN_TRACESPIPELITE" -eq "1" ]];
  then
    #printf "Starting tool verificaton...\n"
    eval "$(conda shell.bash hook)"
    conda activate tracespipelite
    PROGRAM_EXISTS_V2 "TRACESPipeLite.sh" tracespipelite TRACESPipeLite;
fi    
#
if [[ "$RUN_TRACESPIPE" -eq "1" ]];
  then
    #printf "Starting tool verificaton...\n"
    eval "$(conda shell.bash hook)"
    conda activate tracespipe
    PROGRAM_EXISTS_V2 "TRACESPipe.sh" tracespipe TRACESPipe;
fi    
#
if [[ "$RUN_VIRGENA" -eq "1" ]];
  then
    #printf "Starting tool verificaton...\n"
    eval "$(conda shell.bash hook)"
    conda activate java-env   
    PROGRAM_EXISTS_V2 "VirGenA.jar" virgena VirGenA;
fi 
#
if [[ "$RUN_VISPA" -eq "1" ]];
  then
    #printf "Starting tool verificaton...\n"
    eval "$(conda shell.bash hook)"
    conda activate vispa
    PROGRAM_EXISTS_V2 "main_mosaik.bash" vispa ViSpA;
fi  
#
if [[ "$RUN_VPIPE" -eq "1" ]];
  then
    #printf "Starting tool verificaton...\n"
    eval "$(conda shell.bash hook)"
    conda activate base
    PROGRAM_EXISTS_V2 "vpipe" vpipe V-Pipe; 
fi 
#
#
#
if [[ "$FILES" -eq "1" ]];
  then
    printf "Starting file verificaton...\n"
    for dataset in "${DATASETS[@]}"
      do
      if [[ -f ${dataset}.fa ]]; then
        if [[ -f ${dataset}_1.fq ]]; then
          if [[ -f ${dataset}_2.fq ]]; then
            printf "\e[42m${dataset} exists\e[49m\n"
          else
            printf "\e[41m${dataset} with errors\e[49m\n"
          fi
        else
          printf "\e[41m${dataset} with errors\e[49m\n"
        fi
      else
        printf "\e[41m${dataset} with errors\e[49m\n"
      fi
    done 
    
    for virus in "${VIRUSES[@]}"
      do
      if [[ -f ${virus}.fa ]]; then
        printf "\e[42m${virus} exists\e[49m\n"
      else
        printf "\e[41m${virus} with errors\e[49m\n"
      fi
    done 
fi
#
