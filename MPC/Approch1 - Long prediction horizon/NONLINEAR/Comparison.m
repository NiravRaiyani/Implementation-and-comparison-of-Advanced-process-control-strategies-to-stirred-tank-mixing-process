clc;
clear all;
close all;

load X1;
load X2;

figure(1)
subplot(1,2,1)
plot(0:35,X1(:,1),'-',0:35,X2(:,1),'^')
subplot(1,2,2)
plot(0:35,X1(:,2),'-',0:35,X2(:,2),'^')