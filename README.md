# drone plugin rancher redeploy
    需要 镜像拉取策略:总是拉取

## useage
```


docker run --rm --name=test \
    -e PLUGIN_TOKEN=your rancher token key:secret \
    -e PLUGIN_API=https://rancher.testdoc.cn/v3/project/c-kdsh5:p-6kjl5/workloads/deployment:default:www \
    mj520/drone-rancher

steps:
  - name: rancher-redeploy
    image: mj520/drone-rancher
    settings:
        api: 
            from_secret: rancher_api
        token: 
            from_secret: rancher_token

注:api 支持 https://rancher.testdoc.cn/p/c-kdsh5:p-6kjl5/workload/deployment:default:www
       转为 https://rancher.testdoc.cn/v3/project/c-kdsh5:p-6kjl5/workloads/deployment:default:www
```