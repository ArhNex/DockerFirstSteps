# Docker first steps

# Contents

- [Docker first steps](#docker-first-steps)
- [Contents](#contents)
- [Part 1. Готовый докер](#part-1-готовый-докер)
- [Part 2. Операции с контейнером](#part-2-операции-с-контейнером)
- [Part 3. Мини веб-сервер](#part-3-мини-веб-сервер)
- [Part 4. Свой докер](#part-4-свой-докер)
- [Part 5. Dockle](#part-5-dockle)
- [Part 6. Базовый Docker Compose](#part-6-базовый-docker-compose)

# Part 1. Готовый докер

**Возьми официальный докер-образ с nginx и выкачай его при помощи docker pull.**

![docker pull](Part1/docker_pull.png)

**Проверь наличие докер-образа через docker images.**

![docker images](Part1/docker_images.png)

**Запусти докер-образ через docker run -d [image_id|repository].**

![docker run](Part1/docker_run_-d_nginx.png)

**Проверь, что образ запустился через docker ps.**

![docker ps](Part1/docker_ps.png)

**Посмотри информацию о контейнере через docker inspect [container_id|container_name].**

![docker size](Part1/docker_size.png)

![docker ports](Part1/docker_ports.png)

![docker ip](Part1/docker_address.png)

**Останови докер образ через docker stop [container_id|container_name].**

**Проверь, что образ остановился через docker ps.**

![docker stop](Part1/docker_stop_&_ps.png)

**Запусти докер с портами 80 и 443 в контейнере, замапленными на такие же порты на локальной машине, через команду run.**

![docker ports run](Part1/docker_80_443.png)

**Проверь, что в браузере по адресу localhost:80 доступна стартовая страница nginx.**

![localhost](Part1/localhost.png)

**Перезапусти докер контейнер через docker restart [container_id|container_name].**

**Проверь любым способом, что контейнер запустился.**

![docker restart](Part1/docker_restart.png)

# Part 2. Операции с контейнером

Докер-образ и контейнер готовы. Теперь можно покопаться в конфигурации nginx и отобразить статус страницы.

Прочитай конфигурационный файл nginx.conf внутри докер контейнера через команду exec.

![docker cat](./Part2/cat_nginx_conf_exec.png)

Скопируй созданный файл nginx.conf внутрь докер-образа через команду docker cp.

nginx.conf

![nginx.conf](./Part2/nginx_conf.png)

![docker cp](./Part2/docker_cp.png)

Перезапусти nginx внутри докер-образа через команду exec.

![nginx -s reload](./Part2/nginx_s_reload.png)

Проверь, что по адресу localhost:80/status отдается страничка со статусом сервера nginx.

![localhost/status](./Part2/localhost_new_nginx.png)

Экспортируй контейнер в файл container.tar через команду export.

![docker export nginx1 > nginx1.tar](./Part2/export_nginx1_tar.png)

Останови контейнер.

![docker stop nginx1](./Part2/docker_stop_nginx1.png)

Удали образ через docker rmi [image_id|repository], не удаляя перед этим контейнеры. Удали остановленный контейнер.

![docker rmi nginx:latest](./Part2/del_dock_image_without_rem_container.png)

Импортируй контейнер обратно через команду import. 

![docker import](./Part2/docker_import.png)

Запусти импортированный контейнер.

![docker run](./Part2/docker_run_nginx_tar.png)

Проверь, что по адресу localhost:80/status отдается страничка со статусом сервера nginx.

![localhost import](./Part2/localhost_import.png)

# Part 3. Мини веб-сервер

Мини-сервер на C & FastCgi:

![server.c](./Part3/1_2.png)

nginx.conf:

![nginx.conf](./Part3/1_1.png)

Смотрим что получилось:

![81p](./Part3/1_3.png)

# Part 4. Свой докер

Докер-образ:

![dockerfile](./Part4/images/1_1.png)

![entry](./Part4/images/1_2.png)

Сбор образа и запуск:

![build](./Part4/images/2_1.png)

Смотрим images:

![images](./Part4/images/2_2.png)

Теперь посмотрим можем ли мы подключиться к серверу:

![ser](./Part4/images/2_3.png)

Изменим nginx.conf страничку /status

![nginx.conf](./Part4/images/3_1.png)

![status](./Part4/images/3_2.png)

# Part 5. Dockle

Просконировал образ и вот что получилось:

![old image dockle](./Part5/1_1.png)

Вот какие изменения я ввёл в dockerfile а так-же необходимо ввести `export DOCKER_CONTENT_TRUST=1` в конслоль

![dockerfile new](./Part5/1_2.png)

Немного объяснений:

`HEALTHCHECK --interval=3m --timeout=3s CMD [ "curl", "-f", "http://localhost/", "||", "exit", "1" ] - используется в Dockerfile для определения проверки состояния контейнера. Эта команда выполняет проверку состояния контейнера, отправляя HTTP-запрос на localhost с помощью утилиты curl. Если запрос возвращает код состояния 200, то контейнер считается здоровым. В противном случае, если запрос не возвращает код состояния 200, команда exit 1 вызывает выход с ненулевым кодом, что указывает на нездоровое состояние контейнера.

Теперь проверим что выведит команда `dockle -ak NGINX_GPGKEY_PATH -ak NGINX_GPGKEY ngserver:jothosge'

-ak в dockle используются для добавления ключа подверждения такие как GPG

![dockle new](./Part5/1_3.png)

# Part 6. Базовый Docker Compose

yaml file: 

![yaml](./Part6/images/1_1.png)

Проверяем есть ли запущенные контейнеры и билдим compose:

![compose](./Part6/images/1_2.png)

Поднимаем compose:

![compose up](./Part6/images/1_3.png)

Смотрим работает ли переадресация:

![html](./Part6/images/1_4.png)

Посмотрим что выдаст нам командная строка в которой запущены контейнеры:

![cli](./Part6/images/1_5.png)

[UP](#docker-first-steps)