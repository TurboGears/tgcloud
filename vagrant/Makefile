.PHONY: upload

output/tg2-ubuntu.box: input/ubuntu-15.04-server-amd64.iso
	packer build -color=false virtualbox/tg2.json
	rm -rf packer_cache

input/ubuntu-15.04-server-amd64.iso:
	wget http://mirrors.syringanetworks.net/ubuntu-releases/15.04/ubuntu-15.04-server-amd64.iso -O input/ubuntu-15.04-server-amd64.iso

upload: output/tg2-ubuntu.box
	packer build -color=false -var-file=packer-variables.json virtualbox/tg2.json
	rm -rf packer_cache

clean:
	-rm input/* output/*
