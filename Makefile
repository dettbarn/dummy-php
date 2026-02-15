.PHONY: build up install update sniff beautify analyse report dependencygraph metrics rector all

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

analyse:
	make up
	docker compose exec dummy_php ./vendor/bin/phpstan analyse -c tools/phpstan.neon
	docker compose exec dummy_php ./vendor/bin/psalm --no-cache -c tools/psalm.xml
	docker compose exec dummy_php ./vendor/bin/phpmnd --progress ./src ./tests
	docker compose exec dummy_php ./vendor/bin/deptrac analyse --config-file=tools/deptrac.yaml

report:
	make up
	docker compose exec dummy_php ./vendor/bin/phpmetrics ./src --report-html=./report

dependencygraph:
	make up
	rm -f vendor/dettbarn/dependencygraph/output/*.png
	docker compose exec dummy_php ./vendor/bin/dependencygraph report/classes.js 'Test\DummyPhp\Root' report/package_relations.html 'Test'

metrics:
	make up
	make report
	make dependencygraph

rector:
	make up
	docker compose exec dummy_php ./vendor/bin/rector process --dry-run -c tools/rector.php

all:
	make up
	make sniff
	make analyse
	make metrics
	make rector
