#!/bin/bash

RUN_SHORAH=0;
RUN_QURE=0;
RUN_SAVAGE=0;
RUN_QSDPR=1;
RUN_SPADES=0;
RUN_METAVIRALSPADES=0;
RUN_CORONASPADES=0;
RUN_VIADBG=0;
RUN_VIRUSVG=0;
RUN_VGFLOW=0;
RUN_PREDICTHAPLO=0;
RUN_TRACESPIPELITE=0;
RUN_VPIPE=0;
RUN_STRAINLINE=0;
RUN_HAPHPIPE=0;
RUN_ABAYESQR=0;
RUN_HAPLOCLIQUE=0;
RUN_VISPA=0;
RUN_QUASIRECOMB=0;
RUN_LAZYPIPE=0;
RUN_VIQUAS=0;
RUN_MLEHAPLO=0;
RUN_PEHAPLO=0;
RUN_REGRESSHAPLO=0;
RUN_CLIQUESNV=0;
RUN_IVA=0;
RUN_PRICE=0;
RUN_VIRGENA=0;
RUN_TARVIR=0;
RUN_VIP=0;
RUN_DRVM=0;
RUN_SSAKE=0;
RUN_VIRALFLYE=0;
RUN_ENSEMBLEASSEMBLER=0;

declare -a DATASETS=("DS1");
#declare -a DATASETS=("DS1" "DS2" "DS3");
declare -a VIRUSES=("B19" "HPV" "VZV");

#create bam files from sam files - [W::sam_parse1] urecognized reference name; treated as unmapped
create_bam_files () { 
  printf "Creating .bam files from .sam files\n\n"
  for dataset in "${DATASETS[@]}"
    do	
    samtools view -bS ${dataset}_.sam > ${dataset}.bam
  done
}

#shorah - can't test without bam files
if [[ "$RUN_SHORAH" -eq "1" ]] 
  then
  printf "Reconstructing with Shorah\n\n"
  create_bam_files
  for dataset in "${DATASETS[@]}"
    do	
    shorah.py -b ${dataset}.bam -f HPV-1.fa
  done
fi

#spades - runs
if [[ "$RUN_SPADES" -eq "1" ]] 
  then
  printf "Reconstructing with SPAdes\n\n"
  cd SPAdes-3.15.5-Linux/bin/
  for dataset in "${DATASETS[@]}"
    do	
    cp  ../../${dataset}_1.fq .
    cp  ../../${dataset}_2.fq .
    #spades.py -o spades_${dataset} -1 ${dataset}_1.fq -2 ${dataset}_2.fq
    python spades.py -o spades_${dataset} -1 ${dataset}_1.fq -2 ${dataset}_2.fq --meta
    done
  cd ../../
fi

#metaviralspades
if [[ "$RUN_METAVIRALSPADES" -eq "1" ]] 
  then
  printf "Reconstructing with metaviralSPAdes\n\n"
  cd SPAdes-3.15.5-Linux/bin/
  for dataset in "${DATASETS[@]}"
    do	
    cp ../../${dataset}_1.fq .
    cp ../../${dataset}_2.fq .
    ./metaviralspades.py -t 1 -o metaviralspades_${dataset} -1 ${dataset}_1.fq -2 ${dataset}_2.fq
  done
  cd ../../
fi

#coronaspades
if [[ "$RUN_CORONASPADES" -eq "1" ]] 
  then
  printf "Reconstructing with coronaSPAdes\n\n"
  cd SPAdes-3.15.5-Linux/bin/
  for dataset in "${DATASETS[@]}"
    do
    ./coronaspades.py -o coronaspades_${dataset} -1 ../../${dataset}_1.fq -2 ../../${dataset}_2.fq
  done
  cd ../../
fi

#savage - Runs, no reads could be aligned to reference error
if [[ "$RUN_SAVAGE" -eq "1" ]] 
  then
  printf "Reconstructing with SAVAGE\n\n"
  eval "$(conda shell.bash hook)"
  conda activate savage
  mkdir savage
  cd savage
  cp ../B19.fa .
  
  for dataset in "${DATASETS[@]}"
    do
    cp ../${dataset}_1.fq ../${dataset}_2.fq .
    savage --split 500 -p1 ${dataset}_1.fq -p2 ${dataset}_2.fq --ref $(pwd)/B19.fa
  done
  cd ..
fi

#qsdpr - missing vcf file, missing configuration
if [[ "$RUN_QSDPR" -eq "1" ]] 
  then
  printf "Reconstructing with QSdpr\n\n"
  eval "$(conda shell.bash hook)"
  conda activate qsdpr  
  #echo Please input the path to miniconda. Example: /home/miniconda3
  #read miniconda
  #echo $miniconda
  
  cd QSdpR_v3.2/
  for dataset in "${DATASETS[@]}"
    do
    rm -rf QSdpR_data/${dataset}
    mkdir QSdpR_data/${dataset}
    cp ../${dataset}.fa ../${dataset}_.sam ../${dataset}_1.fq ../${dataset}_2.fq QSdpR_data/${dataset}
    chmod +x ./QSdpR_source/QSdpR_master.sh
    cd QSdpR_data/
    ../QSdpR_source/QSdpR_master.sh 2 8 ../QSdpR_source ${dataset} sample 1 1000 /home/mj/miniconda3/pkgs/samtools-1.3.1-0/bin
    #cd ..
  done
  cd ../
  conda activate base
fi

#qure - Runs with exception at the end of execution - Exception in thread "main" java.lang.ArrayIndexOutOfBoundsException: Array index out of range: 3
if [[ "$RUN_QURE" -eq "1" ]] 
  then
  printf "Reconstructing with QuRe\n\n"
  cd QuRe_v0.99971/
  for dataset in "${DATASETS[@]}"
    do
    cp ../${dataset}.fa ../B19.fa .
    java -Xmx7G QuRe ${dataset}.fa B19.fa 1E-25 1E-25 1000
  done
  cd ..
fi

#virus-vg - rust-overlaps not found
if [[ "$RUN_VIRUSVG" -eq "1" ]] 
  then
  printf "Reconstructing with Virus-VG\n\n"
  eval "$(conda shell.bash hook)"
  conda activate virus-vg-deps
  chmod +x jbaaijens-virus-vg-69a05f3e74f2/scripts/build_graph_msga.py
  for dataset in "${DATASETS[@]}"
    do
    cp ${dataset}_1.fq -r ${dataset}_2.fq -c ${dataset}.fa samples_virusvg
    jbaaijens-virus-vg-69a05f3e74f2/scripts/build_graph_msga.py -f samples_virusvg/${dataset}_1.fq -r samples_virusvg/${dataset}_2.fq -c samples_virusvg/${dataset}.fa -vg vg -t 2
  done
  conda activate base
fi

#vg-flow - running with errors, rust-overlaps not found
if [[ "$RUN_VGFLOW" -eq "1" ]] 
  then
  printf "Reconstructing with VG-Flow\n\n"
  eval "$(conda shell.bash hook)"
  conda activate vg-flow-env
  chmod +x jbaaijens-vg-flow-ac68093bbb23/scripts/build_graph_msga.py
  for dataset in "${DATASETS[@]}"
    do
    jbaaijens-vg-flow-ac68093bbb23/scripts/build_graph_msga.py -f ${dataset}_1.fq -r ${dataset}_2.fq -c ${dataset}.fa -vg pwd -t 2
  done
  conda activate base
fi

#tracespipelite - runs
if [[ "$RUN_TRACESPIPELITE" -eq "1" ]] 
  then
  printf "Reconstructing with TracePipeLite\n\n"
  cd TRACESPipeLite/src/  
  for dataset in "${DATASETS[@]}"
    do	
    cp ../../${dataset}_*.fq .
    lzma -d VDB.mfa.lzma
    ./TRACESPipeLite.sh --similarity 50 --threads 1 --reads1 ${dataset}_1.fq --reads2 ${dataset}_2.fq --database VDB.mfa --output test_viral_analysis_${dataset}
    done
  cd ../../
fi

#V-pipe - working to some capacity, missing input files
if [[ "$RUN_VPIPE" -eq "1" ]]
  then
  printf "Reconstructing with V-pipe\n\n"
  cd work
  # edit config.yaml and provide samples/ directory
  ./vpipe --jobs 4 --printshellcmds --dry-run
  cd ..
fi

#Strainline - LAcheck: reads.las is not present
if [[ "$RUN_STRAINLINE" -eq "1" ]] 
  then
  printf "Reconstructing with Strainline\n\n"
  cd Strainline/src/
  chmod +x ./strainline.sh
  for dataset in "${DATASETS[@]}"
    do
    ./strainline.sh -i ../../${dataset}*.fa -o out -p ont
    done
  cd ../../
  
  
fi

#HAPHPIPE - haphpipe command not found error
if [[ "$RUN_HAPHPIPE" -eq "1" ]] 
  then
  printf "Reconstructing with HAPHPIPE\n\n"
  eval "$(conda shell.bash hook)"
  conda activate haphpipe
  haphpipe -h
  conda activate base
  
  
fi

#aBayesQR - working, missing input
if [[ "$RUN_ABAYESQR" -eq "1" ]] 
  then
  printf "Reconstructing with aBayesQR\n\n"
  ./aBayesQR config
    
fi

#HaploClique - missing bam files and remaining execution
if [[ "$RUN_HAPLOCLIQUE" -eq "1" ]] 
  then
  printf "Reconstructing with HaploClique\n\n"
  samtools index alignment.bam
  cd haploclique/scripts/
  chmod +x haploclique-assembly
  ./haploclique-assembly -r ../reference.fasta -i ../alignment.bam
  
  cd ..

fi

#ViSpA - did nothing, no errors
if [[ "$RUN_VISPA" -eq "1" ]] 
  then
  printf "Reconstructing with ViSpA\n\n"  
  eval "$(conda shell.bash hook)"
  conda activate vispa  
  cd home
  rm -rf test
  mkdir test
  touch test/log.txt 
  printf "got here"
  cd code/vispa_mosaik   
  for dataset in "${DATASETS[@]}"
    do	
    cp ../../../${dataset}.fa ../../test
    cp ../../../HPV.fa ../../test    
    ./main_mosaik.bash ../../test/${dataset}.fa ../../test/HPV.fa 15 6 120 > ../../test/log.txt
    done    
    conda activate base  
fi

#QuasiRecomb -> java.lang.UnsupportedOperationException, probably an error with the sam file
if [[ "$RUN_QUASIRECOMB" -eq "1" ]] 
  then
  printf "Reconstructing with QuasiRecomb\n\n"
  for dataset in "${DATASETS[@]}"
    do
    java -jar QuasiRecomb.jar -i ${dataset}_.sam
    done
fi

#Lazypipe 
if [[ "$RUN_LAZYPIPE" -eq "1" ]] 
  then
  printf "Reconstructing with Lazypipe\n\n"
  
fi

#ViQuaS - missing .bam files
if [[ "$RUN_VIQUAS" -eq "1" ]] 
  then
  printf "Reconstructing with ViQuaS\n\n"
  create_bam_files
  cd ViQuaS1.3
  #Rscript ViQuaS.R ../DS1.fa <read file in BAM format> <o> <r> <perform richness (1/0)> <diversityRegionLength>
  cd ..
  
fi

#MLEHaplo
if [[ "$RUN_MLEHAPLO" -eq "1" ]] 
  then
  printf "Reconstructing with MLEHaplo\n\n"
  
fi

#PEHaplo - likely an error on the input files, _1 _2 .fa required?, working with test example
if [[ "$RUN_PEHAPLO" -eq "1" ]] 
  then
  printf "Reconstructing with PEHaplo\n\n"
  #cd PEHaplo 
  #rm -rf assembly 
  #mkdir assembly  
  #cd assembly  
  #eval "$(conda shell.bash hook)"
  #conda activate pehaplo
  #python ../pehaplo.py -f1 ../../DS1_1.fq -f2 ../../DS1_2.fq -l 20 -r 200 
  
  #python ../apsp_overlap_clique.py ../../DS1.fa ../../DS1.fa 180 250 600 210 
  
  #python ../apsp_overlap_clique.py ../processed_test_data/Plus_strand_reads.fa ../processed_test_data/pair_end_connections.txt 180 250 600 210 
  #cd ../../
  #conda activate base
  
  cd TAR-VIR/PEHaplo/
  eval "$(conda shell.bash hook)"
  conda activate bio2
  for dataset in "${DATASETS[@]}"
    do	
    rm -rf assembly_${dataset}
    mkdir assembly_${dataset}
    rm -rf data
    mkdir data
    cd data
    cp ../../../${dataset}_1.fq .
    cp ../../../${dataset}_2.fq .
    cd ../assembly_${dataset}
    #python ../pehaplo.py -f1 ../raw_test_data/virus_1.fa -f2 ../raw_test_data/virus_2.fa -l 180 -l1 210 -r 250 -F 600 -std 150 -n 3 -correct yes
    python ../pehaplo.py -f1 ../data/${dataset}_1.fq -f2 ../data/${dataset}_2.fq -l 180 -l1 210 -r 250 -F 600 -std 150 -n 3 -correct yes
  done
  conda activate base
  
fi

#RegressHaplo
if [[ "$RUN_REGRESSHAPLO" -eq "1" ]] 
  then
  printf "Reconstructing with RegressHaplo\n\n"
  
fi

#CliqueSNV
if [[ "$RUN_CLIQUESNV" -eq "1" ]] 
  then
  printf "Reconstructing with CliqueSNV\n\n"
  cd CliqueSNV-2.0.3
  for dataset in "${DATASETS[@]}"
    do
    java -jar clique-snv.jar -m snv-illumina -in ../${dataset}_.sam
    done
  cd ..  
fi

#IVA
if [[ "$RUN_IVA" -eq "1" ]] 
  then
  printf "Reconstructing with IVA\n\n"
  
fi

#PRICE - did nothing, no errors
if [[ "$RUN_PRICE" -eq "1" ]] 
  then
  printf "Reconstructing with PRICE\n\n"
  cd PriceSource130506
  for dataset in "${DATASETS[@]}"
    do
    ./PriceTI -fp ../${dataset}_1.fq ../${dataset}_2.fq 100 -nc 20 -a 2 -o result_${dataset}.fasta
    done
  cd ..
  
fi

#VirGenA - missing changes to config.xml file
if [[ "$RUN_VIRGENA" -eq "1" ]] 
  then
  printf "Reconstructing with VirGenA\n\n"
  cd release_v1.4
  java -jar VirGenA.jar map -c config.xml -r ../B19.fa -p1 ../DS1_1.fq -p2 ../DS1_2.fq
  cd ..
  
fi

#TAR-VIR - .fa file error probably, segmentation fault, working with test example
if [[ "$RUN_TARVIR" -eq "1" ]] 
  then
  printf "Reconstructing with TAR-VIR\n\n"
  #cd TAR-VIR
  #./build -f ../DS1.fa -o prefix

  
  cd TAR-VIR/
  rm -rf data
  mkdir data
  cd Overlap_extension/
  
  cp ../../DS1.fa ../data
  cp ../../DS1_.sam ../data
  ./build -f ../data/DS1.fa -o virus
  ./overlap -S ../data/DS1_.sam -x virus -f ../data/DS1.fa -c 180 -o virus_recruit.fa
  
  cd ../../
fi

#VIP - DS1.fa.preprocessed.fastq missing
if [[ "$RUN_VIP" -eq "1" ]] 
  then
  printf "Reconstructing with VIP\n\n"
  cd VIP
  chmod +x ./VIP.sh
  cp ../DS1_1.fq .
  cp ../DS1.fa .
  cp ../VZV.fa .
  ./VIP.sh -z -i DS1.fa -p illumina -f fasta -r VZV.fa
  ./VIP.sh -c DS1.fa.conf -i DS1.fa
  cd ..
fi

#drVM - ./drVM.py: /usr/bin/python: bad interpreter: No such file or directory
if [[ "$RUN_DRVM" -eq "1" ]] 
  then
  printf "Reconstructing with drVM\n\n"
  cd Tools 
  ./drVM.py -1 DS1_1.fq -2 DS1_2.fq -t 1 -keep
  cd ..
fi

#SSAKE - probably bad parameters, running
if [[ "$RUN_SSAKE" -eq "1" ]] 
  then
  printf "Reconstructing with SSAKE\n\n"
  cd ssake/tools/
  ./runSSAKE.sh ../../DS1_1.fq ../../DS1_2.fq 10 ds1_assembly
  cd ../../

fi

#viralFlye - missing scipy
if [[ "$RUN_VIRALFLYE" -eq "1" ]] 
  then
  printf "Reconstructing with viralFlye\n\n"
  eval "$(conda shell.bash hook)"
  conda activate viralFlye
  cd viralFlye
  ./viralFlye.py
  cd ..
  conda activate base
fi

#EnsembleAssembler 
if [[ "$RUN_ENSEMBLEASSEMBLER" -eq "1" ]] 
  then
  printf "Reconstructing with EnsembleAssembler \n\n"
  
  
  
fi

 
