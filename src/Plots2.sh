#!/bin/bash
#
cp reconstructed/total_stats.tsv .
declare -a TOOLS=("coronaSPAdes" "Haploflow" "LAZYPIPE" "metaSPAdes" "metaviralSPAdes" "PEHaplo" "QuRe" "QVG" "SPAdes" "SSAKE" "TRACESPipe" "TRACESPipeLite" "VirGenA" "ViSpA" "V-pipe")
#declare -a list
#declare -p list
#
rm -rf vir
#rm -rf Graphs
mkdir vir
mkdir Graphs
i=""
declare ans

mkdir vir
for tool in "${TOOLS[@]}" 
  do
  
  i=$(echo "$tool" | tr '[:upper:]' '[:lower:]' )
  
  cd vir 
  
  declare -a DATASETS=("13" "63" "64" "65")
  printf "" > $tool
  
  for ds in "${DATASETS[@]}" 
    do 
    content=$(cat ../total_stats.tsv | tr ',' '.' | grep -w "${i}-*" | awk -v data=DS$ds '{if ($1==data) {print $0}}')       
    
    if [ -z "$content" ]
      then      
      printf "\t \t \t \t \t \t \t \t \t \t \t \t \t \t \n" >> $tool     
    else
      printf "$content\n\n"
      content=${content:2}
      printf "$content\n" >> $tool
      content=""
    fi    
  done
  cd ..
   
done
#
mkdir vir_2
for tool in "${TOOLS[@]}" 
  do
  
  i=$(echo "$tool" | tr '[:upper:]' '[:lower:]' )
  
  cd vir_2 
  
  declare -a DATASETS=("5" "13" "57" "58")
  printf "" > $tool
  
  for ds in "${DATASETS[@]}" 
    do 
    content=$(cat ../total_stats.tsv | tr ',' '.' | grep -w "${i}-*" | awk -v data=DS$ds '{if ($1==data) {print $0}}')       
    
    if [ -z "$content" ]
      then      
      printf "\t \t \t \t \t \t \t \t \t \t \t \t \t \t \n" >> $tool     
    else
      printf "$content\n\n"
      content=${content:2}
      printf "$content\n" >> $tool
      content=""
    fi    
  done
  cd ..
   
done
#
mkdir vir_3
for tool in "${TOOLS[@]}" 
  do
  
  i=$(echo "$tool" | tr '[:upper:]' '[:lower:]' )
  
  cd vir_3 
  
  declare -a DATASETS=("61" "13" "62")
  printf "" > $tool
  
  for ds in "${DATASETS[@]}" 
    do 
    content=$(cat ../total_stats.tsv | tr ',' '.' | grep -w "${i}-*" | awk -v data=DS$ds '{if ($1==data) {print $0}}')       
    
    if [ -z "$content" ]
      then      
      printf "\t \t \t \t \t \t \t \t \t \t \t \t \t \t \n" >> $tool     
    else
      printf "$content\n\n"
      content=${content:2}
      printf "$content\n" >> $tool
      content=""
    fi    
  done
  cd ..
   
done
#
list_tools=($(ls vir)) 
list_tools_2=($(ls vir_2)) 
list_tools_3=($(ls vir_3))  
#  
#printf "${list[*]} \n\n"
#
cd vir
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Identity_vir.pdf"
    set datafile separator "\t"
    
    ymax = 100.1
    ymin = 95
    offset = ( ymax - ymin ) / 15.0    
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("13" 0, "63" 1, "64" 2, "65" 3)
    set ytics auto
    set ylabel "Average Identity"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:5:1 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NCSD_vir.pdf"
    set datafile separator "\t"
    
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("13" 0, "63" 1, "64" 2, "65" 3)
    set ytics auto
    set ylabel "NCSD"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:6:1 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NRC_vir.pdf"
    set datafile separator "\t"
    
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("13" 0, "63" 1, "64" 2, "65" 3)
    set ytics auto
    set ylabel "NRC"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:7:1 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
      
    }
EOF
#
cp *.pdf ../Graphs
cd ../vir_2
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Identity_cont.pdf"
    set datafile separator "\t"
    
    ymax = 100.1
    ymin = 95
    offset = ( ymax - ymin ) / 15.0    
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("5" 0, "13" 1, "57" 2, "58" 3)
    set ytics auto
    set ylabel "Average Identity"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:5:1 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NCSD_cont.pdf"
    set datafile separator "\t"
    
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("5" 0, "13" 1, "57" 2, "58" 3)
    set ytics auto
    set ylabel "NCSD"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:6:1 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NRC_cont.pdf"
    set datafile separator "\t"
    
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("5" 0, "13" 1, "57" 2, "58" 3)
    set ytics auto
    set ylabel "NRC"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:7:1 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
      
    }
EOF
cp *.pdf ../Graphs
#
#
cd ../vir_3
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Identity_length.pdf"
    set datafile separator "\t"
    
    ymax = 100.5
    ymin = 0
    offset = ( ymax - ymin ) / 15.0    
    set yrange [ymin:ymax]
    set xrange [-0.2:2.2]
    set key outside right top
    set xtics ("61" 0, "13" 1, "62" 2)
    set ytics auto
    set ylabel "Average Identity"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_tools[@]}"]{  
      set key at 3.3, ymax
      plot file u 0:5:1 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NCSD_length.pdf"
    set datafile separator "\t"
    
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [-0.2:2.2]
    set key outside right top
    set xtics ("61" 0, "13" 1, "62" 2)
    set ytics auto
    set ylabel "NCSD"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_tools[@]}"]{  
      set key at 3.3, ymax
      plot file u 0:6:1 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NRC_length.pdf"
    set datafile separator "\t"
    
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/15.0   
    set yrange [ymin:ymax]
    set xrange [-0.2:2.2]
    set key outside right top
    set xtics ("61" 0, "13" 1, "62" 2)
    set ytics auto
    set ylabel "NRC"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    count = 1
    do for [ file in "${list_tools[@]}"]{  
      set key at 3.3, ymax
      plot file u 0:7:1 title file with linespoints linestyle count
      count = count + 1
      if(count == 9){
        count = count + 1
      }
      ymax = ymax - offset
      
    }
EOF
cp *.pdf ../Graphs
#
cd ..
#
