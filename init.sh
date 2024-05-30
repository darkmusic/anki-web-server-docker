git clone https://github.com/ankicommunity/anki-sync-server.git
git clone https://github.com/darkmusic/anki-web-server.git

cp Dockerfile.sync anki-sync-server/src/Dockerfile
cp Dockerfile.web anki-web-server/Dockerfile

# remove pyaudio from anki-sync-server as we do not need it
sed -i'.bak' '/pyaudio/d' anki-sync-server/src/requirements.txt

# Ensure that  correct Version onf Werkzeug is used
# see https://stackoverflow.com/questions/77213053/why-did-flask-start-failing-with-importerror-cannot-import-name-url-quote-fr
echo -e "\nWerkzeug==2.2.2" >> anki-web-server/requirements.txt

# anki sync server will keep lock the database for a long time even after close anki desktop
# to avoid that, we need to change the value of monitor_frequency and monitor_inactivity in to a small value

sed -i'.bak' 's/monitor_frequency = 15/monitor_frequency = 1/g' anki-sync-server/src/ankisyncd/thread.py

sed -i'.bak' 's/monitor_inactivity = 90/monitor_inactivity = 3/g' anki-sync-server/src/ankisyncd/thread.py
