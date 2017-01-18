IMAGE = swerpbox/frontend
TAG = 1.1.0

clean:
	docker rmi $(IMAGE):$(TAG) $(CLEAN_OPTIONS) || true

build:
	docker build -t $(IMAGE):$(TAG) $(BUILD_OPTIONS) .

pull:
	docker pull $(IMAGE):$(TAG) $(PULL_OPTIONS)

push:
	docker push $(IMAGE):$(TAG)
