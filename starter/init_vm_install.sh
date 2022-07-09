set -xe
apt-get update
apt-get install -y python3{,-pip,-venv} bash

sudo chsh vagrant -s /bin/bash

python3 -m pip install -r /vagrant/requirement.txt
