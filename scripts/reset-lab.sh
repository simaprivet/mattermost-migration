#!/usr/bin/env bash
# Полный сброс стенда, чтобы прогнать практику заново "с нуля" (репетиция перед сдачей).
# УДАЛЯЕТ все контейнеры, тома (сообщения, файлы, обе БД) и флаг-файл миграции.
# Бэкапы в ~/mattermost_backups НЕ удаляются.
#
# Запускайте от пользователя, под которым работает self-hosted runner
# (флаг-файл лежит в его домашней папке).
set -euo pipefail

read -r -p "Удалить ВСЕ данные Mattermost (контейнеры, тома, флаг миграции)? Введите yes: " answer
[ "$answer" = "yes" ] || { echo "Отменено."; exit 0; }

docker rm -f mattermost mattermost-mysql mattermost-postgres 2>/dev/null || true
docker volume rm mattermost_data mattermost_logs mattermost_mysql_data mattermost_postgres_data 2>/dev/null || true
docker network rm mattermost_network 2>/dev/null || true
rm -f "$HOME/.mattermost_migration_completed" "$HOME/.mattermost_mysql_posts_count"

echo "Готово. Теперь: cd legacy && docker compose up -d"
