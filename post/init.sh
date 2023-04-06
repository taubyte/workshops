#!/bin/sh

cd post && \
sudo cp tau dream spore-drive /bin/ && \
echo 'eval "`tau autocomplete`"' >> ~/.bashrc && \
mkdir -p ~/.taubyte/networks/ && \
cp -fr testnet ~/.taubyte/networks/testnet