#! /bin/bash

 # Usage info
show_help(){

    cat <<EOF
 Usage: ${0##*/} [-h] 
 Reduce the size of image files like png and jpg

     -h          display this help and exit

EOF
 }

 check_program_arguments(){
     is_this_null=$1
     if [ -z $is_this_null ]
     then
	 #everything is ok
	 check_presence_of_files
     else
	 parse_program_arguments $is_this_null
     fi
 }

 parse_program_arguments(){
 while getopts h: opt; do
     case $opt in
         h)
             show_help
             exit 0
             ;;
          *) echo "you messed up"
             show_help >&2
             exit 1
             ;;
     esac
 done
# shift "$((OPTIND-1))"   # Discard the options and sentinel --
}

check_presence_of_files(){
    error=
    
    if [ ! -z $(ls *.jpg) ] || [ ! -z $(ls *.png) ]
    then
	error=no
	
    else
	error=yes
    fi
    
    if [ $error == "no" ]
    then
	echo $error
	ok
    else
	echo "$error and hi"
	exit 0;
    fi

} 2>/dev/null

ok(){

    echo "everything seems to be allright"
    echo
    echo "now we proceed"
    determine_spaces_in_filenames    
}

determine_spaces_in_filenames(){
original_number_of_files=$(ls *.png *.jpg | wc -l)
apparent_number_of_files=$(ls *.png *.jpg | wc -w)
if [ $apparent_number_of_files -ge $original_number_of_files ]
then
    fix_spaces_in_filenames
else
    :
   # no_spaces_in_filenames
    fi
}

fix_spaces_in_filenames(){
    echo "Fixing spaces in filenames"
    for file in *
    do
	target="$(echo $file | sed -e 's/ /_/g')"
	mv "$file" "$target"
    done

reduce_file_size
}

reduce_file_size(){
echo "reducing file size"
# ls *.png | xargs -n 1 -I{} | parallel -j+0 /usr/bin/convert {} -strip -quality 50% {}.jpg
}

check_program_arguments $*

