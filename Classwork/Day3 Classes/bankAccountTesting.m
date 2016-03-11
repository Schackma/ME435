clear all
close all
clc


bobAccount = BankAccount('Bob',100,.1);

daveAccount = BankAccount('Dave',200,.2);

bobAccount.deposit(50);
bobAccount.withdraw(1);
bobAccount.accumulateInterest;

bobAccount
daveAccount