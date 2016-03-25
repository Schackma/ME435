classdef BankAccount < handle
    %BANKACCOUNT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name
        balance
        interestRate
    end
    
    methods
        function obj =  BankAccount(name,balance,interestRate)
            obj.name = name;
            obj.balance = balance;
            obj.interestRate = interestRate;
        end
        
        function deposit(obj,amount)
            obj.balance=obj.balance+amount;            
        end
        
        function withdraw(obj,amount)
            obj.balance = obj.balance-amount;
        end
        
        function disp(obj)
            fprintf('Name: %s  Balance $%.2f  interestRate %d%%\n\n',obj.name,obj.balance,obj.interestRate); 
        end
        
        function accumulateInterest(obj)
           obj.balance = obj.balance*(1 + obj.interestRate/100); 
        end
        
    end
    
end

