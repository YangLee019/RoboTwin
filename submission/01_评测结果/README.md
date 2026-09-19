# 01_评测结果

`results.json` 记录 LingBot-VLA 2.0 在 RoboTwin 2.0 Aloha-AgileX 50 个任务上的闭环评测结果。

## 评测口径

- 任务集：RoboTwin 2.0 Aloha-AgileX 的 50 个任务（见 `results.json` 的 `tasks` 字段）。
- 两个 setting：`clean` 与 `randomized`。
- 每个任务测试 **100** 次，分别记录测试次数与成功次数。
- 训练数据仅使用 50 个任务的 clean 数据（每任务 50 条）；randomized 数据只用于评测，不参与训练。
- 运行栈为 AMD ROCm + MPLib + `expert_check=true`，不要与 CUDA + CuRobo 的结果直接比较，报告里需注明。

## 字段说明

| 字段 | 说明 |
| --- | --- |
| `team_name` / `team_id` | 队伍名称与天池队伍 ID |
| `checkpoint` | 产生该结果的 checkpoint 标识 |
| `eval.episodes_per_task` | 每个任务的测试次数 |
| `tasks` | 50 个任务名，顺序与官方任务列表一致 |
| `successes.clean` | 各任务在 clean setting 下的成功次数 |
| `successes.randomized` | 各任务在 randomized setting 下的成功次数 |

`episodes_per_task` 与 `successes` 的组合即可推出成功次数/测试次数。如果官方模板要求展开成 `{task, episodes, successes}` 的数组形式，按官方模板改写即可。

## 生成方式

评测结果由 `02_代码材料/eval.sh` 在多卡 benchmark 流程中产出，汇总脚本见 `04_复现与调优说明/reproduction_report.md`。
