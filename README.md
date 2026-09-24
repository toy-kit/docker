# Docker Image Registry

A proxy repository that mirrors Docker Official Images to Alibaba Cloud Container Registry.

## Available Images

| Image | Versions |
|-------|----------|
| alpine | 3.19, 3.21, 3.22, 3.23, 3.24 |
| composer | 2.2, 2.10 |
| dart | 3.13-sdk |
| debian | 12.15, 12.15-slim |
| elasticsearch | 8.19.22, 9.4.6, 9.5.3 |
| gcc | 12.5.0, 13.5.0, 14.4.0, 15.3.0, 16.2.0 |
| golang | 1.20-alpine, 1.21-alpine, 1.22-alpine, 1.23-alpine, 1.24-alpine, 1.25-alpine, 1.26-alpine, 1.27-alpine |
| influxdb | 3.5-core |
| mariadb | 12.3 |
| memcached | 1.6.45-alpine |
| mongo | 8.3-noble |
| mysql | 5.6.51, 5.7.44, 8.4, 9.7 |
| nginx | 1.22-alpine, 1.25-alpine, 1.28-alpine, 1.30-alpine, 1.31-alpine |
| node | 14.21-alpine, 16.20-alpine, 18.20-alpine, 20.20-alpine, 22.23-alpine, 24.21-alpine, 26.10-alpine |
| php | 5.6-fpm-alpine, 7.4-fpm-alpine, 8.2-fpm-alpine, 8.3-fpm-alpine, 8.4-fpm-alpine, 8.5-fpm-alpine |
| postgres | 14-alpine, 18-alpine |
| python | 3.10-alpine, 3.11-alpine, 3.12-alpine, 3.13-alpine, 3.14-alpine |
| rabbitmq | 4.3-alpine |
| redis | 8.10-alpine |
| ubuntu | 22.04, 24.04, 26.04 |

## Usage

### pull.sh

```bash
curl -fsSL https://github.com/toy-kit/docker/raw/master/pull.sh | bash -s -- <image>

curl -fsSL https://gitee.com/toy-kit/docker/raw/master/pull.sh | bash -s -- <image>
```

```bash
bash pull.sh <image>
```

> `pull.sh` pulls an image from the Alibaba Cloud registry, retags it to the official name, and removes the registry-tagged copy.

#### Examples

```bash
# Pull golang:1.23-alpine
bash pull.sh library/golang:1.23-alpine

# The library/ prefix is optional
bash pull.sh golang:1.23-alpine

# Pull redis:8-alpine
bash pull.sh redis:8-alpine
```

## Image Mapping

Local images are mapped to the registry as follows:

```
library/<image>:<tag> -> registry.cn-hangzhou.aliyuncs.com/toy-kit/docker:<image>.<tag>
```

- Remove the `library/` prefix
- Replace `/` with `-` (becomes part of the tag name)
- Replace `:` with `.` (tag separator)

#### What it does

Given input `library/golang:1.23-alpine`:

1. Strip `library/` prefix -> `golang:1.23-alpine`
2. Replace `:` with `.` -> `golang.1.23-alpine`
3. `docker pull registry.cn-hangzhou.aliyuncs.com/toy-kit/docker:golang.1.23-alpine`
4. `docker tag registry.cn-hangzhou.aliyuncs.com/toy-kit/docker:golang.1.23-alpine golang:1.23-alpine`
5. `docker rmi registry.cn-hangzhou.aliyuncs.com/toy-kit/docker:golang.1.23-alpine`
