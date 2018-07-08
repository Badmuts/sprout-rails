# README

## Getting started

Make sure Docker and Docker Compose are installed then run:

```sh
# First time start should build images first
$ make
# Start the application
$ make dev
# Or:
$ docker-compose up
# First time should probaly migrate and seed the database
$ docker-compose exec app bundle exec rails db:create && docker-compose exec app bundle exec rails db:migrate && docker-compose exec app bundle exec rails db:seed
```

## Rails commands

Make sure the app is running

```sh
$ docker-compose exec app bundle exec rails command
```

For example `db:create`

```sh
$ docker-compose exec app bundle exec rails db:create
```

---

## Todos

* [x] Accountbeheer
* [x] Authenticatie
* [x] Abonnementenbeheer
    - [x] List plans
    - [x] Subscribe to plan via ideal payment via mollie
    - [x] Create webhook for mollie to fetch payment/subscription status
* [x] Advertenties (vraag en aanbod)
* [ ] Notificaties voor vraag en aanbod (email of elders)
* [ ] Advertentie beheer
    - [x] Create
    - [ ] Edit
    - [ ] Remove
* [x] Profiel pagina (bedrijfgegevens)
    - [x] Update through settings
    - [x] View page via `/c/{companyId}`