# chgdiv6

#### 介绍
chgdiv6命令是一个六爻占卜命令，其CHAT版本可以提供对话服务。当你疑惑不解时接入秘塔AI进行搜索。
CHGDIV6:chgdiv6 is a unique tool that combines traditional Chinese divination with modern data analysis. It allows users to start the divination process based on either the current time or a number they provide. The command then provides the divination result and selects corresponding I Ching hexagram or line statements using Zhu Xi's method. 
CHGDIV6_CHAT:Based on the conventional chgdiv6 command, a link to Mit AI search has been added, and the divination results are automatically entered as prompt words. You can click to continue asking.

#### 软件架构
随机数生成
random number


#### 安装教程

```Stata
net install chgdiv6, from(https://github.com/chenshaoxuemei/chgdiv6/raw/master) replace
```

#### 使用说明

```Stata
chgdiv6_chat [数字] -根据数字起卦
chgdiv6_chat -根据时间起卦
chgdiv6_chat [文字] -根据文字/测字起卦
chgdiv6 [数字] -根据数字起卦
chgdiv6 -根据时间起卦
chgdiv6 [文字] -根据文字/测字起卦
```

#### 注意事项
数字起卦更好哦
