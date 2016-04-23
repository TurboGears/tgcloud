.PHONY: upload

URL=http://releases.ubuntu.com/16.04/ubuntu-16.04-server-amd64.iso
ISO=input/ubuntu-16.04-server-amd64.iso

output/tg2-ubuntu.box: $(ISO)
	packer build --color=false --only=virtualbox-iso virtualbox/tg2.json
	rm -rf packer_cache

$(ISO):
	wget $(URL) -O $(ISO)

upload: output/tg2-ubuntu.box
	packer build -color=false -var-file=packer-variables.json virtualbox/tg2.json
	rm -rf packer_cache

clean:
	-rm input/* output/*
