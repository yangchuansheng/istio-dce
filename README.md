<h1 align="center">Istio 与 DCE 集成方案 👋</h1>
<center><p>
  <img src="https://img.shields.io/badge/version-1.2.2-blue.svg?cacheSeconds=2592000" />
  <img alt="Maintenance" src="https://img.shields.io/badge/Maintained%3F-yes-green.svg" target="_blank" />
</p></center>

[Istio](https://istio.io/zh) 是由 Google、IBM、Lyft 等共同开源的 Service Mesh（服务网格）框架，于2017年初开始进入大众视野，作为云原生时代下承 Kubernetes、上接 Serverless 架构的重要基础设施层，地位至关重要。

想快速了解 Istio 的流量治理功能，请参考：[Istio 流量管理](https://www.yangcs.net/posts/istio-traffic-management/)

本项目将会指导你如何在 DCE 中部署 Istio。

## 🚀 准备工作
首先需要在 DCE 控制台中创建访问秘钥

<div align=center><img width="700" src="img/create-key-1.png"/></div>

<div align=center><img width="700" src="img/create-key-2.png"/></div>

## 开始部署

克隆该项目

```bash
$ git clone https://github.com/yangchuansheng/istio-dce
```

直接运行脚本 deploy-istio.sh

```bash
$ cd istio-dce
$ bash deploy-istio.sh
```

中间会出现一些交互选项，按照提示输入就行。

## 演示 DEMO

<div style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden;">
  <iframe src="//player.bilibili.com/player.html?aid=57954809&cid=101128194&page=1" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; border:0;" allowfullscreen="true"></iframe>
</div>

## 作者

👤 **米开朗基杨**

* Github: [@yangchuansheng](https://github.com/yangchuansheng)
* Blog: https://www.yangcs.net
* 微信公众号: 云原生实验室

## 支持我

如果觉得这个项目对你有帮助，请给我一个 ⭐️ 吧！
