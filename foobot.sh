#!/bin/bash
# foobot - Der Statusbot der foobar

cd $BOTDIR

source config.cfg
LASTSTATUS=`cat laststatus`

ping -c 3 $SPACE_IP >> /dev/null;
FOOBAR_STATUS=$?
DATETIME=`date +"%d.%m.%Y %H:%M"`

case $FOOBAR_STATUS in
0)
	if [ $LASTSTATUS -ne 0 ] ; then
		rm htdocs/status.png 2> /dev/null;
		ln -s open.png htdocs/status.png;
		echo "open" > htdocs/api;
		sed -e "s/{space}/${SPACE}/g" -e "s/{status_img}/open/g" -e "s/{status}/offen/g" -e "s/{datetime}/${DATETIME}/g" -e "s/{phone}/<p>Wie lange ist noch jemand da\?<br \/>Ruf an: ${PHONE}<\/p>/g" template.html > htdocs/index.html;
		echo "0" > laststatus;
	fi
	;;
1)
	if [ $LASTSTATUS -ne 1 ] ; then
		rm htdocs/status.png 2> /dev/null;
		ln -s closed.png htdocs/status.png;
		echo "closed" > htdocs/api;
		sed -e "s/{space}/${SPACE}/g" -e "s/{status_img}/closed/g" -e "s/{status}/geschlossen/g" -e "s/{datetime}/${DATETIME}/g" -e "s/{phone}//g" template.html > htdocs/index.html;
		echo "1" > laststatus;
	fi
	;;
*)
	rm htdocs/status.png 2> /dev/null;
	ln -s error.png htdocs/status.png;
	echo "error" > htdocs/api;
	sed -e "s/{space}/${SPACE}/g" -e "s/{status_img}/error/g" -e "s/{status}/Fehler/g" -e "s/{datetime}/${DATETIME}/g" -e "s/{phone}//g" template.html > htdocs/index.html;
	echo "5" > laststatus;
	;;
esac

exit 0
