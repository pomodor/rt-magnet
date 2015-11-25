# rt-magnet
Локальный поиск по раздачам rutracker.org с выдачей magnet-ссылок

#### Импорт
1. В директории import запустите bundle
2. Отредактируйте файл init.sql (если хотите) и выполните команду:
```
mysql -u root -p < init.sql
```
3. Запустите импорт:
```
./import.rb rutracker-base-dir
```

#### Поиск
В директории search запустите файл ./magnet.rb key_1 key_2 ... key_n. Доступен и поиск через Apache Solr. Используйте файл solrs.rb.