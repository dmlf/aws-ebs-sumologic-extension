ifndef NODE_ENV
	NODE_ENV=dev
endif

ifndef SUMO_HTTP_COLLECTOR_URL
  ifeq ($(NODE_ENV),uat)
	SUMO_HTTP_COLLECTOR_URL=https://endpoint1.collection.eu.sumologic.com/receiver/[...]
  endif
endif

aws-generate Dockerrun.aws.json:
	sed -i -e 's/{environment}/$(NODE_ENV)/g' -e 's@{sumoUrl}@$(SUMO_HTTP_COLLECTOR_URL)@g' config/logstash/logstash.docker.conf.tpl
	zip -r app_config.zip Dockerrun.aws.json config .ebextensions

clean:
	rm Dockerrun.aws.json

.PHONY: aws-generate
