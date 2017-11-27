# docker-ansible

[Ansible](https://github.com/ansible/ansible) в контейнере Docker. Основан на популярном образе 
[William-Yeh/docker-ansible](https://github.com/William-Yeh/docker-ansible/blob/master/debian9/Dockerfile).
От оригинального образа отличается фиксированными версиями базового дистрибутива и Ansible, настроенной локалью C.UTF-8
(для корректного отображения кириллицы), и отключенной проверкой ключей хостов SSH.

## Использование

```shell
$ docker run --rm -v $PWD:/workdir -w /workdir nartamonov/ansible:2.4.1.0 ansible -i hosts playbook.yml
```
