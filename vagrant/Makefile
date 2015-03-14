.PHONY: upload

output/turbogears2-postgres.box: input/ubuntu-14.10-server-amd64.iso
	packer build -color=false virtualbox/tg2.json
	rm -rf packer_cache

input/ubuntu-14.10-server-amd64.iso:
	wget http://mirrors.syringanetworks.net/ubuntu-releases/14.10/ubuntu-14.10-server-amd64.iso -O input/ubuntu-14.10-server-amd64.iso

upload:
	packer build -color=false -var-file=packer-variables.json virtualbox/tg2.json
	rm -rf packer_cache

clean:
	-rm input/* output/*
