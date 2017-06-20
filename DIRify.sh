#! /bin/bash
#This program is a bash version of one that makes the contents of a directory into an html file
#Start by asking the user where the directory is that they want to make a source of 
echo Where is the directory you want to be sourcified in relation to this folder??
read sulla
#Check for specific entries and do whatever when they are used
if [ -z "$sulla" ] #This is the top of the file system. It just skips the directory change. This is so you don't go to the home folder
then
    if [ -e directories.tmp ]
       then
	   echo "directories.tmp exists, and doing so would destroy it! Exiting with error code 4"
	   exit 4
    else
	if echo -e "<html> 
  <head> 
    <title>Site Index</title> 
  </head> 
  <body> 
       <h1>Index of /</h1>
       <ul>
"> src.html
        then
ls -a > directories.tmp
while read line
do
    if [ "$line" = "directories.tmp" ]
    then
	:
    else
	    echo -e "<li><a href=\""$line"\">"$line"</a></li>">> src.html
    fi
    done <directories.tmp
rm directories.tmp
echo "</ul>
    </body>
  </html>" >> src.html
echo "Made a root directory list"
exit 0
   else
       echo "Can not write to the directory. Exit code 3"
       exit 3
	fi
    fi
else
    if cd $sulla 2> /dev/null
       then
	   if
echo -e 2> /dev/null "<html> 
  <head> 
    <title>Site Index</title> 
  </head> 
  <body> 
       <h1>Index of /"$sulla"</h1>
       <ul>
"> src.html
    then
	if [ -e directories.tmp ]
	then
	    echo "directories.tmp exists in the directory. Remove it. Exiting with error code 4"
	    rm src.html
	    exit 4
	else
	    ls -a > directories.tmp
	    while read line
	    do
		if [ "$line" = "directories.tmp" ]
		then
		    :
		elif [ "line" = "." ]
		then
		    :
		else
		    echo -e "<li><a href=\""$line"\">"$line"</a></li>">> src.html
		    fi
	    done <directories.tmp
	    rm directories.tmp
	    echo "</ul>
    </body> 
  </html>" >> src.html
	    echo "Created a source file in "$sulla
	    exit 0
	fi
    else
	    echo "Can not write to directory! Exit Code 3"
	    exit 3
	   fi
    else
	echo "That folder doesn't exist, or can not be read! Exiting with Error Code 4"
	exit 4
    fi
fi
