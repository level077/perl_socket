#!/bin/sh

args=`echo "$1" | awk  -F '&' '{for(i=1;i<=NF;i++) s[$i]} END {ORS=" ";for(a in s) print a}'`

for x  in $args
do
        case `echo $x | awk -F '=' '{print $1}'` in
                number) number=`echo $x | awk -F '=' '{print $2}'`
                ;;
                *)
                ;;
        esac
done

if [ -z "$number" ]
then
	num=200
else
	num="$number"
fi
tail -"$num"  /usr/local/app/apache-tomcat-6.0.32/logs/catalina.out
echo "DONE"
