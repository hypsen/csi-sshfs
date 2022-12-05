# TODO make DRY

default:
	echo Choose an option

deps-clean:
	rm -f go.sum
	cp -a original_go.mod go.mod

deps: deps-clean
	./update-kubernetes-versions.sh 1.20.2
	go get ./...
	go mod tidy


build:
	docker build . --pull --no-cache -t hypsen/csi-sshfs:latest

build-with-cache:
	docker build . --pull -t hypsen/csi-sshfs:latest

push: build-with-cache
	docker push hypsen/csi-sshfs:latest

build-debug:
	docker build . --pull --no-cache -t hypsen/csi-sshfs:debug -f Dockerfile.debug

build-debug-with-cache:
	docker build . --pull -t hypsen/csi-sshfs:debug -f Dockerfile.debug

push-debug: build-debug-with-cache
	docker push hypsen/csi-sshfs:debug

push-all: push push-debug