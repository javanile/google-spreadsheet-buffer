
build:
	@chmod +x docker-entrypoint.sh
	@docker compose build

start: build
	@docker compose up -d --build --force-recreate
	@ngrok http --log=false 6612

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
