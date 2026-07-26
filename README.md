# 海克斯科技 (Hextech)

基于《英雄联盟》海克斯强化机制的《以撒的结合》模组。每层开局三选一，构筑你的海克斯羁绊。

---

## 玩法

- 每进入新的一层，起始房间出现 **3 个底座道具**
- 玩家只能选择 **其中 1 个**，拾取后其余道具消失
- 每层从 **白银 / 黄金 / 棱彩** 三个品质池中随机抽取
- 高等级道具更稀有（加权抽选，不放回），3 个道具不重复
- 对所有角色生效

---

## 道具列表（部分）

### 白银阶

| 道具         | 等级 | 效果                                  |
| ------------ | ---- | ------------------------------------- |
| 大力         | 1    | 攻击力 +20%                           |
| 灵巧         | 1    | 攻击速度 +20%                         |
| 属性         | 1    | 随机获得伤害/射速/移速/弹速/射程 2 次 |
| 质变：黄金阶 | 2    | 移除自身，随机获得 1 个黄金阶道具     |

### 黄金阶

| 道具         | 等级 | 效果                              |
| ------------ | ---- | --------------------------------- |
| 一板一眼     | 2    | 移速→射速，溢出射速→伤害          |
| 属性叠属性   | 3    | 随机获得 3 次属性加成             |
| 质变：棱彩阶 | 3    | 移除自身，随机获得 1 个棱彩阶道具 |
| 星界躯体     | 3    | 获得 4 心之容器+4 红心，伤害 ×0.8 |
| 尖端发明家   | 3    | 主动道具获得充能时额外 +1 充能    |

### 棱彩阶

| 道具             | 等级 | 效果                                |
| ---------------- | ---- | ----------------------------------- |
| 踢踏舞           | 3    | 移速转射速                          |
| 属性叠属性叠属性 | 4    | 随机获得 4 次属性加成               |
| 质变：混沌       | 4    | 移除自身，随机获得 2 个任意品质道具 |
| 珠光护手         | 4    | 每秒随机伤害倍率 1.50~2.25          |

---

## 伤害管线

所有道具的属性修改按 **加算 → 乘算** 顺序统一处理，不同道具之间不会互相覆盖。

---

## 安装

1. 将模组文件夹放入 `mods` 目录
2. 在游戏中启用模组
3. 开始新游戏即可体验

---

## 兼容性

- 集成 [EID](https://steamcommunity.com/sharedfiles/filedetails/?id=836319872) 中文 / 英文描述
- 兼容眼泪、刀、激光等所有攻击方式
- 不修改原版道具，与大多数模组兼容

---

## 许可证

MIT License

---

# Hextech

A Binding of Isaac mod inspired by the Hextech augment system from League of Legends. Pick one of three at the start of each floor and build your Hextech synergies.

---

## Gameplay

- At the start of each new floor, **3 pedestal items** appear in the starting room
- The player may only pick **1 of them** — the other two disappear
- Each floor draws from a random quality tier: **Silver / Gold / Prismatic** (equal chance)
- Higher level items are rarer (weighted draw, no replacement), and the 3 items never repeat
- Works for all characters

---

## Item List (Partial)

### Silver Tier

| Item            | Level | Effect                                                    |
| --------------- | ----- | --------------------------------------------------------- |
| Blunt Force     | 1     | Damage +20%                                               |
| Deft            | 1     | Tears +20%                                                |
| Stats           | 1     | Randomly gain Damage/Tears/Speed/Shot Speed/Range 2 times |
| Transmute: Gold | 2     | Remove itself, gain 1 random Gold tier item               |

### Gold Tier

| Item                 | Level | Effect                                                     |
| -------------------- | ----- | ---------------------------------------------------------- |
| Slow and Steady      | 2     | Speed → Tears, excess Tears → Damage                       |
| Stats on Stats       | 3     | Randomly gain stat bonuses 3 times                         |
| Transmute: Prismatic | 3     | Remove itself, gain 1 random Prismatic tier item           |
| Celestial Body       | 3     | Gain 4 Heart Containers + 4 Red Hearts, Damage ×0.8        |
| Apex Inventor        | 3     | Active item gains +1 extra charge whenever it gains charge |

### Prismatic Tier

| Item                    | Level | Effect                                                   |
| ----------------------- | ----- | -------------------------------------------------------- |
| Tapdancer               | 3     | Speed → Tears                                            |
| Stats on Stats on Stats | 4     | Randomly gain stat bonuses 4 times                       |
| Transmute: Chaos        | 4     | Remove itself, gain 2 random items of any tier           |
| Jeweled Gauntlet        | 4     | Random damage multiplier 1.50~2.25, changes every second |

---

## Damage Pipeline

All stat modifications are processed in a unified **additive → multiplicative** order, preventing different items from overwriting each other.

---

## Installation

1. Place the mod folder into your `mods` directory
2. Enable the mod in-game
3. Start a new run to play

---

## Compatibility

- Integrated [EID](https://steamcommunity.com/sharedfiles/filedetails/?id=836319872) Chinese / English descriptions
- Compatible with all attack types: tears, knives, lasers, etc.
- Does not modify vanilla items, compatible with most mods

---

## License

MIT License
