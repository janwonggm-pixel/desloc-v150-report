# DESLOC V150 Plus 报告固定链接部署说明

本目录已经整理成“固定在线链接”模式。核心思路是：线上只发布 `docs/index.html`，以后报告更新时仍然覆盖同一个文件，公开 URL 不变。

## 文件说明

- `docs/index.html`：线上访问的首页，内容来自当前分享版 HTML。
- `sync_share_site.ps1`：同步脚本，会自动寻找分享版 HTML，并复制到 `docs/index.html`。
- `docs/.nojekyll`：让 GitHub Pages 不使用 Jekyll 处理页面，避免中文文件或静态资源出现兼容问题。

## 推荐方式：GitHub Pages

1. 创建或选择一个 GitHub 仓库。
2. 把当前目录推送到该仓库。
3. 在 GitHub 仓库里打开 `Settings > Pages`。
4. Source 选择 `Deploy from a branch`。
5. Branch 选择 `master` 或 `main`，Folder 选择 `/docs`。
6. 保存后，GitHub 会生成一个固定 URL。

之后每次更新报告，只需要：

```powershell
.\sync_share_site.ps1
git add docs/index.html DESLOC_V150_Plus_众筹营销调研报告_链接版.html
git commit -m "Update DESLOC V150 report"
git push
```

公开 URL 不变，别人刷新页面即可看到最新版。
