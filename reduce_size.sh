
~/removespaces

ls | parallel /usr/bin/convert {} -strip -quality 50% {}.jpg && rm {}

#finally this worked




# # #ls *.png.jpg | xargs -n 1 -I{} mv {} $(echo {} | sed s/png.jpg/png/)

for file in *.png.jpg ; do mv $file $(echo $file | sed s/png.jpg/png/); done







# # ls *.png | xargs -n 1 -I{} | parallel -j+0 /usr/bin/convert {} -strip -quality 50% {}.jpig
# ls *.png | time parallel xargs -n 1 -I{} /usr/bin/convert {} -strip -quality 50% {}.jpg

# #ls *.png.jpg | xargs -I{} -n 1 parallel -j+0 mv {} $(echo {} | sed s/png.jpg/png/)

# #ls *.png.jpg | xargs -n 1 -I{} mv {} $(echo {} | sed s/png.jpg/png/)


# parallel /usr/bin/convert -reducesize 


# ls *.png | time parallel xargs -n 1 -I{} /usr/bin/convert {} -strip -quality 50% {}.jpg
