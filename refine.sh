#
# Set up the Wikimedia Sprint application/extension
#
cd /srv/phabricator
sudo -u PHABRICATOR git clone https://github.com/wikimedia/phabricator-extensions-Sprint.git libext/sprint
# sudo chown -R PHABRICATOR libext
cd /srv/phabricator/phabricator
# Enable Applicatoin
sudo -u PHABRICATOR ./bin/config set load-libraries '{"sprint":"/srv/phabricator/libext/sprint/src"}'
# Enable Prototyping
sudo -u PHABRICATOR ./bin/config set phabricator.show-prototypes true
#
cd /
