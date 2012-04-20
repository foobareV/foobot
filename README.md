foobot
======

Statusbot des foobar e.V.

Der Bot pingt alle x Minuten die eingestellte IP-Adresse an und generiert je nach Erfolg den entsprechenden HTML-Output.

Installation:

* config.cfg ausfüllen
* Cronjob anlegen der alle x (5 ist gut) Minuten foobot.sh startet
* Den Webserver auf htdocs zeigen lassen
* eventuell Rechte anpassen

Bedienmöglichkeiten:

* Mit dem Browser ansurfen
* status.png auf anderen Webseiten einbinden
* in eigenen Skripten die api abfragen, liefert open, closed oder error
