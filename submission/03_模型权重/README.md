# 03_模型权重

把与 `01_评测结果/results.json` 对应的 checkpoint 放在 `checkpoint/` 下。

约定：

- 目录名保持 `checkpoint/`，内部结构保持可直接加载的形式。
- 若权重由 DCP 转换而来，保留转换后的 Hugging Face 格式 checkpoint，并在 `04_复现与调优说明/` 中写明转换命令。
- 权重默认被 `.gitignore` 忽略，只进入提交 Zip，不进 Git。需要纳入版本管理时用 `git add -f`。

清单（提交前补全）：

| 项目 | 内容 |
| --- | --- |
| checkpoint 来源 | 全参数 SFT / LoRA |
| 训练步数 | |
| 全局 batch | |
| 基座模型 | `robbyant/lingbot-vla-v2-6b` |
| 文件大小 | |
