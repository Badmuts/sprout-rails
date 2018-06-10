CURRENT=$$(git rev-parse --abbrev-ref HEAD)-$$(git rev-parse HEAD | cut -c1-7)

build:
	@docker-compose -f docker-compose.yml build
	@docker-compose build

release:
	@docker-compose -f docker-compose.yml build
	@docker tag badmuts/sprout:latest badmuts/sprout:$(CURRENT)
	@docker push badmuts/sprout:$(CURRENT)

dev:
	@docker-compose up