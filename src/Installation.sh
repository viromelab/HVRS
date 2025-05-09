#!/bin/bash
#
#
#
PYTHON2_PATH="#!/usr/bin/python2";
CONDA_PREFIX=$HOME/miniconda3;
#
# INSTALL SIMULATION AND EVALUATION TOOLS:
#
INSTALL_TOOLS=0;
INSTALL_MINICONDA=0;
#RUN_SHORAH=0;
RUN_QURE=0; #t
RUN_SAVAGE=0; #
#RUN_QSDPR=0;
RUN_SPADES=0; #t
RUN_METASPADES=0; #t
RUN_METAVIRALSPADES=0; #t
RUN_CORONASPADES=0; #t
RUN_VIADBG=0; #np, boost err
RUN_VIRUSVG=0;
RUN_VGFLOW=0;
#RUN_PREDICTHAPLO=0;
RUN_TRACESPIPELITE=0; #t
RUN_TRACESPIPE=0; #t
RUN_ASPIRE=0;
RUN_QVG=0; #t--
RUN_VPIPE=0;
RUN_STRAINLINE=0;
RUN_HAPHPIPE=0;
#RUN_ABAYESQR=0;
#RUN_HAPLOCLIQUE=0;
RUN_VISPA=0; #t
#RUN_QUASIRECOMB=0; 
RUN_LAZYPIPE=0; #w, needs testing
#RUN_VIQUAS=0; #np
RUN_MLEHAPLO=0;
RUN_PEHAPLO=0; #t
RUN_REGRESSHAPLO=0;
RUN_CLIQUESNV=0; 
RUN_IVA=0; 
RUN_PRICE=0;
RUN_VIRGENA=0; #t
RUN_TARVIR=0;
RUN_VIP=0;
RUN_DRVM=0; 
RUN_SSAKE=0; #t
RUN_VIRALFLYE=0;
RUN_ENSEMBLEASSEMBLER=0; #np
RUN_HAPLOFLOW=0;
#RUN_TENSQR=0; 
#RUN_ARAPANS=0;
RUN_VIQUF_DOCKER=0;
RUN_VIQUF=0; 
RUN_IRMA=0; 
#
################################################################################
#
install_samtools () {
  wget https://github.com/samtools/samtools/releases/download/1.16.1/samtools-1.16.1.tar.bz2
  tar xjf samtools-1.16.1.tar.bz2
  rm -rf samtools-1.16.1.tar.bz2
  cd samtools-1.16.1
  ./configure
  sudo make
  sudo make install
  cd ..
}

install_conda() {
  rm -rf Miniconda3-latest-Linux-x86_64.sh
  wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
  chmod +x Miniconda3-latest-Linux-x86_64.sh
  bash Miniconda3-latest-Linux-x86_64.sh
  printf "Please close and reopen this terminal \n\n"
  read a
}

install_docker() {
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
}

SHOW_MENU () {
  echo " ------------------------------------------------------------------ ";
  echo "                                                                    ";
  echo " Installation.sh : Installation script for HVRS                     ";
  echo "                                                                    ";
  echo " Script to install all of the tools necesary to run HVRS.           "; 
  echo "                                                                    ";
  echo " Program options -------------------------------------------------- ";
  echo "                                                                    ";
  echo " -h, --help                    Show this,                           ";
  echo " --miniconda                   Install Miniconda,                   ";
  echo " --all                         Install all tools, except Miniconda. ";
  echo "                                                                    ";
  echo " --coronaspades                Install coronaSPAdes,                ";
  echo " --haploflow                   Install Haploflow,                   ";
  echo " --irma                        Install IRMA,                        ";
  echo " --lazypipe                    Install LAZYPIPE,                    ";
  echo " --metaspades                  Install metaSPAdes,                  ";
  echo " --metaviralspades             Install metaviralSPAdes,             ";
  echo " --pehaplo                     Install PEHaplo,                     ";
  echo " --qure                        Install QuRe,                        ";
  echo " --qvg                         Install QVG,                         ";
  echo " --spades                      Install SPAdes,                      ";
  echo " --ssake                       Install SSAKE,                       ";
  echo " --tracespipe                  Install TRACESPipe,                  ";
  echo " --tracespipelite              Install TRACESPipeLite,              ";
  echo " --virgena                     Install VirGenA,                     ";
  echo " --vispa                       Install ViSpA,                       ";
  echo " --vpipe                       Install V-pipe,                      ";
  echo " --tools                       Install other tools used in the      ";
  echo "                               benchmark.                           ";
  echo "                                                                    ";
  echo " Examples --------------------------------------------------------- ";
  echo "                                                                    ";
  echo " - Install Miniconda                                                ";
  echo "  ./Installation.sh --miniconda                                     ";
  echo "                                                                    "; 
  echo " - Install all tools (except Miniconda)                             ";
  echo "  ./Installation.sh --all                                           ";
  echo "                                                                    ";
  echo " ------------------------------------------------------------------ ";
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
      shift
    ;;
    --miniconda)
      INSTALL_TOOLS=0;
      RUN_HAPLOFLOW=0;
      RUN_LAZYPIPE=0;
      RUN_PEHAPLO=0;
      RUN_QURE=0;
      RUN_QVG=0;
      RUN_SPADES=0;
      RUN_SSAKE=0;
      RUN_TRACESPIPE=0;
      RUN_TRACESPIPELITE=0;
      RUN_VIRGENA=0;
      RUN_VISPA=0;
      RUN_VPIPE=0;
      INSTALL_MINICONDA=1;      
      shift
    ;;
    --tools)
      INSTALL_TOOLS=1;
      INSTALL_MINICONDA=0;
      shift
    ;;
    --coronaspades)
      RUN_CORONASPADES=1;
      INSTALL_MINICONDA=0;
      shift
    ;;
    --haploflow)
      RUN_HAPLOFLOW=1;
      INSTALL_MINICONDA=0;
      shift
    ;;
    --irma)
      RUN_IRMA=1;
      INSTALL_MINICONDA=0;
      shift
    ;;
    --lazypipe)
      RUN_LAZYPIPE=1;
      INSTALL_MINICONDA=0;
      shift
    ;;
    --metaspades)
      RUN_METASPADES=1;
      INSTALL_MINICONDA=0;
      shift
    ;;
    --metaviralspades)
      RUN_METAVIRALSPADES=1;
      INSTALL_MINICONDA=0;
      shift
    ;;
    --pehaplo)
      RUN_PEHAPLO=1;
      INSTALL_MINICONDA=0;
      shift
    ;;
    --qure)
      RUN_QURE=1;
      INSTALL_MINICONDA=0;
      shift
    ;;
    --qvg)
      RUN_QVG=1;
      INSTALL_MINICONDA=0;
      shift
    ;;
    --spades)
      RUN_SPADES=1;
      INSTALL_MINICONDA=0;
      shift
    ;;
    --ssake)
      RUN_SSAKE=1;
      INSTALL_MINICONDA=0;
      shift
    ;;
    --tracespipe)
      RUN_TRACESPIPE=1;
      INSTALL_MINICONDA=0;
      shift
    ;;
    --tracespipelite)
      RUN_TRACESPIPELITE=1;
      INSTALL_MINICONDA=0;
      shift
    ;;
    --virgena)
      RUN_VIRGENA=1;
      INSTALL_MINICONDA=0;
      shift
    ;;
    --vispa)
      RUN_VISPA=1;
      INSTALL_MINICONDA=0;
      shift
    ;;
    --vpipe)
      RUN_VPIPE=1;
      INSTALL_MINICONDA=0;
      shift
    ;;
    --all)
      INSTALL_TOOLS=1;
      RUN_HAPLOFLOW=1;
      RUN_IRMA=1;
      RUN_LAZYPIPE=1;
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
      INSTALL_MINICONDA=0;
      shift
    ;;
    -*) # unknown option with small
    echo "Invalid arg ($1)!";
    echo "For help, try: ./Installation.sh -h"
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
if [[ "$INSTALL_MINICONDA" -eq "1" ]] 
  then
  printf "Installing Miniconda\n\n"
  install_conda
fi

if [[ "$INSTALL_TOOLS" -eq "1" ]] 
  then
  printf "Installing tools\n\n"
  printf "Installing dos2unix\n\n"
  sudo apt -y install dos2unix
  printf "Installing git\n\n"
  sudo apt -y install git
  sudo apt install gawk -y
  conda update conda -y
  conda install --solver=classic conda-forge::conda-libmamba-solver conda-forge::libmamba conda-forge::libmambapy conda-forge::libarchive -y
  conda config --add channels defaults
  conda config --add channels conda-forge
  conda config --add channels bioconda
  conda config --add channels kennethshang
  conda config --add channels anaconda
  conda install -c cobilab -y gto
  #conda install -c bioconda -y quast
  printf "Installing ART\n\n"
  conda install -c conda-forge -y gsl=2.5
  conda install -c bioconda -y art
  ln -s $CONDA_PREFIX/lib/libgsl.so.27 $CONDA_PREFIX/lib/libgsl.so.25
  printf "Installing AlcoR\n\n"
  #conda install -n base conda-libmamba-solver -y
  conda install -c conda-forge libgcc-ng -y
  conda install -y -c bioconda alcor #--solver=libmamba
  printf "Installing G++\n\n"
  sudo apt-get -y install g++
  printf "Installing Samtools\n\n"
  #install_samtools
  conda install -c bioconda -y samtools
  printf "Installing make\n\n"
  sudo apt -y install make
  printf "Installing Java\n\n"
  sudo apt -y install default-jre  
  #
  eval "$(conda shell.bash hook)"
  conda create -n evaluation -y
  conda activate evaluation 
  conda install -c cobilab -y gto
  printf "Installing ART\n\n"
  conda install -c conda-forge -y gsl=2.5
  conda install -c bioconda -y art
  ln -s $CONDA_PREFIX/lib/libgsl.so.27 $CONDA_PREFIX/lib/libgsl.so.25
  printf "Installing MUMMER4\n\n"
  conda install -c bioconda -y mummer4  
  printf "Installing GeCo3\n\n"
  conda install -c bioconda -y geco3 
  printf "Installing seqkit\n\n"
  conda install -c bioconda seqkit -y
  conda activate base
  #
  printf "Installing gnuplot\n\n"
  conda install -c conda-forge gnuplot -y
  #printf "Installing Docker\n\n"
  #install_docker  
  sudo apt -y install curl
  #printf "Installing mamba\n\n"
  #install_mamba 
  #FALCON-meta
  conda create -n falcon -y
  conda activate falcon 
  conda install -c cobilab -y gto
  conda install -c cobilab falcon -y
  conda activate base  
  #SRA tools
  wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/3.0.7/sratoolkit.3.0.7-ubuntu64.tar.gz
  tar -xf sratoolkit.3.0.7-ubuntu64.tar.gz
  #QVG
  sudo apt-get install libtabixpp0
fi
#
#
# INSTALL ASSEMBLY TOOLS:
#
#
#spades, metaspades, metaviralspades and coronaspades
if [[ "$RUN_SPADES" -eq "1" ]] || [[ "$RUN_METAVIRALSPADES" -eq "1" ]] || [[ "$RUN_CORONASPADES" -eq "1" ]] || [[ "$RUN_METASPADES" -eq "1" ]] 
  then
  printf "Installing SPAdes, metaSPAdes, metaviralSPAdes and coronaSPAdes\n\n"
  eval "$(conda shell.bash hook)"
  conda create -y -n spades
  conda activate spades
  conda install -c bioconda -y spades=3.13.0 python=3.8 --solver=classic
  #conda install spades=3.15 -y --solver=classic
  conda install spades=3.13.0 --force-reinstall -y
  conda activate base
fi

#SAVAGE
if [[ "$RUN_SAVAGE" -eq "1" ]] 
  then
  printf "Installing SAVAGE\n\n"
  eval "$(conda shell.bash hook)"
  conda create -y -n savage
  conda activate savage
  conda install -c bioconda -c conda-forge -y boost savage
  conda activate base
fi

#ShoRAH 
if [[ "$RUN_SHORAH" -eq "1" ]] 
  then
  printf "Installing ShoRAH\n\n"
  eval "$(conda shell.bash hook)"
  conda create -y -n shorah
  conda activate shorah
  conda install -c bioconda -y shorah
  conda activate base
fi

#qsdpr
if [[ "$RUN_QSDPR" -eq "1" ]] 
  then
  printf "Installing QSdpr\n\n"
  eval "$(conda shell.bash hook)"
  sudo apt-get -y update
  sudo apt-get -y install libatlas-base-dev
  conda create -y -n qsdpr
  conda activate qsdpr
  conda install -c anaconda -y python=2.7 pysam numpy clapack scipy #samtools atlas lapack
  wget -O qsdpr "https://sourceforge.net/projects/qsdpr/files/QSdpR_v3.2.tar.gz/download"
  tar xfz qsdpr
  rm -rf qsdpr
  conda activate base
  install_samtools
  CXXFLAGS=-I/usr/include/x86_64-linux-gnu
  CFLAGS=-I/usr/include/x86_64-linux-gnu
fi


#qure
if [[ "$RUN_QURE" -eq "1" ]] 
  then
  printf "Installing Qure\n\n"
  eval "$(conda shell.bash hook)"
  conda create -n java-env -y
  conda activate java-env
  conda install picard=3.1.0 -y
  conda activate base
  rm -rf QuRe_v0.99971
  wget -O qure "https://sourceforge.net/projects/qure/files/latest/download"
  unzip qure
  rm -rf qure
fi

#virus-vg
if [[ "$RUN_VIRUSVG" -eq "1" ]] 
  then
  printf "Installing Virus-VG\n\n"
  rm -rf jbaaijens-virus-vg-69a05f3e74f2
  wget -O virus-vg "https://bitbucket.org/jbaaijens/virus-vg/get/69a05f3e74f26e5571830f5366570b1d88ed9650.zip"
  unzip virus-vg
  rm -rf virus-vg
  
  rm vg
  wget "https://github.com/vgteam/vg/releases/download/v1.7.0/vg-v1.7.0"
  mv vg-v1.7.0 vg
  chmod +x vg
  cp vg jbaaijens-virus-vg-69a05f3e74f2
  eval "$(conda shell.bash hook)"
  conda create -y -n virus-vg-deps 
  conda activate virus-vg-deps 
  conda install --file jbaaijens-virus-vg-69a05f3e74f2/conda_list_explicit.txt
  conda install -c bioconda -y rust-overlaps minimap2
  conda install -c conda-forge -y graph-tool biopython
  pip install gurobipy
  pip install tqdm
  conda activate base
  
fi

#vg-flow
if [[ "$RUN_VGFLOW" -eq "1" ]] 
  then
  printf "Installing VG-Flow\n\n"
  eval "$(conda shell.bash hook)"
  conda create -y -n vg-flow-env
  conda activate vg-flow-env
  conda install -c bioconda -c conda-forge -c gurobi -y python=3 graph-tool minimap2 gurobi biopython numpy rust-overlaps 
  conda install -c conda-forge -y graph-tool biopython
  rm -rf jbaaijens-vg-flow-ac68093bbb23/
  wget -O vg-flow "https://bitbucket.org/jbaaijens/vg-flow/get/ac68093bbb235e508d0a8dd56881d4e5aee997e3.zip"
  unzip vg-flow
  rm -rf vg-flow
  rm -rf vg
  wget "https://github.com/vgteam/vg/releases/download/v1.7.0/vg-v1.7.0"
  mv vg-v1.7.0 vg
  chmod +x vg
  cp vg jbaaijens-vg-flow-ac68093bbb23/
  conda activate base
  #tmp comment
  #sudo apt-get install minimap2
fi

#viaDBG - issues with boost installation
if [[ "$RUN_VIADBG" -eq "1" ]] 
  then
  printf "Installing viaDBG\n\n"
  
  eval "$(conda shell.bash hook)"  
  conda create -y -n viadbg
  conda activate viadbg
  #conda install -c "conda-forge/label/gcc7" -y boost
  #conda install -c conda-forge -y boost-cpp
  #apt install libboost-all-dev
  conda install -c bioconda -y sga
 
  rm -rf boost_1_60_0.tar.gz
  wget http://sourceforge.net/projects/boost/files/boost/1.60.0/boost_1_60_0.tar.gz
  tar xvzf boost_1_60_0.tar.gz
  cd boost_1_60_0
  ./bootstrap.sh
  ./bjam install --prefix=~
  #./bjam install --prefix=~/boost
  #export PATH="$(pwd):$PATH"
  sudo ./b2 install 
 
  #git clone https://github.com/borjaf696/viaDBG.git
  #cd viaDBG
  #make clean && make
  #cd ..

  
fi

#PredictHaplo
if [[ "$RUN_PREDICTHAPLO" -eq "1" ]] 
  then
  printf "Installing PredictHaplo\n\n"
  eval "$(conda shell.bash hook)"  
  conda create -y -n predicthaplo
  conda activate predicthaplo
  conda install -c bioconda -y predicthaplo
  conda activate base 
fi

#TracesPipelite
if [[ "$RUN_TRACESPIPELITE" -eq "1" ]] 
  then
  printf "Installing TRACESPipeLite\n\n"
  eval "$(conda shell.bash hook)"  
  conda create -y -n tracespipelite
  conda activate tracespipelite
  rm -rf TRACESPipeLite
  git clone https://github.com/viromelab/TRACESPipeLite.git
  cd TRACESPipeLite/src/
  chmod +x *.sh
  ./TRACESPipeLite.sh --install
  cd ../../  
  conda activate base
fi

#TRACESPipe - working
if [[ "$RUN_TRACESPIPE" -eq "1" ]] 
  then
  printf "Installing TRACESPipe\n\n"
  eval "$(conda shell.bash hook)"  
  conda create -y -n tracespipe
  conda activate tracespipe
  rm -rf tracespipe
  git clone https://github.com/viromelab/tracespipe.git
  cd tracespipe/src/
  chmod +x TRACES*.sh
  ./TRACESPipe.sh --install  
  sudo apt install ncbi-entrez-direct -y
  conda install trimmomatic -y
  conda install -c cobilab magnet -y
  conda install -c cobilab falcon -y
  conda install -c cobilab gto -y
  conda install -c seyedmorteza cryfa -y
  conda install python=3.8.19 -y
  conda install samtools=1.9 -y
  
  wget https://github.com/ablab/spades/releases/download/v3.15.5/SPAdes-3.15.5.tar.gz
  tar -zvxf SPAdes-3.15.5.tar.gz
  rm SPAdes-3.15.5.tar.gz
  cd SPAdes-3.15.5
  export PATH=$PATH:$(pwd)
  cd ..
  
  ./TRACESPipe.sh --get-all-aux 
  #./TRACESPipe.sh --build-viral 
  cd ../../  
  conda activate base
  
  sudo apt install bowtie2 -y
  sudo apt install bcftools -y

fi

#ASPIRE - Can't locate App/Cmd/Setup.pm, tried installing one of the missing dependencies (Sub::Exporter), was not sucessfull, tried installing one of the missing dependencies for it (Test::LeakTrace) and it failed installation.
if [[ "$RUN_ASPIRE" -eq "1" ]] 
  then
  printf "Installing ASPIRE\n\n"

  cpan App::Cmd::Setup
  #cpanm Bio::DB::Sam
  cpan Bio::Seq
  cpan Bio::SeqIO
  cpan Cwd
  cpan File::Path
  cpan File:Slurp
  cpan File::Spec
  cpan IPC::Run
  cpan List::Util
  cpan Math::Round
  cpan Statistics::Descriptive::Full  
  rm -rf aspire/
  git clone https://github.com/kevingroup/aspire.git
  
fi


#QVG 
if [[ "$RUN_QVG" -eq "1" ]] 
  then
  printf "Installing QVG\n\n"
  eval "$(conda shell.bash hook)"  
  conda create -y -n qvg
  conda activate qvg  
  conda install samtools=1.17 -y
  conda install -c bioconda -y bwa sambamba freebayes bcftools vcflib vcftools bedtools bioawk fastp
  conda install -c conda-forge -y ncurses
  conda install -c r -y r
  rm -rf QVG/
  git clone https://github.com/laczkol/QVG.git
  cd ./QVG/
  conda create -y --name qvg-env --file qvg-env.yaml 
  conda install freebayes=1.3.5 -y
  conda install vcflib=1.0.3 -y
  conda activate base
  sudo apt-get -y install libncurses6
  cd ..
fi

#Strainline - seg. fault; reads.las not present
if [[ "$RUN_STRAINLINE" -eq "1" ]]
  then
  printf "Installing Strainline\n\n"
  eval "$(conda shell.bash hook)"  
  conda create -y -n strainline
  conda activate strainline
  conda install -c bioconda -y minimap2 spoa samtools dazz_db daligner metabat2 bbmap python
  conda install -c dranew -y libmaus
  wget https://github.com/gt1/daccord/releases/download/0.0.10-release-20170526170720/daccord-0.0.10-release-20170526170720-x86_64-etch-linux-gnu.tar.gz
  tar -zvxf daccord-0.0.10-release-20170526170720-x86_64-etch-linux-gnu.tar.gz 
  rm -rf daccord-0.0.10-release-20170526170720-x86_64-etch-linux-gnu.tar.gz   
  #printf "Please insert the path to miniconda installation. Example: /home/USER/miniconda3\n" 
  #read condapath    
  ln -fs $PWD/daccord-0.0.10-release-20170526170720-x86_64-etch-linux-gnu/bin/daccord $CONDA_PREFIX/bin/daccord
  rm -rf Strainline
  git clone "https://github.com/HaploKit/Strainline.git"
  conda activate base
  sudo apt -y install dazzdb
fi

#HAPHPIPE -
if [[ "$RUN_HAPHPIPE" -eq "1" ]] 
  then
  printf "Installing HAPHPIPE\n\n"
  eval "$(conda shell.bash hook)"
  conda create -y -n haphpipe
  conda activate haphpipe
  conda install -y haphpipe
  conda install -c bioconda -y gatk 
  
  
  
  
  #wget https://anaconda.org/bioconda/gatk/3.8/download/linux-64/gatk-3.8-py35_0.tar.bz2
  #bzip2 -d gatk-3.8-py35_0.tar.bz2
  #mkdir -p gatk
  #tar -jxf gatk-3.8-py35_0.tar.bz2 --directory gatk
  #cd gatk/bin/
  #./gatk-register GenomeAnalysisTK #i dont know what the file is
  
  #cd ../../
  conda activate base
fi

#aBayesQR
if [[ "$RUN_ABAYESQR" -eq "1" ]] 
  then
  printf "Installing aBayesQR\n\n"
  rm -rf aBayesQR
  git clone https://github.com/SoYeonA/aBayesQR.git
  cd aBayesQR
  make
  cd ..  
fi

#HaploClique
if [[ "$RUN_HAPLOCLIQUE" -eq "1" ]] 
  then
  printf "Installing HaploClique\n\n"
  rm -rf haploclique
  eval "$(conda shell.bash hook)"
  conda create -y -n haploclique
  conda activate haploclique
  #conda install -c bioconda -y 
  #conda install -
  conda install -c bioconda -y haploclique samtools python=3.6 
  conda activate base
fi

#ViSpA
if [[ "$RUN_VISPA" -eq "1" ]] 
  then
  printf "Installing ViSpA\n\n"
  wget https://alan.cs.gsu.edu/NGS/sites/default/files/vispa02.zip --no-check-certificate
  rm -rf home
  unzip vispa02.zip 
  rm -rf vispa02.zip
  eval "$(conda shell.bash hook)"
  conda create -y --name vispa python=2.7 
  conda activate vispa
  conda install -c bioconda -c conda-forge -y numexpr pysam numpy biopython mosaik
  conda activate base
fi

#QuasiRecomb
if [[ "$RUN_QUASIRECOMB" -eq "1" ]] 
  then
  printf "Installing QuasiRecomb\n\n"
  eval "$(conda shell.bash hook)"
  conda create -y --name quasirecomb
  conda activate quasirecomb
  conda install -c bioconda -y samtools picard
  
  #wget https://github.com/cbg-ethz/QuasiRecomb/archive/refs/tags/v1.2.zip
  #unzip v1.2.zip 
  #rm -rf v1.2.zip
  
  rm -rf QuasiRecomb.jar
  wget https://github.com/cbg-ethz/QuasiRecomb/releases/download/v1.2/QuasiRecomb.jar
  #cp QuasiRecomb.jar QuasiRecomb-1.2
  
  conda activate base
  
fi

#Lazypipe - working on some machines, conda issues
if [[ "$RUN_LAZYPIPE" -eq "1" ]] 
  then
  printf "Installing Lazypipe\n\n"  
  eval "$(conda shell.bash hook)"  
  rm -rf lazypipe 
  rm 277fafc.tar.gz 
  wget https://bitbucket.com/plyusnin/lazypipe/get/277fafc.tar.gz
  tar -xf 277fafc.tar.gz 
  mv plyusnin-lazypipe-277fafc63631/ lazypipe
  cd lazypipe
  
  #mkdir data
  cd data
  mkdir taxonomy
  cd ..

  conda create -n blast -c bioconda -y blast
  conda create -n lazypipe -c bioconda -c eclarke -y bwa centrifuge csvtk fastp krona megahit mga minimap2 samtools seqkit spades snakemake-minimal taxonkit trimmomatic numpy scipy fastcluster requests perl
  

  conda activate blast
  conda activate --stack lazypipe
  ln -fs ~/miniconda3/envs/lazypipe/bin/ ~/
  
  rm -rf $CONDA_PREFIX/envs/lazypipe/opt/krona/taxonomy
  ln -s data/taxonomy $CONDA_PREFIX/envs/lazypipe/opt/krona/taxonomy
  
  export TM="$CONDA_PREFIX/share/trimmomatic"
  export BLASTDB="$(pwd)/BLASTDB/"
  export data="$(pwd)/data/"
  
  wget http://ekhidna2.biocenter.helsinki.fi/sanspanz/SANSPANZ.3.tar.gz
  tar -zxvf SANSPANZ.3.tar.gz
  sed -i "1 i #!$(which python)" SANSPANZ.3/runsanspanz.py
  mkdir ~/bin
  ln -sf  $(pwd)/SANSPANZ.3/runsanspanz.py $(pwd)
  
 # cd ..
 # ls
  
  #experimental 
  #rm -rf ~/perl5
  #mkdir ~/perl5
  #rm -rf perl-5.36.0.tar.gz
  #wget https://www.cpan.org/src/5.0/perl-5.36.0.tar.gz
  #tar -xzf perl-5.36.0.tar.gz
  #cd perl-5.36.0
  #./Configure -des -Dprefix=~/perl5
  #make
  #make test
  #make install
  
  #mv ~/bin ~/perl5
  #mv ~/lib ~/perl5
  #mv ~/man ~/perl5
  
  #sudo apt-get install r-base
  #sudo apt-get install r-base-dev
  cpan CPAN
  cpan File::Basename File::Temp Getopt::Long YAML::Tiny
  export PERL5LIB="$CONDA_PREFIX/pkgs/perl-5.32.1-2_h7f98852_perl5/bin/perl:$PERL5LIB"
  echo $PERL5LIB
  #mkdir TM
  #mkdir BLASTDB
  #Rscript -e 'install.packages( c("reshape","openxlsx") )'
  perl perl/install_db.pl --db taxonomy
  perl perl/install_db.pl --db blastn_vi
  cd ..
  conda activate base 
  sudo apt install r-base-core -y
  
  printf "\n\nPlease open the R console and type install.packages( c(\"reshape\",\"openxlsx\") )\n\nPress any button to continue\n\n"
  read a
fi

#ViQuaS
if [[ "$RUN_VIQUAS" -eq "1" ]] 
  then
  printf "Installing ViQuaS\n\n"
  eval "$(conda shell.bash hook)"  
  conda create -y -n viquas
  conda activate viquas
  conda install -c bioconda -y bioconductor-biostrings r-seqinr
  wget -O viquas "https://sourceforge.net/projects/viquas/files/latest/download"
  tar -xzf viquas
  rm -rf viquas
  conda activate base
  
  Rscript -e 'install.packages("BiocManager", repos="https://cloud.r-project.org")'
  Rscript -e 'install.packages("Biostrings", repos="https://cloud.r-project.org")'
  Rscript -e 'install.packages("seqinr", repos="https://cloud.r-project.org")'
  
fi

#MLEHaplo - not able to connect to gatb
if [[ "$RUN_MLEHAPLO" -eq "1" ]] 
  then
  printf "Installing MLEHaplo\n\n"
  eval "$(conda shell.bash hook)"
  
  conda create -y -n mlehaplo
  conda activate mlehaplo
  conda install -c bioconda -y gatb perl-bioperl perl-graph
  
  
  
  
  #wget -O dsk http://gatb-tools.gforge.inria.fr/versions/bin/dsk-2.1.0-Linux.tar.gz
  #tar -xzf dsk
  #rm -rf dsk
  
  #cpan Bio::Perl
  #cpan Getopt::Long
  #cpan Getopt::Graph
  
  wget https://github.com/raunaq-m/MLEHaplo/archive/refs/tags/v0.4.1.tar.gz
  tar -zxf v0.4.1.tar.gz
  
  conda activate base
  
fi

#PEHaplo - part of tar-vir installation
#if [[ "$RUN_PEHAPLO" -eq "1" ]] 
#  then
#  printf "Installing PEHaplo\n\n"
#  git clone https://github.com/chjiao/PEHaplo.git 
#  conda create -n pehaplo python=2.7 networkx==1.11 apsp 
#fi

#RegressHaplo - err - unsatisfiable error
if [[ "$RUN_REGRESSHAPLO" -eq "1" ]] 
  then
  printf "Installing RegressHaplo\n\n"
  eval "$(conda shell.bash hook)"
  #tmp comment
  #sudo apt-get install r-base
  #sudo apt-get install libcurl4-openssl-dev libssl-dev
  
  
  conda create -y -n regresshaplo
  conda activate regresshaplo
  #conda install -c r -c hcc -y r r-essentials r-regresshaplo 
  conda install -c hcc -y r-regresshaplo
  conda activate base
  
  #install R 	
  #sudo apt-get update
  #sudo apt-get install r-base
  #sudo apt update
  #sudo apt install r-base
  
  # Install devtools from CRAN

  
  #wget -O rsource "https://cran.r-project.org/src/base/R-4/R-4.2.2.tar.gz"
  #tar -zxf rsource
  #rm -rf rsource
  #cd R-4.2.2
  #./configure
  #make
  #R --version
  #R
  
  #devtools::install_github("hadley/devtools")
  
  
  #sudo apt-get install r-base
 
  

  
fi

#CliqueSNV
if [[ "$RUN_CLIQUESNV" -eq "1" ]] 
  then
  printf "Installing CliqueSNV\n\n"
  rm -rf CliqueSNV-2.0.3
  wget -O cliquesnv "https://github.com/vtsyvina/CliqueSNV/archive/refs/tags/2.0.3.zip"
  unzip cliquesnv
  rm -rf 2.0.3.zip 
  rm -rf cliquesnv
  eval "$(conda shell.bash hook)"
  conda create -n java-env -y
  conda activate java-env
  conda install -c bioconda -y picard
  conda activate base
fi

#IVA
if [[ "$RUN_IVA" -eq "1" ]] 
  then
  printf "Installing IVA\n\n"
  #install_docker
  #sudo docker pull sangerpathogens/iva
  eval "$(conda shell.bash hook)"
  conda create -y -n iva
  conda activate iva
  conda install iva -y
  conda activate base
fi

#PRICE
if [[ "$RUN_PRICE" -eq "1" ]] 
  then
  printf "Installing PRICE\n\n"
  wget -O price "https://sourceforge.net/projects/pricedenovo/files/latest/download"
  tar -xzf price
  rm -rf price
  cd PriceSource130506
  make
  cd ..    
fi

#VirGenA
if [[ "$RUN_VIRGENA" -eq "1" ]] 
  then
  printf "Installing VirGenA\n\n"
  rm -rf release_v1.4
  wget -O virgena "https://github.com/gFedonin/VirGenA/releases/download/1.4/VirGenA_v1.4.zip"
  unzip virgena
  rm -rf virgena
  eval "$(conda shell.bash hook)"
  conda create -n java-env -y
  conda activate java-env
  conda install -c bioconda -y picard
  conda activate base  
fi

#TAR-VIR
if [[ "$RUN_TARVIR" -eq "1" ]] || [[ "$RUN_PEHAPLO" -eq "1" ]]
  then
  printf "Installing TAR-VIR and PEHaplo\n\n"
  conda config --add channels defaults
  conda config --add channels conda-forge
  conda config --add channels bioconda
  conda config --add channels kennethshang
  eval "$(conda shell.bash hook)"  
  conda create -y -n bio2 python=2.7 --solver=classic   
  conda activate bio2                 
  pip install networkx==1.11 
  conda install -y bamtools==2.4.0 apsp sga samtools bowtie2 overlap_extension genometools-genometools numpy scipy
  conda install -c bioconda -y karect
  git clone --recursive https://github.com/chjiao/TAR-VIR.git
  cd TAR-VIR/Overlap_extension/
  make
  cd ../../ 
  pip install networkx==1.11 
  conda activate base

fi

#VIP - untested, rerun, missing database?
if [[ "$RUN_VIP" -eq "1" ]] 
  then
  printf "Installing VIP\n\n"
  eval "$(conda shell.bash hook)"
  
  conda create -y -n vip
  conda activate vip
  conda install -c bioconda -y perl-dbi bowtie2
  rm -rf VIP-master
  wget -O vip "https://github.com/keylabivdc/VIP/archive/refs/heads/master.zip"
  unzip vip
  rm -rf vip
  cd VIP-master/installer
  chmod +x ./dependency_installer.sh
  chmod +x ./db_installer.sh
  sudo sh dependency_installer.sh
  #./db_installer.sh -r ../ #-r #[PATH]/[TO]/[DATABASE]
  cd ../../
  conda activate base
  
fi
#drVM
if [[ "$RUN_DRVM_DOCKER" -eq "1" ]] 
  then
  sudo docker run -t -i -v /home/manager/Templates:/drVM 990210oliver/drvm /bin/bash
  
  cd drVM
  mkdir MyDB
  cd MyDB
  wget https://sourceforge.net/projects/sb2nhri/files/drVM/sequence_20160316.tar.gz
  tar -zxvf sequence_20160316.tar.gz

  CreateDB.py -s sequence.fasta
  
  export MyDB='/drVM/MyDB'
  drVM.py -1 DRR049387_1.fastq -2 DRR049387_2.fastq -t $NR_THREADS
  
fi

#drVM
if [[ "$RUN_DRVM" -eq "1" ]] 
  then
  printf "Installing drVM\n\n"
  sudo apt -y install python2
  sudo apt -y install gawk
  sudo apt-get -y install build-essential python-dev python-numpy python-scipy libatlas-dev libatlas3gf-base python-matplotlib libatlas-base-dev
  
  wget -O drvm "https://sourceforge.net/projects/sb2nhri/files/latest/download"
  rm -rf Tools
  unzip drvm
  rm -rf drvm
  cd Tools
  printf "If this tool is not working and giving you the error * bad interpreter: No such file or directory, please comment the for below.\n\n"
  for filename in $(ls *.py); #for each fasta file in curr dir
  do   
    printf "Processing file $filename \n\n\n"  
    file_content=$(awk 'NR > 1' $filename)  
    echo "$PYTHON2_PATH
$file_content" > $filename      
  done
  
  
  #gawk -i inplace $0=="#!/usr/bin/python" {$0="${PYTHON2_PATH}"} 1 *.py
  rm -rf MyDB
  mkdir MyDB
  cd MyDB
  rm -rf sequence_20160316.tar.gz 
  wget https://sourceforge.net/projects/sb2nhri/files/drVM/sequence_20160316.tar.gz
  tar -zxvf sequence_20160316.tar.gz
  
  ./../CreateDB.py -s sequence.fasta -d 10 -kn off
  ./../CreateTaxInfo.py sequence.fasta nucl_gb.accession2taxid
  ./../CreateSnapDB.py sequence.fasta snap 10000000 off
  ./../CreateBlastDB.py makeblastdb

  
  cd ../
  #./CreateSnapDB.py ../DS1.fa snap-0.15.4-linux
  cd ../
  export MyDB="$(pwd)/Tools/MyDB"
  printf "path exported  ->  $MyDB \n\n"
  
  
  
fi

#SSAKE
if [[ "$RUN_SSAKE" -eq "1" ]] 
  then
  printf "Installing SSAKE\n\n"
  rm -rf ssake
  wget -O ssake "https://github.com/bcgsc/SSAKE/releases/download/v4.0.1/ssake_v4-0.tar.gz"
  tar -xzf ssake
  
  
fi

#viralFlye
if [[ "$RUN_VIRALFLYE" -eq "1" ]] 
  then
  printf "Installing viralFlye\n\n"
  rm -rf viralFlye
  git clone https://github.com/Dmitry-Antipov/viralFlye
  eval "$(conda shell.bash hook)"
  conda create -y -n viralFlye
  conda activate viralFlye
  conda install -c bioconda -c conda-forge -c mikeraiko -y "python>=3.6" prodigal viralverify vcflib seqtk minced minimap2 pysam tabix samtools freebayes bcftools numpy scipy blast bwa viralcomplete
  conda install -c conda-forge -y biopython
  conda install -c anaconda -y scipy

  rm -rf Pfam-A.hmm.gz  
  wget http://ftp.ebi.ac.uk/pub/databases/Pfam/releases/Pfam34.0/Pfam-A.hmm.gz
  
  rm -rf Flye
  git clone https://github.com/fenderglass/Flye
  cd Flye
  python setup.py install
  cd ..
  conda activate base
fi


#EnsembleAssembler
if [[ "$RUN_ENSEMBLEASSEMBLER" -eq "1" ]] 
  then
  printf "Installing EnsembleAssembler \n\n"
  sudo apt -y install python2
  sudo apt -y install gawk
  sudo apt-get -y install dos2unix
  
  rm -rf ensembleAssembly  
  rm -rf ensembleAssembly_1
  wget -O ensembleAssembly "https://sourceforge.net/projects/ensembleassembly/files/latest/download"
  tar -zxvf ensembleAssembly
  chmod a+x ensembleAssembly_1/* -R
  
  cd ensembleAssembly_1
  dos2unix ensembleAssembly
  printf "If this tool is not working and giving you the error /usr/bin/python2: bad interpreter: No such file or directory, please change PYTHON2_PATH at the beginning of this file to the location of python2 on your device.\n\n"
  file_content=$(awk 'NR > 1' ensembleAssembly)  
  echo "$PYTHON2_PATH
$file_content" > ensembleAssembly  
  cd ..


  https://github.com/bcgsc/abyss/archive/refs/tags/2.1.5.zip

  #for file in `cd ensembleAssembly_1;ls -1 ${file}` #for each fasta file in curr dir
  #do 
  #  dos2unix $file
  #done
  #cd ensembleAssembly_1
  #printf "If this tool is not working and giving you the error /usr/bin/python2: bad interpreter: No such file or directory, please comment the line below.\n\n"
  #gawk -i inplace '$0=="/usr/bin/env: python" {$0="#!/usr/bin/python2"} 1' *
  #cd ..


  
  
fi


#Haploflow -works
if [[ "$RUN_HAPLOFLOW" -eq "1" ]] 
  then
  printf "Installing Haploflow \n\n"
  eval "$(conda shell.bash hook)"
  conda create -y -n haploflow 
  conda activate haploflow  
  conda install -c bioconda -y haploflow
  conda activate base  
fi

#TenSQR-err on reconstruction
if [[ "$RUN_TENSQR" -eq "1" ]] 
  then
  printf "Installing TenSQR\n\n"
  eval "$(conda shell.bash hook)"
  rm -rf TenSQR
  git clone https://github.com/SoYeonA/TenSQR.git
  cd TenSQR
  make
  cd ..  
  
  pip install numpy
  pip install scipy
  
fi

#Arapan-S - error on qt v4 dependency
#https://download.qt.io/archive/qt/INSTALL
if [[ "$RUN_ARAPANS" -eq "1" ]] 
  then
  printf "Installing Arapan-S\n\n"
  wget -O Arapan-S https://downloads.sourceforge.net/project/dnascissor/Arapan-S%20Assembler/Arapan-S%202.1.0%20%28Linux%20_22Ubuntu_22%29.zip
  rm -rf Arapan 2.1.0  
  unzip Arapan-S
  mv "Arapan 2.1.0" "Arapan"
  rm -rf Arapan-S
  chmod +x Arapan  
  
  wget -O qt.zip https://download.qt.io/archive/qt/4.7/qt-everywhere-opensource-src-4.7.4.zip
  unzip -a qt.zip
  cd qt-everywhere-opensource-src-4.7.4/
  printf "In tests, pressed o and then accepted the terms."
  make #err
  su -c "make install" #err

fi


#ViQUF- fatal error: sdsl/suffix_arrays.hpp: No such file or directory
if [[ "$RUN_VIQUF_DOCKER" -eq "1" ]] 
  then
  printf "Installing ViQUF\n\n"
  eval "$(conda shell.bash hook)"
  
  git clone https://github.com/borjaf696/ViQUF
  
  cd ViQUF

  sudo docker rm viquf
  sudo docker build -t viquf . --no-cache
  
  
  cd ..
  
fi

#IRMA
if [[ "$RUN_IRMA" -eq "1" ]] 
  then
  printf "Installing IRMA\n\n"
  
  rm -rf flu-amd-202402.zip flu-amd
  wget https://github.com/CDCgov/irma/releases/download/v1.1.4/flu-amd-202402.zip
  unzip flu-amd-202402.zip
  rm flu-amd-202402.zip
  sudo apt install r-base-core -y
  cd flu-amd
  sudo export PATH=$PATH:$(pwd)
  cd ..

  wget https://web.archive.org/web/20241205213306/https://wonder.cdc.gov/amd/flu/irma/ORG.zip
  unzip ORG.zip
  rm ORG.zip
  mv ORG flu-amd/IRMA_RES/modules
  
fi

#ViQUF- fatal error: sdsl/suffix_arrays.hpp: No such file or directory
if [[ "$RUN_VIQUF" -eq "1" ]] 
  then
  printf "Installing ViQUF\n\n"
  eval "$(conda shell.bash hook)"
  #conda create -n viquf-env python=3.6 
  #conda activate viquf
  #conda install -y biopython altair gurobi matplotlib scipy numpy
  #git clone https://github.com/borjaf696/ViQUF.git
  #cd ViQUF
  #sudo docker rm ViQUF
  #mv ViQUF viquf
  #sudo docker build -f viquf/Dockerfile .
  #sudo docker run -d viquf
  #make clean && make
  #cd ..
  
    
  #conda activate base
  
  start_dir=$(pwd)
  
  #dockerfile contents
  sudo apt update && apt install -y python3 cmake pip software-properties-common wget nano curl build-essential procps file git && apt-get clean
  sudo pip install install numpy sklearn scipy biopython pandas matplotlib plotly altair gurobipy

# GH
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0 \
    && apt-add-repository https://cli.github.com/packages \
    && apt update \
    && apt install gh

# ENV FOLDER_PROJECT /var/borjafreire1
# RUN mkdir -p $FOLDER_PROJECT
# run cd $FOLDER_PROJECT
# COPY install_gh.sh $FOLDER_PROJECT
# run ./$FOLDER_PROJECT/install_gh.sh

# Repositories: ViQUF, Gatb
cd $start_dir
 git clone https://github.com/borjaf696/ViQUF
 cd ViQUF \
    && cd lib/ \
    && sudo rm -r gatb-core/  
    git clone https://github.com/GATB/gatb-core \
    && cd gatb-core/gatb-core \
    && mkdir build ; cd build ; cmake .. ; make -j8 
cd $start_dir
# Lemon
 cd usr/local/ \
    && wget http://lemon.cs.elte.hu/pub/sources/lemon-1.3.1.tar.gz \
    && tar xvf lemon-1.3.1.tar.gz \
    && cd lemon-1.3.1 \
    && cd build \
    && sudo cmake .. \
    && make install
cd $start_dir
# SDSL
 git clone https://github.com/simongog/sdsl-lite.git \
    && cd sdsl-lite \
    && ./install.sh
cd $start_dir
# Make ViqUF
cd ViQUF\
    && make clean && make
cd $start_dir
pip3 install pandas
pip install altair
pip install progressbar
    
fi

#V-pipe - to test
if [[ "$RUN_VPIPE" -eq "1" ]]
  then
  printf "Installing with V-pipe ver quick install, altered\n\n"
  rm -rf V-Pipe
  #cat quick_install.sh > install_vpipe.sh
  #chmod +x install_vpipe.sh
  #./install_vpipe.sh -f
  PREFIX=$(pwd)
  FORCE=
  BRANCH=master
  RELEASE=
  WORKDIR=
  MINIMAL=
  
  # Helper
fail() {
	printf '\e[31;1mArgh: %s\e[0m\n'	"$1"	1>&2
	[[ -n "$2" ]] && echo "$2" 1>&2
	exit 1
}

oops() {
	printf '\e[33;1mOops:%s\e[0m\n'	"$1"	 1>&2
}

title() {
	printf '\e[34;1m======================\n%s\n======================\e[0m\n\n'	"$1"
}

message() {
	printf '\e[37;1m%s\t%s\e[0m\n' "$1" "$2"
}

status() {
	printf '\e[36;1m%s\e[0m\n'	"$1"
}

check_directory() {
	if [[ -d "$1" ]]; then
		if (( FORCE )); then
			rm -rf "$1"
		else
			fail "${2:-Directory} ${1} already exists" 'check and use -f if needed'
		fi
	fi
}

usage() {
echo "usage: $0 [options]
options:
-f           force overwriting directories
-p PREFIX    prefix directory under which to install V-pipe
             [default: current directory]
-b BRANCH    install specified branch of V-pipe${BRANCH:+
             [default: $BRANCH]}
-r RELEASE   install specified release package of V-pipe${RELEASE:+
             [default: $RELEASE]}
-w WORKDIR   create and populate working directory
-m           only minimal working directory
-h           print this help message and exit"
}


# parameters
while getopts ":fp:b:r:w:mh" opt; do
	case ${opt} in
		f)
			FORCE=1
		;;
		p)
			PREFIX="${OPTARG}"
		;;
		b)
			BRANCH="${OPTARG}"
		;;
		r)
			RELEASE="${OPTARG}"
		;;
		w)
			WORKDIR="${OPTARG}"
		;;
		m)
			MINIMAL='-m'
		;;
		h)
			usage
			exit 0
		;;
		\?)
			fail "Invalid option: ${OPTARG}"
		;;
		:)
			fail "Invalid option: ${OPTARG} requires an argument"
		;;
	esac
done
shift $((OPTIND -1))

[[ -z "${BRANCH}" && -z "${RELEASE}" ]] && fail "Please specify either a branch or a release package, e.g.: '-b master'"


###################
#                 #
#   Basic stuff   #
#                 #
###################

DOWNLOAD=
if [[ -x $(which wget) ]] || wget --version; then # most Linux distros (Gentoo)
	DOWNLOAD='wget'
elif [[ -x $(which curl) ]] || curl --version; then # a few Linux distros (CentOS, Archlinux) and Mac OS X
	DOWNLOAD='curl -LO'
else
	fail 'Please install either wget or curl'
fi;



##################
#                #
#   Miniconda3   #
#                #
##################


# set the channel precedence (lowest to highest)
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
conda config --set channel_priority strict
# NOTE conda-forge *HAS TO* be higher than bioconda

VPIPEENV=
if conda install --yes 'snakemake-minimal<8'; then	# NOTE Mac OS X and some Linux dockers don't have git out of the box
	: # success!
else
	oops 'I cannot install snakemake in base environment. Conflicts ?'

	VPIPEENV=V-pipe
	# HACK Alternate to consider if we have have version conflicts
	conda create --yes -n ${VPIPEENV} -c conda-forge -c bioconda snakemake-minimal
	conda activate ${VPIPEENV}
fi

# NOTE No need to download and install V-pipe dependencies, snakemake --use-conda handles this.

echo $'\n'



##############
#            #
#   V-pipe   #
#            #
##############

title 'installing V-pipe'

if [[ -z "${RELEASE}" ]]; then
	message 'Using branch:' "${BRANCH}"

	check_directory 'V-pipe' 'V-pipe installation directory'
	wget https://github.com/cbg-ethz/V-pipe/archive/refs/tags/v2.99.3.zip
	unzip v2.99.3.zip
	mv V-pipe-2.99.3 V-pipe
	
else
	message 'Using release:' "${RELEASE}"
	check_directory "V-pipe-${RELEASE}" 'V-pipe installation directory'
	${DOWNLOAD} "https://github.com/cbg-ethz/V-pipe/archive/refs/tags/${RELEASE}.tar.gz" || fail "I cannot download package {RELEASE}."
	tar xvzf "${RELEASE}.tar.gz" || fail "I cannot install package ${RELEASE}."
fi

echo $'\n'

cd V-pipe
  ./init_project.sh 
  cd ..


###############
#             #
#   Working   #
#             #
###############

INIT="$(pwd)/V-pipe${RELEASE:+-${RELEASE}}/init_project.sh"

if [[ -z "${WORKDIR}" ]]; then
	status 'Installation of V-pipe completed'
	echo "
To setup working directory:
	mkdir -p working
	cd working
	${INIT}"

fi

title 'Working directory'
message 'Working directory:' "${WORKDIR}"

check_directory "${WORKDIR}" 'Working directory'
# shellcheck disable=SC2015
mkdir -p "${WORKDIR}" && cd "${WORKDIR}" || fail "Could not create directory: ${WORKDIR}"
"${INIT}" ${MINIMAL} || fail "Populating working directory failed"

echo $'\n'
status 'Installation of V-pipe completed'

  #cd V-pipe
  #./init_project.sh 
  #cd ..
fi

./Verification.sh --tools -c

