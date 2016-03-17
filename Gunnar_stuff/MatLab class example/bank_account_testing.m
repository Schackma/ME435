clc; clear; close all;

bobAccount = BankAccount('Bob',100,1);
daveAccount = BankAccount('Dave',200,0);

bobAccount.accumulateInterest();
bobAccount.deposit(50);
bobAccount.withdraw(1);

bobAccount
daveAccount