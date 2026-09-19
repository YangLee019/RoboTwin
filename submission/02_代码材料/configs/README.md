# configs

放置本次提交使用的训练与评测配置，至少包含：

- `lingbotvla_cli.yaml`：LingBot-VLA 训练配置（来自 `experiments/lingbot_vla_v2_6b_robotwin/training/`）
- 评测使用的 benchmark 配置
- 与最终 checkpoint 对应的超参记录

提交前确认配置与 `01_评测结果/results.json` 中 `checkpoint` 字段指向的权重一致。
