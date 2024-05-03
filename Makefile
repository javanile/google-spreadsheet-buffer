
build:
	@chmod +x docker-entrypoint.sh
	@docker compose build -q

start: build
	@docker compose up -d --force-recreate --remove-orphans
	@ngrok http 6612

down:
	@docker compose down -v

push:
	@docker build -t javanile/buffer:latest .
	@docker push javanile/buffer:latest

test-insert:
	@bash tests/insert-test.sh

test-errors:
	@bash tests/errors-test.sh

test-info:
	@bash tests/info-test.sh

test-create-buffer:
	@bash tests/create-buffer-test.sh

test-multiple-query:
	@bash tests/multiple-query-test.sh
