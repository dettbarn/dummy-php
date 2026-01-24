.PHONY: build up install update sniff beautify report

build:
	docker compose build dummy_php

up:
	docker compose up -d

install:
	make up
	docker compose exec dummy_php composer install

update:
	make up
	docker compose exec dummy_php composer update

sniff:
	make up
	docker compose exec dummy_php ./vendor/bin/phpcs -w -p -s --standard=vendor/flyeralarm/php-code-validator/ruleset.xml ./src ./tests

beautify:
	make up
	docker compose exec dummy_php ./vendor/bin/phpcbf -w -p -s --standard=vendor/flyeralarm/php-code-validator/ruleset.xml ./src ./tests

report:
	make up
	docker compose exec dummy_php ./vendor/bin/phpmetrics ./src --report-html=./report
