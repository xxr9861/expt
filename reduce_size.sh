
# ~/removespaces

# ls | parallel /usr/bin/convert {} -strip -quality 50% {}.jpg && rm {}

# #finally this worked




# # # #ls *.png.jpg | xargs -n 1 -I{} mv {} $(echo {} | sed s/png.jpg/png/)

# for file in *.png.jpg ; do mv $file $(echo $file | sed s/png.jpg/png/); done







# # ls *.png | xargs -n 1 -I{} | parallel -j+0 /usr/bin/convert {} -strip -quality 50% {}.jpig
# ls *.png | time parallel xargs -n 1 -I{} /usr/bin/convert {} -strip -quality 50% {}.jpg

# #ls *.png.jpg | xargs -I{} -n 1 parallel -j+0 mv {} $(echo {} | sed s/png.jpg/png/)

# #ls *.png.jpg | xargs -n 1 -I{} mv {} $(echo {} | sed s/png.jpg/png/)


# parallel /usr/bin/convert -reducesize 


# ls *.png | time parallel xargs -n 1 -I{} /usr/bin/convert {} -strip -quality 50% {}.jpg
# comments start here
# start script like
# ./script no_args
# if args then show usage info
#    check to see if there are any image files, if not error
#    if everything is all right warn and tell to press enter to proceed and q to quit.
      
#       check to see if the filenames need to be sanitized
#       warn and do it

#       proceed.

      
 # Usage info
show_help(){

    cat <<EOF
 Usage: ${0##*/} [-h] 
 Reduce the size of image files like png and jpg

     -h          display this help and exit

EOF
 }

 program0(){
     is_this_null=$1
     if [ -z $is_this_null ]
     then
	 #everything is ok
	 sanitize
     else
	 program1 $is_this_null
     fi
 }

 program1(){
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

sanitize(){
    error=
    
    if [ -z $(ls *.jpg 1>/dev/null) ]
    then
	error=yes
	
    else
	error=no
    fi

    if [ -z $(ls *.png 1>/dev/null) ]
    then
	error=yes
    else
	error=no
    fi

    
    if [ $error = "no" ]
    then
	echo $error
	ok
    else
	exit 0;
    fi

}

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
    echo "this sed script will fix all your spaces in filenames"
    for file in *\ *; do target="$(echo $file | sed -e 's/ /_/g')"; mv "$file" "$target"; done;

main_command
}

main_command(){
echo "reducing file size"
}


program0 $*
