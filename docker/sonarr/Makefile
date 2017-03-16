IMAGE = swerpbox/sonarr
TAG = latest

clean:
	docker rmi $(IMAGE):$(TAG) $(CLEAN_OPTIONS) || true

build:
	docker build -t $(IMAGE):$(TAG)  .

pull:
	docker pull $(IMAGE):$(TAG) $(PULL_OPTIONS)

push:
	docker push $(IMAGE):$(TAG)
