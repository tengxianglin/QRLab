# QRLab

**QRLab** is a MATLAB toolbox for exploring quantum information processing and quantum resource theory.
QRLab 是一个基于 MATLAB 的工具箱，用于研究量子信息处理与量子资源理论。

## Features | 功能
- High-level modules for entanglement, coherence, magic, quasi-probability error mitigation, supermaps, and seesaw algorithms.
- 覆盖纠缠、相干、魔态、拟概率误差消除、超映射与 seesaw 等模块，便于科研与教学快速上手。

- **Entanglement Theory** | 纠缠理论
    - *Static Entanglement Measure*: Tempered Logarithmic Negativity $E_{\mathrm{\tau}}$, Rains Bound $R$, MaxRainsEntropy $R_{\mathrm{max}}$, Logarithmic Negativity $E_\text{N}$, $E_{\mathrm{PPT}}$, $E_{\mathrm{eta}}$
    - 静态纠缠度量：调温对数负性（$E_{\tau}$）、Rains 界（$R$）、MaxRains 熵（$R_{\mathrm{max}}$）、对数负性（$E_N$）、$E_{\mathrm{PPT}}$、$E_{\mathrm{eta}}$
    - *Dynamic Entanglement Measure*: Max Logarithmic Negativity, Max Rains information
    - 动态纠缠度量：最大对数负性、最大 Rains 信息
    - *Quantum Capacity*
    - 量子容量工具

- **Coherence Theory** | 相干理论
    - *Static Coherence Measure*: Robustness of Coherence
    - 静态相干度量：相干鲁棒性
    - *Channel Simulation*: Simulating non-free operations via resource states
    - 通道模拟：通过资源态模拟非自由操作

- **Magic Theory** | 魔态理论
    - *Static Magic Measure*: Robustness of Magic (qubit), Magic Mana (qudit), max/min Thuama (qudit) 
    - 静态魔态度量：魔态鲁棒性（量子比特）、Mana（多能级）、最大/最小 Thuama（多能级）
    - *Representative Magic State Generation*
    - 代表性魔态态制备

- **Quasi-Theory** | 拟概率误差消除
    - Probabilistic error cancelation 
    - 概率性误差抵消
    - Observable dependent probabilistic error cancellation 
    - 依赖可观测量的概率性误差抵消
    - Observable dependent deterministic error cancelation 
    - 依赖可观测量的确定性误差抵消
    - Circuit Knitting 
    - 电路编织（拆分与拼接）
    - Virtual Recovery
    - 虚拟恢复

- **Supermap** | 超映射
    - Quantum Switch (both kraus and choi), Apply Quantum Switch
    - 量子开关（Kraus 与 Choi 形式），应用量子开关
    - Link Product
    - 连接积（Link Product）

- **Seesaw Algorithms** | Seesaw 算法（非凸问题的次优解）
    - CHSH game 
    - CHSH 博弈
    - LOCC protocol
    - LOCC 协议

- **Extra Functions** | 其他函数
    - Conditional quantum mutual information 
    - 条件量子互信息

API reference: https://quairkit.com/QRLab
API 文档：https://quairkit.com/QRLab

## Requirements | 运行环境
- MATLAB (desktop) | MATLAB 桌面版
- QETLAB == 0.9 | QETLAB 版本 0.9
- CVX == 2.1 | CVX 版本 2.1

## Installation | 安装
1. Clone QRLab to your local machine. | 将 QRLab 克隆到本地。
2. Download QETLAB 0.9: https://qetlab.com/ | 下载 QETLAB 0.9：https://qetlab.com/
3. Add QRLab and QETLAB to the MATLAB path: | 将 QRLab 与 QETLAB 加入 MATLAB 路径：
```matlab
addpath(genpath('...\QETLAB-0.9'));
addpath(genpath('...\QRLab'));
savepath; % optional: persist paths
```
4. Install CVX 2.1: https://cvxr.com/cvx/ | 安装 CVX 2.1：https://cvxr.com/cvx/
- Windows:
```matlab
cd yourpath\cvx;
cvx_setup;
```
- Linux/macOS:
```matlab
cd ~/MATLAB/cvx;
cvx_setup;
```
5. (Optional) For full magic qubit functionality, install channel_magic 2.0: | （可选）若需完整的魔态（量子比特）功能，请安装 channel_magic 2.0：
- https://github.com/jamesrseddon/channel_magic

## Quick Start | 快速开始
Verify your setup with a simple entanglement calculation: | 通过一个简单的纠缠度量验证环境是否就绪：
```matlab
% Create a 2-qubit maximally entangled state (Bell state)
% 构造一个两比特最大纠缠态（Bell 态）
rho = MaxEntangled(2) * MaxEntangled(2)'; % from QETLAB / 来自 QETLAB
LN = LogNeg(rho);                          % from QRLab  / 来自 QRLab
disp('Logarithmic Negativity (expected ~1 for Bell state):');
disp(LN);
```
If LN is close to 1, the setup works. | 若 LN 接近 1，则环境配置成功。

## Usage and Examples | 使用与示例
- Function help in MATLAB: | 在 MATLAB 中查看函数帮助：
```matlab
help LogNeg
```
- Explore additional functions via the API docs: https://quairkit.com/QRLab
- 通过 API 文档查看更多函数与示例：https://quairkit.com/QRLab
- Many features follow a consistent interface; see docs for arguments and options.
- 多数功能遵循一致的函数接口；参数与可选项请参考文档。

## Troubleshooting | 故障排查
- Paths not set or missing functions: | 路径未设置或找不到函数：
  ```matlab
  addpath(genpath('...\QETLAB-0.9'));
  addpath(genpath('...\QRLab'));
  which LogNeg -all
  which MaxEntangled -all
  ```
- CVX not initialized: run cvx_setup. | CVX 未初始化：运行 cvx_setup。
- Version mismatches: ensure QETLAB 0.9 and CVX 2.1. | 版本不匹配：确认 QETLAB 0.9、CVX 2.1。
- Magic functions unavailable: install channel_magic 2.0. | 魔态相关函数不可用：安装 channel_magic 2.0 并加入路径。

If issues persist, compare steps with Installation and Quick Start, then consult the API docs.
若问题仍在，请复核安装与快速开始步骤，并查阅 API 文档。

## Contributing | 贡献
- Open an issue for bugs/features. | 提交 Issue 描述缺陷或新功能。
- Fork, create a feature branch, and open a PR. | Fork 仓库、创建分支并提交 PR。
- Add concise tests/examples where appropriate. | 视情况补充简要示例或测试。

## Acknowledgements | 致谢
The development of the software package is partially supported by the National Key R&D Program of China (Grant No. 2024YFE0102500).
本软件包的开发部分得到了中国国家重点研发计划（项目编号：2024YFE0102500）的资助。

We acknowledge the CVXQUAD package (https://github.com/hfawzi/cvxquad) for MATLAB-based convex optimization utilities including von Neumann entropy and quantum relative entropy, which have been valuable in this research.
感谢 CVXQUAD（https://github.com/hfawzi/cvxquad）提供的基于 MATLAB 的凸优化工具（如冯诺依曼熵、量子相对熵），对本项目研究帮助甚大。
