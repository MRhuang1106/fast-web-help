# GitHub Pages 发布步骤

## 手动发布

1. 登录 GitHub。
2. 新建仓库：`fast-web-help` 或你的服务名。
3. 上传 `index.html` 和 `README.md`。
4. 进入仓库 `Settings`。
5. 左侧选择 `Pages`。
6. Source 选择 `Deploy from a branch`。
7. Branch 选择 `main`，目录选择 `/root`。
8. 保存后等待 1-3 分钟。
9. 得到类似这样的链接：

```text
https://MRhuang1106.github.io/fast-web-help/
```

## 用脚本发布

在本文件夹里运行：

```powershell
.\publish_to_github.ps1
```

这个脚本会创建公开仓库 `fast-web-help`，推送页面，创建 `client-request` 标签，并开启 GitHub Pages。运行前请确认你愿意把页面发布到 GitHub 账号 `MRhuang1106`。
