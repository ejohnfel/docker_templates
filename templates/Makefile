#
# Example Docker Container Build Makefile
#

# Location of work folders (or anything else you need)
PREFIX = /srv/storage/projects/containers
# Docker Service Name, assuming you define a service
SVC = Serivce_Name
# Image for container
IMAGE = Image_Name
# Name of container
CNTR = Container_Name
# Shell in container you may wish to execute
CNTSHELL = bash

# Deploy action
deploy: Dockerfile docker-compose.yml
	@docker-compose up -d

# Almost same as deploy, but start up an interactive console for debugging
debug: Dockerfile docker-compose.yml
	@docker-compose up

# Open an interactive shell in a container
shell:
	@docker exec -it $(CNTR) $(CNTSHELL)

# Execute defined APP inside container, APP is a variable defined on the
# Makefiles command line. Like the "shell" action, but you define what to
# run dynamically
app:
	@docker exec -it $(CNTR) $(APP)

# Clean up a container and it's image. Useful for when a built container fails
clean:
	@docker stop $(CNTR)
	@docker rm $(CNTR)
	@docker image rm $(IMAGE)

# If container does not complete deployment, this will help clean up
# all the intermediate and unnamed build steps
inter:
	@../scripts/clean_intermediates

# Extract file from container
extract:
	@docker run --rm $(CNTR) cat /usr/local/apache2/conf/httpd.conf > my-httpd.conf

# List of actions in Makefile, as self documentation
actions:
	@echo "deploy\t\t\t\t\tStart Container detached"
	@echo "debug\t\t\t\t\tStart container interactively"
	@echo "shell\t\t\t\t\tStart interactive bash in container, use CNTSHELL env for a different shell"
	@echo "app APP='app'\t\t\t\tRun the given 'app' interactively in the container"
	@echo "clean\t\t\t\t\tAs best can be done, clean up related containers and images"
	@echo "inter\t\t\t\t\tCall clean intermediates script"
	@echo "extract [path_to_file] [output_name]\tExtract file from image to given name"
