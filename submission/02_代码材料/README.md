# 02_代码材料

本目录汇总本次参赛的实现代码、训练脚本、评测脚本与配置。

| 路径 | 内容 |
| --- | --- |
| `train.sh` | 训练入口，封装全参数 SFT / LoRA 的实际命令 |
| `eval.sh` | 评测入口，封装闭环 benchmark 的实际命令 |
| `configs/` | 训练与评测配置（`lingbotvla_cli.yaml` 等） |
| `src/` | 自行实现的代码改动 |

## 与仓库其它部分的对应关系

本仓库是 RoboTwin 的 fork，基线固定在 `266f3aa`，并在其上叠加了 AMD ROCm 复现改动：

- `envs/_base_task.py`、`envs/robot/planner.py`、`envs/robot/robot.py`
- `scripts/eval_policy_xpolicylab.py`
- `experiments/lingbot_vla_v2_6b_robotwin/scripts/`、`experiments/lingbot_vla_v2_6b_robotwin/training/`
- `RoboTwin_ROCm_Reproduction.ipynb`

`src/` 只放**超出该基线**的自研改动；基线改动直接引用仓库中的路径，不必复制一份。

## 提交前检查

- [ ] `train.sh` 与 `eval.sh` 能在干净实例上跑通
- [ ] `configs/` 中的超参与最终评测结果所用的 checkpoint 一致
- [ ] 所有路径不依赖个人实例的临时目录
