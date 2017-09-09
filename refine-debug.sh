#
# Set up the Wikimedia Sprint application/extension
cd /srv/phabricator
echo " ---> USERS <---- "
cat /etc/passwd
echo " ---> Executing Clone: Install Sprint <------"
# sudo -u PHABRICATOR
sudo -u PHABRICATOR git clone https://github.com/wikimedia/phabricator-extensions-Sprint.git libext/sprint
sudo chown -R PHABRICATOR libext
cd /srv/phabricator/phabricator
# Enable Applicatoin
echo " ---> Directory conf and conf/local before Execution ./bin/config <------"
ls -la /srv/phabricator/phabricator/conf
ls -la /srv/phabricator/phabricator/conf/local
echo " ---> Executing ./bin/config <------"
# sudo -u git:wwwgrp-phabricator
sudo -u PHABRICATOR ./bin/config set load-libraries '{"sprint":"/srv/phabricator/libext/sprint/src"}'
# Enable Prototyping
sudo -u PHABRICATOR ./bin/config set phabricator.show-prototypes true
echo " ---> Directory conf after Execution ./bin/config <------"
 ls -la /srv/phabricator/phabricator/conf
echo "-"
 ls -la /srv/phabricator/phabricator/conf/local
echo "-"
 cat /srv/phabricator/phabricator/conf/local/local.json
echo "======================="
# sudo chmod -R 777 /srv/phabricator/phabricator/conf/local
#
cd /
