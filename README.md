slack-playground
================

Playground with Slack

## Requirements

* Ruby 2.5.1
* Slack OAuth Access Token

## Setup

```
git clone git@github.com:inouetakuya/slack-playground.git
cd slack-playground
```

```
bundle install --path vendor/bundle
```

```
cp .env.example .env
```

Fill `SLACK_API_TOKEN` in `.env`

## Debugging

```
bundle exec pry
```

## Authentication test

```
bundle exec thor task:auth:test
```

## Testing

```
bundle exec rspec
```
