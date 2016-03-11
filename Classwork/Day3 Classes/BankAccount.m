classdef BankAccount < handle
    %BANKACCOUNT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name
        balance
        interest
    end
    
    methods
        function obj =  BankAccount(name,balance,interest)
            obj.name = name;
            obj.balance = balance;
            obj.interest = interest;
        end
        
        function deposit(obj,amount)
            obj.balance=obj.balance+amount;            
        end
        
        function withdraw(obj,amount)
            obj.balance =obj.balance-amount;
            
        end
        
        function accumulateInterest(obj)
            obj.balance = obj.balance*(1+obj.interest);
        end
        
        function disp(obj)
            fprintf('Name: %s  Balance $%.2f  Interest %.2f%%\n\n',obj.name,obj.balance,obj.interest*100); 
        end
        
    end
    
end

