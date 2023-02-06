#!/bin/bash

RUN_SHORAH=0;
RUN_QURE=0;
RUN_SAVAGE=0;
RUN_QSDPR=0;
RUN_SPADES=0;
RUN_METAVIRALSPADES=0;
RUN_CORONASPADES=0;
RUN_VIADBG=0;
RUN_VIRUSVG=0;
RUN_VGFLOW=0;
RUN_PREDICTHAPLO=0;
RUN_TRACESPIPELITE=0;
RUN_TRACESPIPE=0;
RUN_ASPIRE=0;
RUN_QVG=0;
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
RUN_HAPLOFLOW=0;
RUN_TENSQR=1;
RUN_ARAPANS=0; #Not available
RUN_VIQUF=0;

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

#spades - working
if [[ "$RUN_SPADES" -eq "1" ]] 
  then
  printf "Reconstructing with SPAdes\n\n"
  cd SPAdes-3.15.5-Linux/bin/
  for dataset in "${DATASETS[@]}"
    do	
    rm -rf spades_${dataset}
    mkdir spades_${dataset}
    cp  ../../${dataset}_1.fq spades_${dataset}
    cp  ../../${dataset}_2.fq spades_${dataset}
    #spades.py -o spades_${dataset} -1 ${dataset}_1.fq -2 ${dataset}_2.fq
    python spades.py -o spades_${dataset} -1 spades_${dataset}/${dataset}_1.fq -2 spades_${dataset}/${dataset}_2.fq --meta
    done
  cd ../../
fi

#metaviralspades - runs, results not found
if [[ "$RUN_METAVIRALSPADES" -eq "1" ]] 
  then
  printf "Reconstructing with metaviralSPAdes\n\n"
  cd SPAdes-3.15.5-Linux/bin/
  for dataset in "${DATASETS[@]}"
    do
    rm -rf metaviralspades_${dataset}
    mkdir metaviralspades_${dataset}	
    cp ../../${dataset}_1.fq metaviralspades_${dataset}
    cp ../../${dataset}_2.fq metaviralspades_${dataset}
    ./metaviralspades.py -t 1 -o metaviralspades_${dataset} -1 metaviralspades_${dataset}/${dataset}_1.fq -2 metaviralspades_${dataset}/${dataset}_2.fq
  done
  cd ../../
fi

#coronaspades - runs, doesn't output scaffolds
if [[ "$RUN_CORONASPADES" -eq "1" ]] 
  then
  printf "Reconstructing with coronaSPAdes\n\n"
  cd SPAdes-3.15.5-Linux/bin/
  for dataset in "${DATASETS[@]}"
    do
    rm -rf coronaspades_${dataset}
    mkdir coronaspades_${dataset}	
    cp ../../${dataset}_1.fq coronaspades_${dataset}
    cp ../../${dataset}_2.fq coronaspades_${dataset}
    ./coronaspades.py -o coronaspades_${dataset} -1 coronaspades_${dataset}/${dataset}_1.fq -2 coronaspades_${dataset}/${dataset}_2.fq
  done
  cd ../../
fi

#viaDBG - missing ./bin/viaDBG file, bin is empty
if [[ "$RUN_VIADBG" -eq "1" ]] 
  then
  printf "Reconstructing with viaDBG\n\n"
  cd viadbg/
  for dataset in "${DATASETS[@]}"
    do
    rm -rf viadbg_${dataset}
    mkdir viadbg_${dataset}	
    cp ../${dataset}_1.fq viadbg_${dataset}
    cp ../${dataset}_2.fq viadbg_${dataset}
    mkdir output_${dataset}
    ./bin/viaDBG -p viadbg_${dataset} -o output_${dataset}
    done
fi

#savage - Runs, no reads could be aligned to reference error
if [[ "$RUN_SAVAGE" -eq "1" ]] 
  then
  printf "Reconstructing with SAVAGE\n\n"
  eval "$(conda shell.bash hook)"
  conda activate savage
  rm -rf savage
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

#qsdpr - missing vcf file?, error on samtools configuration
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
    rm -rf samples_virusvg
    mkdir samples_virusvg
    cp ${dataset}_1.fq ${dataset}_2.fq ${dataset}.fa samples_virusvg
    jbaaijens-virus-vg-69a05f3e74f2/scripts/build_graph_msga.py -f samples_virusvg/${dataset}_1.fq -r samples_virusvg/${dataset}_2.fq -c samples_virusvg/${dataset}.fa -vg vg -t 2
  done
  conda activate base
fi

#vg-flow - running with errors, rust-overlaps not found - json.decoder.JSONDecodeError
if [[ "$RUN_VGFLOW" -eq "1" ]] 
  then
  printf "Reconstructing with VG-Flow\n\n"
  eval "$(conda shell.bash hook)"
  conda activate vg-flow-env
  chmod +x jbaaijens-vg-flow-ac68093bbb23/scripts/build_graph_msga.py
  for dataset in "${DATASETS[@]}"
    do
    rm -rf samples_vgflow
    mkdir samples_vgflow
    cp ${dataset}_1.fq ${dataset}_2.fq ${dataset}.fa samples_vgflow
    jbaaijens-vg-flow-ac68093bbb23/scripts/build_graph_msga.py -f samples_vgflow/${dataset}_1.fq -r ${dataset}_2.fq -c samples_vgflow/${dataset}.fa -vg pwd -t 2
  done
  conda activate base
fi

#PredictHaplo - error on installation
if [[ "$RUN_PREDICTHAPLO" -eq "1" ]] 
  then
  printf "Reconstruction with PredictHaplo is not available\n\n"
fi

#tracespipelite - working
if [[ "$RUN_TRACESPIPELITE" -eq "1" ]] 
  then
  printf "Reconstructing with TRACESPipeLite\n\n"
  eval "$(conda shell.bash hook)"  
  conda activate tracespipelite
  cd TRACESPipeLite/src/  
  for dataset in "${DATASETS[@]}"
    do	
    cp ../../${dataset}_*.fq .
    lzma -d VDB.mfa.lzma
    ./TRACESPipeLite.sh --similarity 50 --threads 1 --reads1 ${dataset}_1.fq --reads2 ${dataset}_2.fq --database VDB.mfa --output test_viral_analysis_${dataset}
    done
  cd ../../
  conda activate base
fi

#tracespipe - input files are not gzipped error
if [[ "$RUN_TRACESPIPE" -eq "1" ]] 
  then
  printf "Reconstructing with TRACESPipe\n\n"
  eval "$(conda shell.bash hook)"
  conda activate tracespipe
  cd tracespipe/
  for dataset in "${DATASETS[@]}"
    do	
    cd meta_data/
    rm -rf meta_info.txt
    echo 'unspecified:'${dataset}'_1.fq.gz:'${dataset}'_2.fq.gz'  >> meta_info.txt
    cd ../input_data/
    cp ../../${dataset}_*.fq .
    rm -rf ${dataset}_*.fq.gz
    gzip ${dataset}_1.fq
    gzip ${dataset}_2.fq
    cd ../src/  
    ./TRACESPipe.sh --run-hybrid
    cd ..
    done
  cd ..   
  conda activate base  
fi

#ASPIRE - Can't locate App/Cmd/Setup.pm
if [[ "$RUN_ASPIRE" -eq "1" ]] 
  then
  printf "Reconstructing with ASPIRE\n\n"
  cd aspire
  ./aspire
  cd ..
fi

#QVG - working
if [[ "$RUN_QVG" -eq "1" ]] 
  then
  printf "Reconstructing with QVG\n\n"
  eval "$(conda shell.bash hook)"
  conda activate qvg-env
  cd QVG
  rm -rf reconstruction_files
  mkdir reconstruction_files
  for dataset in "${DATASETS[@]}"
    do	   
    rm -rf ${dataset}_files
    mkdir ${dataset}_files
    echo "${dataset}" >> ${dataset}_files/samples
    cd ${dataset}_files
    mkdir output
    cp ../../${dataset}_*.fq .
    gzip -cvf ${dataset}_1.fq > ${dataset}_R1.fastq.gz
    gzip -cvf ${dataset}_2.fq > ${dataset}_R2.fastq.gz
    #gzip ${dataset}_1.fq
    #gzip ${dataset}_2.fq
    cd ..
    cp ../B19.fa reconstruction_files
    ./QVG.sh -r ./reconstruction_files/B19.fa -samples-list ./${dataset}_files/samples -s ./${dataset}_files -o ./${dataset}_files/output -annot yes
    done
  cd ..
  conda activate base 
fi

#V-pipe - working to some capacity, missing input files
if [[ "$RUN_VPIPE" -eq "1" ]]
  then
  printf "Reconstructing with V-pipe\n\n"
  eval "$(conda shell.bash hook)"
  conda activate vpipe 
  cd V-pipe-2.99.3
  for dataset in "${DATASETS[@]}"
    do  
    cd config
    echo "general:
  virus_base_config: hiv

input:
  datadir: samples
  samples_file: config/samples.tsv

output:
  datadir: results
  snv: true
  local: true
  global: false
  visualization: true
  QA: true" >> config.yaml
    # edit config.yaml and provide samples/ directory
    ./vpipe --cores 1
    cd ..
  done
  conda activate base
fi

#Strainline - seg. fault; reads.las not present
if [[ "$RUN_STRAINLINE" -eq "1" ]] 
  then
  printf "Reconstructing with Strainline\n\n"
  eval "$(conda shell.bash hook)"
  conda activate strainline
  cd Strainline/src/
  chmod +x ./strainline.sh
  for dataset in "${DATASETS[@]}"
    do
    cp ../../${dataset}.fa .
    #./strainline.sh -i ../../${dataset}*.fa -o out -p ont
    ./strainline.sh -i ${dataset}.fa -o out -p pb -k 20 -t 32
    done
  cd ../../
  conda activate base
  
  
fi

#HAPHPIPE - error mid code 
if [[ "$RUN_HAPHPIPE" -eq "1" ]] 
  then
  printf "Reconstructing with HAPHPIPE\n\n"
  eval "$(conda shell.bash hook)"
  conda activate haphpipe
  rm -rf haphpipe_data
  mkdir haphpipe_data
  cd haphpipe_data
   
  for dataset in "${DATASETS[@]}"
    do
    #haphpipe -h    
    cp ../${dataset}_*.fq .
    
    rm -rf denovo_assembly_${dataset}
    mkdir denovo_assembly_${dataset}
    
    haphpipe assemble_denovo --fq1 ${dataset}_1.fq --fq2 ${dataset}_2.fq --outdir denovo_assembly_${dataset} #--no_error_correction TRUE
  done
  cd ..
  conda activate base 
fi

#aBayesQR - input is probably wrong?? , segmentation fault
if [[ "$RUN_ABAYESQR" -eq "1" ]] 
  then
  printf "Reconstructing with aBayesQR\n\n"
  cd aBayesQR 
  for dataset in "${DATASETS[@]}"
    do
    #cp ${dataset}_*.fq .
    cp ../B19.fa ../${dataset}_.sam .
    rm -rf config_${dataset}
    echo "filename of reference sequence (FASTA) : B19.fa
filname of the aligned reads (sam format) : DS1_.sam
paired-end (1 = true, 0 = false) : 1
SNV_thres : 0.01
reconstruction_start : 1
reconstruction_stop: 1300
min_mapping_qual : 60
min_read_length : 150
max_insert_length : 250
characteristic zone name : test
seq_err (assumed sequencing error rate(%)) : 0.1
MEC improvement threshold : 0.0395 " >> config_${dataset}
    ./aBayesQR config_${dataset}
    done
  cd ..
    
fi

#HaploClique - missing bam files and remaining execution, try later
if [[ "$RUN_HAPLOCLIQUE" -eq "1" ]] 
  then
  printf "Reconstructing with HaploClique\n\n"
  eval "$(conda shell.bash hook)"
  conda activate haploclique  
  create_bam_files
  
  #samtools index alignment.bam
  #cd haploclique/scripts/
  #chmod +x haploclique-assembly
  
  #for dataset in "${DATASETS[@]}"
  #  do
  #  cp ../../$dataset.fa .
  #  #cp ../../B19.bam #missing bam generation
  #  ./haploclique-assembly -r ../reference.fasta -i ../alignment.bam
  #done
  #cd ..
  conda activate base

fi

#ViSpA - index file for DS1.bam err; missing DS1_I_6_120_CNTGS_DIST0.txt
if [[ "$RUN_VISPA" -eq "1" ]] 
  then
  printf "Reconstructing with ViSpA\n\n"  
  eval "$(conda shell.bash hook)"
  conda activate vispa  
  cd home
  rm -rf test
  mkdir test
  #touch test/log.txt 
  cd code/vispa_mosaik   
  for dataset in "${DATASETS[@]}"
    do	
    cp ../../../${dataset}.fa ../../test
    cp ../../../HPV.fa ../../test  
    echo "" >> ../../test/${dataset}.txt
    ./main_mosaik.bash ../../test/${dataset}.fa ../../test/HPV.fa 15 6 120 > ../../test/log.txt
    done    
    conda activate base  
fi

#QuasiRecomb -> ParsingException in thread "main" java.lang.reflect.InvocationTargetException
if [[ "$RUN_QUASIRECOMB" -eq "1" ]] 
  then
  printf "Reconstructing with QuasiRecomb\n\n"
  eval "$(conda shell.bash hook)"
  conda activate quasirecomb
  cd QuasiRecomb-1.2
  for dataset in "${DATASETS[@]}"
    do
    cp ../${dataset}_.sam .
    #java -jar QuasiRecomb.jar -i ${dataset}_.sam
    java -jar QuasiRecomb.jar -i ${dataset}_.sam -coverage
    done
  conda activate base
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

#MLEHaplo - no errors 0 vertices and 0 edges on the DBG
if [[ "$RUN_MLEHAPLO" -eq "1" ]] 
  then
  printf "Reconstructing with MLEHaplo\n\n"
  eval "$(conda shell.bash hook)"
  conda activate mlehaplo
  cd MLEHaplo-0.4.1
  rm -rf benchmark
  mkdir benchmark
  
  for dataset in "${DATASETS[@]}"
    do
    cd benchmark
    echo ${dataset}"_1.fq
"${dataset}"_2.fq" > files_${dataset}.txt
    echo "55
45
35
25" > kmers_${dataset}.txt
    cp ../../${dataset}_*.fq .
    cp ../../${dataset}.fa .
    cd ..
    
    #./multi-dsk/multi-dsk benchmark/${dataset}.fa  benchmark/kmers_${dataset}.txt  -m 8192 -d 10000
    #
    #./multi-dsk/parse_results benchmark/paired-reads.solid_kmers_binary.60 > paired-reads.60
    #perl construct_graph.pl  benchmark/${dataset}.fa paired-reads.60 0 paired-reads.60.graph "s"
    #perl construct_paired_without_bloom.pl -fasta benchmark/${dataset}.fa -kmerfile paired-reads.60 -thresh 0 -wr paired-reads.60.pk.txt
    #incomplete - DBG graph is empty
    
    #example given
    ./multi-dsk/multi-dsk Example/paired-reads.fasta  Example/listofkmers.txt  -m 8192 -d 10000
    ./multi-dsk/parse_results Example/paired-reads.solid_kmers_binary.60 > paired-reads.60
    perl construct_graph.pl  Example/paired-reads.fasta paired-reads.60 0 paired-reads.60.graph "s"
    perl construct_paired_without_bloom.pl -fasta Example/paired-reads.fasta -kmerfile paired-reads.60 -thresh 0 -wr paired-reads.60.pk.txt
    perl dg_cover.pl -graph paired-reads.60.graph -kmer paired-reads.60 -paired paired-reads.60.pk.txt -fact 15 -thresh 0 -IS 400 > paired-reads.60.fact15.txt
    perl process_dg.pl paired-reads.60.fact15.txt > paired-reads.60.fact15.fasta
    perl get_paths_dgcover.pl -f paired-reads.60.fact15.txt -w paired-reads.60.fact15.paths.txt
    perl likelihood_singles_wrapper.pl -condgraph paired-reads.60.cond.graph -compset paired-reads.60.comp.txt -pathsfile paired-reads.60.fact15.paths.txt -back -gl 1200 -slow  > paired-reads.60.smxlik.txt
    perl extract_MLE.pl -f paired-reads.60.fact15.fasta -l paired-reads.60.smxlik.txt > paired-reads.60.MLE.fasta
    
    
    
  
  done
  conda activate base
  
  
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

#CliqueSNV - working
if [[ "$RUN_CLIQUESNV" -eq "1" ]] 
  then
  printf "Reconstructing with CliqueSNV\n\n"
  cd CliqueSNV-2.0.3
  for dataset in "${DATASETS[@]}"
    do
    cp ../${dataset}_.sam .
    java -jar clique-snv.jar -m snv-illumina -in ${dataset}_.sam
    done
  cd ..  
fi

#IVA
if [[ "$RUN_IVA" -eq "1" ]] 
  then
  printf "Reconstructing with IVA\n\n"
  iva --test outdir
  
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

#VirGenA - missing changes to config.xml file; example err . java.io.IOException: Cannot run program "makeblastdb": error=2, No such file or directory
if [[ "$RUN_VIRGENA" -eq "1" ]] 
  then
  printf "Reconstructing with VirGenA\n\n"
  cd release_v1.4
  chmod +x ./tools/vsearch
  for dataset in "${DATASETS[@]}"
    do
    java -jar VirGenA.jar assemble -c config_test_linux.xml
    #java -jar VirGenA.jar map -c config.xml -r ../B19.fa -p1 ../DS1_1.fq -p2 ../DS1_2.fq
  done
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
  eval "$(conda shell.bash hook)"
  conda activate vip
  cd VIP-master
  chmod +x ./VIP.sh
  cp ../DS1_1.fq .
  cp ../DS1.fa .
  cp ../VZV.fa .
  ./VIP.sh -z -i DS1.fa -p illumina -f fasta -r VZV.fa
  ./VIP.sh -c DS1.fa.conf -i DS1.fa
  cd ..
  conda activate base
fi

#drVM - ./drVM.py: /usr/bin/python: bad interpreter: No such file or directory
if [[ "$RUN_DRVM" -eq "1" ]] 
  then
  printf "Reconstructing with drVM\n\n"
  cd Tools 
  ls
  ./drVM.py #-1 DS1_1.fq -2 DS1_2.fq -t 1 -keep
  cd ..
fi

#SSAKE - probably bad parameters, running
if [[ "$RUN_SSAKE" -eq "1" ]] 
  then
  printf "Reconstructing with SSAKE\n\n"
  cd ssake/tools/
  
  for dataset in "${DATASETS[@]}"
    do
    cp ../../${dataset}_*.fq .
    ./runSSAKE.sh ${dataset}_1.fq ${dataset}_2.fq 10 ${dataset}_assembly
  done
  cd ../../

fi

#viralFlye - err can't find out dir
if [[ "$RUN_VIRALFLYE" -eq "1" ]] 
  then
  printf "Reconstructing with viralFlye\n\n"
  eval "$(conda shell.bash hook)"
  conda activate viralFlye
  cd viralFlye
  rm -rf flye_assembly_dir
  mkdir flye_assembly_dir 
  cd flye_assembly_dir 
  cp ../../DS1_*.fq .
  cd ..
  rm -rf out
  mkdir out
  
  ./viralFlye.py --dir $(pwd)/out --hmm ../Pfam-A.hmm.gz --reads $(pwd)/flye_assembly_dir #--outdir flye_assembly_dir
  cd ..
  conda activate base
fi

#EnsembleAssembler - err /usr/bin/env: ‘python\r’: No such file or directory
if [[ "$RUN_ENSEMBLEASSEMBLER" -eq "1" ]] 
  then
  printf "Reconstructing with EnsembleAssembler \n\n"
  eval "$(conda shell.bash hook)"
  conda activate ensembleAssembler
  for dataset in "${DATASETS[@]}"
    do
    rm -rf ${dataset}_ea
    mkdir ${dataset}_ea
    cd ${dataset}_ea
    ../ensembleAssembly_1/ensembleAssembly ./config.txt
    #chmod +x ./ensemble.sh
    #./ensemble.sh
    
  done
  conda activate base 
  
fi

#Haploflow -working
if [[ "$RUN_HAPLOFLOW" -eq "1" ]] 
  then
  printf "Reconstructing with Haploflow\n\n"
  eval "$(conda shell.bash hook)"
  conda activate haploflow
  rm -rf haploflow_data
  mkdir haploflow_data
  cd haploflow_data
  for dataset in "${DATASETS[@]}"
    do
    cp ../${dataset}_1.fq .
    haploflow --read-file ${dataset}_1.fq --out test --log test/log    
  done
  cd ..  
  conda activate base 
fi

#TenSQR - FileNotFoundError: sample_SNV_matrix.txt not found.
if [[ "$RUN_TENSQR" -eq "1" ]] 
  then
  printf "Reconstructing with TenSQR\n\n"
  cd TenSQR
  rm -rf reconstruction_data
  for dataset in "${DATASETS[@]}"
    do
    cp ../${dataset}_.sam .
    cp ../B19.fa .
    echo "filename of reference sequence (FASTA) : B19.fa
filname of the aligned reads (sam format) : "${dataset}_.sam"
SNV_thres : 0.01
reconstruction_start : 500
reconstruction_stop: 1200
min_mapping_qual : 40
min_read_length : 100
max_insert_length : 500
characteristic zone name : sample
seq_err (assumed sequencing error rate(%)) : 0.2
MEC improvement threshold : 0.0312
initial population size : 5" >> config_${dataset}
    ExtractMatrix config_${dataset}
    python3 TenSQR.py config_${dataset}  
    
  done  
  cd ..
  
fi

#ViQUF - err on installation
if [[ "$RUN_VIQUF" -eq "1" ]] 
  then
  printf "Reconstructing with ViQUF\n\n"
  eval "$(conda shell.bash hook)"
  conda activate viquf
  cd ViQUF
  
  for dataset in "${DATASETS[@]}"
    do
    
  done
  
  cd ..
  conda activate base  
fi


 
