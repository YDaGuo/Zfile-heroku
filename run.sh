#!/bin/sh
cat <<-EOF > /root/zfile/WEB-INF/classes/application.yml
zfile:
  debug: false
  directLinkPrefix: directlink
  log:
    path: ${user.home}/.zfile/logs
  db:
    path: ${user.home}/.zfile/db/zfile
  tmp:
    path: ${user.home}/.zfile/tmp
  cache:
    auto-refresh:
      interval: 1
    timeout: 1800
  constant:
    readme: readme.md
    password: password.txt
  preview:
    audio:
      maxFileSizeMb: 5
    text:
      maxFileSizeKb: 512
  onedrive:
    clientId: 09939809-c617-43c8-a220-a93c1513c5d4
    clientSecret: _l:zI-_yrW75lV8M61K@z.I2K@B/On6Q
    redirectUri: https://zfile.jun6.net/onedrive/callback
    scope: offline_access User.Read Files.ReadWrite.All
  onedrive-china:
    clientId: 4a72d927-1907-488d-9eb2-1b465c53c1c5
    clientSecret: Y9CEA=82da5n-y_]KAWAgLH3?R9xf7Uw
    redirectUri: https://zfile.jun6.net/onedrive/china-callback
    scope: offline_access User.Read Files.ReadWrite.All

server:
  port: ${PORT}
  servlet:
    context-path: ''
  tomcat:
    max-threads: 20
  compression:
    enabled: true

spring:
  h2:
    console:
      settings:
        web-allow-others: true
      path: /h2-console
      enabled: ${zfile.debug}
  datasource:
    # 初始化数据导入
    data: classpath*:db/data.sql
    sql-script-encoding: utf-8

    initialization-mode: always
    continue-on-error: true

    # h2 内存数据库 配置
    #driver-class-name: org.h2.Driver
    #url: jdbc:h2:${zfile.db.path}
    #username: zfile
    #password: 123456

    # MySQL 配置
      driver-class-name: com.mysql.jdbc.Driver
      url: ${MYSQL_URL}
      #url: jdbc:mysql://127.0.0.1:3306/zfile?characterEncoding=utf8&serverTimezone=Asia/Shanghai&useSSL=false
      username: ${MYSQL_USER}
      password: ${MYSQL_PASSWD}
  jackson:
    date-format: yyyy-MM-dd HH:mm
    time-zone: GMT+8
  jpa:
    hibernate:
      ddl-auto: update
    properties:
      hibernate:
        format_sql: false
    show-sql: false
  resources:
    chain:
      gzipped: true
  profiles:
    active: prod
EOF
