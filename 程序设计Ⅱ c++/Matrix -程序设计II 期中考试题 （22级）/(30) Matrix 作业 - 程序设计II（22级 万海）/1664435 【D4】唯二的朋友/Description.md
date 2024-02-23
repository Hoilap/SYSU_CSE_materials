# 【D4】唯二的朋友

## 问题描述
给定有关每个人的朋友的信息。按名称排序并打印正好由两个人共享的朋友。

在给定的朋友列表中，每一行都以一个人的名字开头，后面是这个人的朋友的名字。
有10个人，每个人有10个朋友。
在这个问题中，你需要写一个类FriendsFinder3。

## 样例输入

Collins Smith Perez Allen Brown Carter Jackson Rodriguez Young Evans Lopez
Wilson Martin Williams Hall Lee Thompson Baker Campbell Evans Brown King
Jones Jackson Lee Martinez Williams Thomas Moore Carter Thompson Hernandez Lopez
Turner Roberts Miller Robinson Taylor Anderson Rodriguez Hernandez Wright Adams Phillips
Lewis Hall Young Garcia Jackson Lopez Williams Miller Taylor White Johnson
Evans Allen Miller White Smith Parker Phillips Brown Carter Collins Mitchell
Adams King Smith Davis Gonzalez Clark Miller Martin Jones Martinez Walker
Scott Nelson Garcia Collins Anderson Hall Adams Walker Hill Allen Moore
Baker Harris Collins Miller Mitchell Hill Lee Rodriguez Nelson Lewis Wilson
Miller Anderson Hall Clark Evans Wright Young Lee Walker Allen Johnson

## 样例输出

Baker Campbell Davis Gonzalez Harris Jones Lewis Parker Perez Roberts Robinson Thomas Wilson

## 提示

实现`()`运算符重载。
输出正好是两个共有的朋友的名字，注意名字按字典序输出，末尾有空格。

