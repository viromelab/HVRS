#!/bin/bash
#
cp reconstructed/total_stats.tsv .
declare -a TOOLS=("coronaSPAdes" "Haploflow" "IRMA" "LAZYPIPE" "metaSPAdes" "metaviralSPAdes" "PEHaplo" "QuRe" "QVG" "SPAdes" "SSAKE" "TRACESPipe" "TRACESPipeLite" "VirGenA" "ViSpA" "V-pipe")
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
    content=$(cat ../total_stats.tsv | tr ',' '.' | tr -d '%' | grep -w "${i}-*" | awk -v data=DS$ds '{if ($1==data) {print $0}}')       
    
    if [ -z "$content" ]
      then      
      printf "\t \t \t \t \t \t \t \t \t \t \t \t \t \t \n" >> $tool     
    else
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
      content=${content:2}
      printf "$content\n" >> $tool
      content=""
    fi    
  done
  cd ..
   
done
#
mkdir vir_4
for tool in "${TOOLS[@]}" 
  do
  
  i=$(echo "$tool" | tr '[:upper:]' '[:lower:]' )
  
  cd vir_4
  
  declare -a DATASETS=("SRR23101281" "SRR23101235" "SRR23101259" "SRR23101276" "SRR23101228" "SRR12175231")
  printf "" > $tool
  
 for ds in "${DATASETS[@]}" 
    do 
    content=$(cat ../total_stats.tsv | tr ',' '.' | grep -w "${i}-*" | awk -v data=$ds '{if ($1==data) {print $0}}')       
    
    if [ -z "$content" ]
      then      
      printf "\t \t \t \t \t \t \t \t \t \t \t \t \t \t \n" >> $tool     
    else
      content=${content:3}
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
list_tools_4=($(ls vir_4))  
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
    offset = ( ymax - ymin ) / 16.0   
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("13" 0, "63" 1, "64" 2, "65" 3)
    set ytics auto
    set ylabel "Identity"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:5:1 title file with linespoints linestyle count
      count = count + 1
      
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
    offset = ( ymax - ymin )/16.0  
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
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:6:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "NRC_vir.pdf"
    set datafile separator "\t"
    
    ymax = 1.05
    ymin = 0
    offset = ( ymax - ymin )/16.0  
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
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:7:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Recon_bases_vir.pdf"
    set datafile separator "\t"
    
    ymax = 1000000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("13" 0, "63" 1, "64" 2, "65" 3)
    set ytics auto
    set ylabel "Number of bases reconstructed"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:16:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Min_scaffold_vir.pdf"
    set datafile separator "\t"
    
    ymax = 6000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("13" 0, "63" 1, "64" 2, "65" 3)
    set ytics auto
    set ylabel "Minimum scaffold length"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:17:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Max_scaffold_vir.pdf"
    set datafile separator "\t"
    
    ymax = 250000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("13" 0, "63" 1, "64" 2, "65" 3)
    set ytics auto
    set ylabel "Maximum scaffold length"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:18:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Avg_scaffold_vir.pdf"
    set datafile separator "\t"
    
    ymax = 100000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("13" 0, "63" 1, "64" 2, "65" 3)
    set ytics auto
    set ylabel "Average scaffold length"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:19:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Recon_bases_wout_n_vir.pdf"
    set datafile separator "\t"
    
    ymax = 1000000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("13" 0, "63" 1, "64" 2, "65" 3)
    set ytics auto
    set ylabel "Number of bases reconstructed (excluding N)"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:20:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Min_scaffold_wout_n_vir.pdf"
    set datafile separator "\t"
    
    ymax = 6000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("13" 0, "63" 1, "64" 2, "65" 3)
    set ytics auto
    set ylabel "Minimum scaffold length (excluding N)"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:21:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Max_scaffold_wout_n_vir.pdf"
    set datafile separator "\t"
    
    ymax = 250000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("13" 0, "63" 1, "64" 2, "65" 3)
    set ytics auto
    set ylabel "Maximum scaffold length (excluding N)"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:22:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Avg_scaffold_wout_n_vir.pdf"
    set datafile separator "\t"
    
    ymax = 100000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("13" 0, "63" 1, "64" 2, "65" 3)
    set ytics auto
    set ylabel "Average scaffold length (excluding N)"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:23:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "ratio_snps_vir.pdf"
    set datafile separator "\t"
    
    ymax = 0.004
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("13" 0, "63" 1, "64" 2, "65" 3)
    set ytics auto
    set ylabel "Ratio between the number of SNPs\nand the number of bases reconstructed"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:24:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "ratio_snps_wout_n_vir.pdf"
    set datafile separator "\t"
    
    ymax = 0.004
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("13" 0, "63" 1, "64" 2, "65" 3)
    set ytics auto
    set ylabel "Ratio between the number of SNPs\nand the number of bases reconstructed (excluding N)"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:25:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
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
    offset = ( ymax - ymin ) / 16.0   
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("5" 0, "13" 1, "57" 2, "58" 3)
    set ytics auto
    set ylabel "Identity"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:5:1 title file with linespoints linestyle count
      count = count + 1
      
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
    offset = ( ymax - ymin )/16.0  
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
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:6:1 title file with linespoints linestyle count
      count = count + 1
      
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
    offset = ( ymax - ymin )/16.0  
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
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:7:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Recon_bases_cont.pdf"
    set datafile separator "\t"
    
    ymax = 300000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("5" 0, "13" 1, "57" 2, "58" 3)
    set ytics auto
    set ylabel "Number of bases reconstructed"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:16:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Min_scaffold_cont.pdf"
    set datafile separator "\t"
    
    ymax = 6000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("5" 0, "13" 1, "57" 2, "58" 3)
    set ytics auto
    set ylabel "Minimum scaffold length"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:17:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Max_scaffold_cont.pdf"
    set datafile separator "\t"
    
    ymax = 140000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("5" 0, "13" 1, "57" 2, "58" 3)
    set ytics auto
    set ylabel "Maximum scaffold length"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:18:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Avg_scaffold_cont.pdf"
    set datafile separator "\t"
    
    ymax = 60000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("5" 0, "13" 1, "57" 2, "58" 3)
    set ytics auto
    set ylabel "Average scaffold length"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:19:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Recon_bases_wout_n_cont.pdf"
    set datafile separator "\t"
    
    ymax = 300000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("5" 0, "13" 1, "57" 2, "58" 3)
    set ytics auto
    set ylabel "Number of bases reconstructed (excluding N)"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:20:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Min_scaffold_wout_n_cont.pdf"
    set datafile separator "\t"
    
    ymax = 6000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("5" 0, "13" 1, "57" 2, "58" 3)
    set ytics auto
    set ylabel "Minimum scaffold length (excluding N)"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:21:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Max_scaffold_wout_n_cont.pdf"
    set datafile separator "\t"
    
    ymax = 140000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("5" 0, "13" 1, "57" 2, "58" 3)
    set ytics auto
    set ylabel "Maximum scaffold length (excluding N)"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:22:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Avg_scaffold_wout_n_cont.pdf"
    set datafile separator "\t"
    
    ymax = 60000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("5" 0, "13" 1, "57" 2, "58" 3)
    set ytics auto
    set ylabel "Average scaffold length (excluding N)"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:23:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "ratio_snps_cont.pdf"
    set datafile separator "\t"
    
    ymax = 0.01
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("5" 0, "13" 1, "57" 2, "58" 3)
    set ytics auto
    set ylabel "Ratio between the number of SNPs\nand the number of bases reconstructed"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:24:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "ratio_snps_wout_n_cont.pdf"
    set datafile separator "\t"
    
    ymax = 0.01
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:3.2]
    set key outside right top
    set xtics ("5" 0, "13" 1, "57" 2, "58" 3)
    set ytics auto
    set ylabel "Ratio between the number of SNPs\nand the number of bases reconstructed (excluding N)"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 4.75, ymax
      plot file u 0:25:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
#
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
    ymin = 90
    offset = ( ymax - ymin ) / 16.0   
    set yrange [ymin:ymax]
    set xrange [-0.2:2.2]
    set key outside right top
    set xtics ("61" 0, "13" 1, "62" 2)
    set ytics auto
    set ylabel "Identity"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 3.3, ymax
      plot file u 0:5:1 title file with linespoints linestyle count
      count = count + 1
      
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
    offset = ( ymax - ymin )/16.0  
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
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 3.3, ymax
      plot file u 0:6:1 title file with linespoints linestyle count
      count = count + 1
      
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
    offset = ( ymax - ymin )/16.0  
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
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 3.3, ymax
      plot file u 0:7:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Recon_bases_length.pdf"
    set datafile separator "\t"
    
    ymax = 500000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:2.2]
    set key outside right top
    set xtics ("61" 0, "13" 1, "62" 2)
    set ytics auto
    set ylabel "Number of bases reconstructed"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 3.3, ymax
      plot file u 0:16:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Min_scaffold_length.pdf"
    set datafile separator "\t"
    
    ymax = 6000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:2.2]
    set key outside right top
    set xtics ("61" 0, "13" 1, "62" 2)
    set ytics auto
    set ylabel "Minimum scaffold length"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 3.3, ymax
      plot file u 0:17:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Max_scaffold_length.pdf"
    set datafile separator "\t"
    
    ymax = 420000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:2.2]
    set key outside right top
    set xtics ("61" 0, "13" 1, "62" 2)
    set ytics auto
    set ylabel "Maximum scaffold length"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 3.3, ymax
      plot file u 0:18:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Avg_scaffold_length.pdf"
    set datafile separator "\t"
    
    ymax = 100000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:2.2]
    set key outside right top
    set xtics ("61" 0, "13" 1, "62" 2)
    set ytics auto
    set ylabel "Average scaffold length"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 3.3, ymax
      plot file u 0:19:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Recon_bases_wout_n_length.pdf"
    set datafile separator "\t"
    
    ymax = 500000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:2.2]
    set key outside right top
    set xtics ("61" 0, "13" 1, "62" 2)
    set ytics auto
    set ylabel "Number of bases reconstructed (excluding N)"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 3.3, ymax
      plot file u 0:20:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Min_scaffold_wout_n_length.pdf"
    set datafile separator "\t"
    
    ymax = 6000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:2.2]
    set key outside right top
    set xtics ("61" 0, "13" 1, "62" 2)
    set ytics auto
    set ylabel "Minimum scaffold length (excluding N)"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 3.3, ymax
      plot file u 0:21:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Max_scaffold_wout_n_length.pdf"
    set datafile separator "\t"
    
    ymax = 420000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:2.2]
    set key outside right top
    set xtics ("61" 0, "13" 1, "62" 2)
    set ytics auto
    set ylabel "Maximum scaffold length (excluding N)"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 3.3, ymax
      plot file u 0:22:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Avg_scaffold_wout_n_length.pdf"
    set datafile separator "\t"
    
    ymax = 100000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:2.2]
    set key outside right top
    set xtics ("61" 0, "13" 1, "62" 2)
    set ytics auto
    set ylabel "Average scaffold length (excluding N)"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 3.3, ymax
      plot file u 0:23:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "ratio_snps_length.pdf"
    set datafile separator "\t"
    
    ymax = 0.01
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:2.2]
    set key outside right top
    set xtics ("61" 0, "13" 1, "62" 2)
    set ytics auto
    set ylabel "Ratio between the number of SNPs\nand the number of bases reconstructed"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 3.3, ymax
      plot file u 0:24:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "ratio_snps_wout_n_length.pdf"
    set datafile separator "\t"
    
    ymax = 0.01
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:2.2]
    set key outside right top
    set xtics ("61" 0, "13" 1, "62" 2)
    set ytics auto
    set ylabel "Ratio between the number of SNPs\nand the number of bases reconstructed (excluding N)"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 3.3, ymax
      plot file u 0:25:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
cp *.pdf ../Graphs
#
cd ../vir_4
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,7'
    set output "Recon_bases_real_ds.pdf"
    set datafile separator "\t"
    
    ymax = 15000000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:5.2]
    set key outside right top
    set xtics ("SRR23101281" 0, "SRR23101235" 1, "SRR23101259" 2, "SRR23101276" 3, "SRR23101228" 4, "SRR12175231" 5)
    set ytics auto
    set ylabel "Number of bases reconstructed"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 6.85, ymax
      plot file u 0:16:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,7'
    set output "Min_scaffold_real_ds.pdf"
    set datafile separator "\t"
    
    ymax = 162000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:5.2]
    set key outside right top
    set xtics ("SRR23101281" 0, "SRR23101235" 1, "SRR23101259" 2, "SRR23101276" 3, "SRR23101228" 4, "SRR12175231" 5)
    set ytics auto
    set ylabel "Minimum scaffold length"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 6.85, ymax
      plot file u 0:17:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,7'
    set output "Max_scaffold_real_ds.pdf"
    set datafile separator "\t"
    
    ymax = 250000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:5.2]
    set key outside right top
    set xtics ("SRR23101281" 0, "SRR23101235" 1, "SRR23101259" 2, "SRR23101276" 3, "SRR23101228" 4, "SRR12175231" 5)
    set ytics auto
    set ylabel "Maximum scaffold length"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 6.85, ymax
      plot file u 0:18:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,7'
    set output "Avg_scaffold_real_ds.pdf"
    set datafile separator "\t"
    
    ymax = 180000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:5.2]
    set key outside right top
    set xtics ("SRR23101281" 0, "SRR23101235" 1, "SRR23101259" 2, "SRR23101276" 3, "SRR23101228" 4, "SRR12175231" 5)
    set ytics auto
    set ylabel "Average scaffold length"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 6.85, ymax
      plot file u 0:19:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,7'
    set output "Recon_bases_wout_n_real_ds.pdf"
    set datafile separator "\t"
    
    ymax = 15000000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:5.2]
    set key outside right top
    set xtics ("SRR23101281" 0, "SRR23101235" 1, "SRR23101259" 2, "SRR23101276" 3, "SRR23101228" 4, "SRR12175231" 5)
    set ytics auto
    set ylabel "Number of bases reconstructed (excluding N)"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 6.85, ymax
      plot file u 0:20:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,7'
    set output "Min_scaffold_wout_n_real_ds.pdf"
    set datafile separator "\t"
    
    ymax = 40000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:5.2]
    set key outside right top
    set xtics ("SRR23101281" 0, "SRR23101235" 1, "SRR23101259" 2, "SRR23101276" 3, "SRR23101228" 4, "SRR12175231" 5)
    set ytics auto
    set ylabel "Minimum scaffold length (excluding N)"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 6.85, ymax
      plot file u 0:21:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,7'
    set output "Max_scaffold_wout_n_real_ds.pdf"
    set datafile separator "\t"
    
    ymax = 250000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:5.2]
    set key outside right top
    set xtics ("SRR23101281" 0, "SRR23101235" 1, "SRR23101259" 2, "SRR23101276" 3, "SRR23101228" 4, "SRR12175231" 5)
    set ytics auto
    set ylabel "Maximum scaffold length (excluding N)"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 6.85, ymax
      plot file u 0:22:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,7'
    set output "Avg_scaffold_wout_n_real_ds.pdf"
    set datafile separator "\t"
    
    ymax = 180000
    ymin = 0
    offset = ( ymax - ymin )/16.0  
    set yrange [ymin:ymax]
    set xrange [-0.2:5.2]
    set key outside right top
    set xtics ("SRR23101281" 0, "SRR23101235" 1, "SRR23101259" 2, "SRR23101276" 3, "SRR23101228" 4, "SRR12175231" 5)
    set ytics auto
    set ylabel "Average scaffold length (excluding N)"
    set xlabel "Dataset"
    set multiplot layout 1,1
    set rmargin 30
    set key at screen 1, graph 1  
    
    set style line 1 pt 1 lc rgb '#1d446a'
    set style line 2 pt 2 lc rgb '#B9121B'
    set style line 3 pt 3 lc rgb '#754d0f'
    set style line 4 pt 4 lc rgb '#eb9000'
    set style line 5 pt 5 lc rgb '#295b81'
    set style line 6 pt 1 lc rgb '#54a6c3'
    set style line 7 pt 2 lc rgb '#702A8C'
    set style line 8 pt 6 lc rgb '#BF2669'
    set style line 9 pt 7 lc rgb '#c7334d'
    set style line 10 pt 12 lc rgb '#8ff6ff'
    set style line 11 pt 13 lc rgb '#e5391a'
    set style line 12 pt 9 lc rgb '#168039'
    set style line 13 pt 8 lc rgb '#96CA2D'
    set style line 14 pt 3 lc rgb '#000000'
    set style line 15 pt 4 lc rgb '#895ea1'
    set style line 16 pt 5 lc rgb '#c0407b'

    count = 1

    do for [ file in "${list_tools[@]}"]{  
      set key at 6.85, ymax
      plot file u 0:23:1 title file with linespoints linestyle count
      count = count + 1
      
      ymax = ymax - offset
      
    }
EOF
#
#
cp *.pdf ../Graphs
#
cd ..
#
