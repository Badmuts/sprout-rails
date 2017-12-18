# README

## Getting started

Make sure Docker and Docker Compose are installed then run:

```sh
$ source setenv
$ docker-compose up
```

## Rails commands

Make sure the app is running

```sh
$ docker-compose exec app bin/rails command
```

For example `db:create`

```sh
$ docker-compose exec app bin/rails db:create
```

---

## Todos

* [ ] Accountbeheer
* [ ] Authenticatie
* [ ] Abonnementenbeheer
* [ ] Advertenties (vraag en aanbod)
* [ ] Notificaties voor vraag en aanbod (email of elders)
* [ ] Advertentie beheer
* [ ] Profiel pagina (bedrijfgegevens)

---

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
