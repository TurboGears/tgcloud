# TODO: add directions for tginst and host setting in development.ini to 0.0.0.0 from 127.0.0.1
# TODO: add directions for how to change the default database

output/turbogears2-postgres.box: input/ubuntu-14.10-server-amd64.iso
	rm -rf packer_cache
	packer build -color=false virtualbox/tg2.json
	rm -rf packer_cache

input/ubuntu-14.10-server-amd64.iso:
	wget http://mirrors.syringanetworks.net/ubuntu-releases/14.10/ubuntu-14.10-server-amd64.iso -O input/ubuntu-14.10-server-amd64.iso

clean:
	-rm input/* output/*
