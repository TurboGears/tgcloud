.PHONY: all up run

all: up run

up:
	vagrant up
	vagrant ssh -c "sudo apt-get update"
run:
	vagrant ssh -c "sudo puppet apply --modulepath=/vagrant -e 'include turbogears'"
